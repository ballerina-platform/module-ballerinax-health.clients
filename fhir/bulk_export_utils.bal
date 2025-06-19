// Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com).

// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at

// http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/file;
import ballerina/ftp;
import ballerina/http;
import ballerina/io;
import ballerina/log;
import ballerina/task;

final string Path_Seperator = file:pathSeparator;

isolated function executeJob(PollingTask job, decimal interval) returns task:JobId|error? {
    task:JobId id = check task:scheduleJobRecurByFrequency(job, interval);
    job.setId(id);
    return id;
}

function unscheduleJob(task:JobId id) returns error? {
    log:printDebug("Unscheduling the job.", Jobid = id);
    task:Error? unscheduleJob = task:unscheduleJob(id);
    if unscheduleJob is task:Error {
        log:printError("Error occurred while unscheduling the job.", unscheduleJob);
    }
    return null;
}

function getFileAsStream(string downloadLink, http:Client statusClientV2) returns stream<byte[], io:Error?>|error? {
    http:Response|http:ClientError statusResponse = statusClientV2->get("/");
    if statusResponse is http:Response {
        int status = statusResponse.statusCode;
        if status == 200 {
            return check statusResponse.getByteStream();
        } else {
            log:printError("Error occurred while getting the status.");
        }
    } else {
        log:printError("Error occurred while getting the status.", statusResponse);
    }
    return null;
}

function saveFileInFS(string downloadLink, string fileName) returns error? {
    http:Client statusClientV2 = check new (downloadLink);
    stream<byte[], io:Error?> streamer = check getFileAsStream(downloadLink, statusClientV2) ?: new ();
    check io:fileWriteBlocksFromStream(fileName, streamer);
    check streamer.close();
    log:printDebug(string `Successfully downloaded the file. File name: ${fileName}`);
}

function sendFileFromFSToFTP(TargetServerConfig config, string sourcePath, string fileName) returns error? {
    ftp:Client fileClient = check new ({
        host: config.host,
        auth: {
            credentials: {
                username: config.username,
                password: config.password
            }
        }
    });
    stream<io:Block, io:Error?> fileStream
        = check io:fileReadBlocksAsStream(sourcePath, 1024);
    check fileClient->put(string `${config.directory}/${fileName}`, fileStream);
    check fileStream.close();
}

function downloadFiles(json exportSummary, string exportId, string tempDirectory, TargetServerConfig targetServerConfig) returns error? {
    ExportSummary exportSummary1 = check exportSummary.cloneWithType(ExportSummary);
    foreach OutputFile item in exportSummary1.output {
        log:printDebug("Downloading the file.", url = item.url);
        error? downloadFileResult = saveFileInFS(item.url, string `${tempDirectory}${Path_Seperator}${exportId}${Path_Seperator}${item.'type}-exported.ndjson`);
        if downloadFileResult is error {
            log:printError("Error occurred while downloading the file.", downloadFileResult);
        }

        if targetServerConfig.'type == "ftp" {
            // download the file to the FTP server
            error? uploadFileResult = sendFileFromFSToFTP(targetServerConfig, string `${tempDirectory}${Path_Seperator}${item.'type}-exported.ndjson`, string `${item.'type}-exported.ndjson`);
            if uploadFileResult is error {
                log:printError("Error occurred while sending the file to ftp.", downloadFileResult);
            }
        }
    }
    lock {
        updateExportTaskStatusInMemory(taskMap = exportTasks, exportTaskId = exportId, newStatus = "Downloaded");
    }
    log:printInfo("All files downloaded successfully.");
    return null;
}

function addQueryParam(string queryString, string key, string value) returns string {
    if queryString == "" {
        return string `?${key}=${value}`;
    } else {
        return string `${queryString}&${key}=${value}`;
    }
}

class PollingTask {
    *task:Job;
    string exportId;
    string lastStatus;
    string location;
    string tempDirectory;
    TargetServerConfig? targetServerConfig;
    task:JobId jobId = {id: 0};

    public function execute() {
        do {
            http:Client statusClientV2 = check new (self.location);
            log:printDebug("Polling the export task status.", exportId = self.exportId);
            if self.lastStatus == "In-progress" {
                http:Response|http:ClientError statusResponse;
                statusResponse = statusClientV2->/;
                addPollingEvent addPollingEventFuntion = addPollingEventToMemory;
                if statusResponse is http:Response {
                    int status = statusResponse.statusCode;
                    if status == 200 {
                        self.setLastStaus("Completed");
                        lock {
                            updateExportTaskStatusInMemory(taskMap = exportTasks, exportTaskId = self.exportId, newStatus = "Export Completed. Downloading files.");
                        }
                        json payload = check statusResponse.getJsonPayload();
                        log:printDebug("Export task completed.", exportId = self.exportId, payload = payload);
                        error? unscheduleJobResult = unscheduleJob(self.jobId);
                        if unscheduleJobResult is error {
                            log:printError("Error occurred while unscheduling the job.", unscheduleJobResult);
                        }

                        // download the files
                        if self.targetServerConfig is TargetServerConfig {
                            log:printDebug("Target server configuration is provided. Downloading files to the target server.");
                            error? downloadFilesResult = downloadFiles(payload, self.exportId, self.tempDirectory, <TargetServerConfig>self.targetServerConfig);
                            if downloadFilesResult is error {
                                log:printError("Error in downloading files", downloadFilesResult);
                            }
                        } else {
                            log:printError("Target server configuration is not provided. Cannot download files.");
                        }

                        removeExportTaskFromMemory(self.exportId);
                    } else if status == 202 {
                        log:printDebug("Export task in-progress.", exportId = self.exportId);
                        string progress = check statusResponse.getHeader(X_PROGRESS);
                        PollingEvent pollingEvent = {id: self.exportId, eventStatus: "Success", exportStatus: progress};
                        lock {
                            boolean _ = addPollingEventFuntion(exportTasks, pollingEvent.clone());
                        }
                        self.setLastStaus("In-progress");
                    }
                } else {
                    log:printError("Error occurred while getting the status.", statusResponse);
                    lock {
                        PollingEvent pollingEvent = {id: self.exportId, eventStatus: "Failed"};
                        boolean _ = addPollingEventFuntion(exportTasks, pollingEvent.cloneReadOnly());
                    }
                }
            } else if self.lastStatus == "Completed" {
                log:printDebug("Export task completed.", exportId = self.exportId);
            }
        } on fail var e {
            log:printError("Error occurred while polling the export task status.", e);
        }
    }

    isolated function init(string exportId, string location, string tempDirectory, string lastStatus = "In-progress", TargetServerConfig? config = ()) {
        self.exportId = exportId;
        self.lastStatus = lastStatus;
        self.location = location;
        self.tempDirectory = tempDirectory;
        self.targetServerConfig = config;
    }

    function setLastStaus(string newStatus) {
        self.lastStatus = newStatus;
    }

    isolated function setId(task:JobId jobId) {
        self.jobId = jobId;
    }
}

isolated function submitBackgroundJob(string taskId, string location, decimal defaultIntervalInSec, string tempDirectory, TargetServerConfig? targetServerConfig) {
    do {
        task:JobId|() _ = check executeJob(
                new PollingTask(
                    exportId = taskId,
                    location = location,
                    tempDirectory = tempDirectory,
                    config = targetServerConfig
                ),
                defaultIntervalInSec);
        log:printDebug("Polling location recieved: " + location);
    } on fail var e {
        log:printError("Error occurred while getting the location or scheduling the Job", e);
    }
}

isolated function removeData(string exportId, string tempDirectory) returns error? {
    log:printDebug("Removing data for export id: " + exportId);
    removeExportTaskFromMemory(exportId);
    string directoryPath = string `${tempDirectory}${Path_Seperator}${exportId}`;
    if check file:test(directoryPath, file:EXISTS) {
        check file:remove(directoryPath, file:RECURSIVE);
        log:printDebug("Temporary directory removed successfully.", tempDirectory = tempDirectory);
    } else {
        log:printDebug("Temporary directory does not exist.", tempDirectory = tempDirectory);
    }
}
