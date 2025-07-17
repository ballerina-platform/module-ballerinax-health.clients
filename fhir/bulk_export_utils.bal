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
import ballerina/lang.runtime;
import ballerina/log;
import ballerina/regex;
import ballerina/task;
import ballerina/time;

final string PATH_SEPARATOR = file:pathSeparator;

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

function uploadFileToFTP(string downloadLink, ftp:Client fileClient, string ftpFilePath) returns error? {
    log:printDebug("Uploading file to FTP server.", url = downloadLink, ftpFilePath = ftpFilePath);
    
    // download the file as a stream
    http:Client statusClientV2 = check new (downloadLink);
    stream<byte[], io:Error?> streamer = check getFileAsStream(downloadLink, statusClientV2) ?: new ();
    
    // clone the stream to make it readonly
    // This is to ensure that the stream is read-only when uploading to FTP
    // as FTP client expects a read-only stream.
    stream<byte[] & readonly, io:Error?> readOnlyStreamer = from byte[] b in streamer
        select b is byte[] & readonly ? b : b.cloneReadOnly();

    // Upload the file to FTP server
    check fileClient->put(ftpFilePath, readOnlyStreamer);

    // close the streams
    check streamer.close();
    check readOnlyStreamer.close();
}

function downloadFiles(json exportSummary, string exportId, BulkExportConfig config) returns error? {
    ExportSummary|error exportSummaryClone = exportSummary.cloneWithType(ExportSummary);
    if exportSummaryClone is error {
        return error(string `Failed to clone the export summary: ${exportSummaryClone.message()}`);
    }

    if config.fileServerType == FTP {
        ftp:Client fileClient = check new ({
            host: config.fileServerUrl,
            port: config.fileServerPort,
            auth: {
                credentials: (config.fileServerUsername != "") ? {
                        username: config.fileServerUsername,
                        password: config.fileServerPassword
                    } : ()
            }
        });
        log:printDebug("FTP client created successfully.", host = config.fileServerUrl, port = config.fileServerPort);
        int noOfFiles = exportSummaryClone.output.length();
        int completedFiles = 0;
        foreach OutputFile item in exportSummaryClone.output {
            string ftpFilePath = string `${config.fileServerDirectory}/${exportId}/${item.'type}-exported.ndjson`;
            error? uploadFileResult = uploadFileToFTP(item.url, fileClient, ftpFilePath);
            if uploadFileResult is error {
                log:printError("Error occurred while sending the file to ftp. " + uploadFileResult.message());
            } else {
                log:printDebug("File uploaded to FTP server successfully.", file = string `${item.'type}-exported.ndjson`);
            }
            lock {
                completedFiles = completedFiles + 1;
                updateExportTaskStatusInMemory(taskMap = exportTasks, exportTaskId = exportId,
                        newStatus = string `Export Completed. Downloaded ${completedFiles} out of ${noOfFiles} files to the FTP server.`);
            }
        }
    } else if config.fileServerType == FHIR {
        // TODO: Implement FHIR repository/DB syncing functionality
        // 1. Deduplication mechanism for exported FHIR resources
        // 2. Maintaining traceability to original source systems
        // 3. Data validation and transformation processes
        // 4. Conflict resolution strategies for overlapping data
        // Until these syncing pre-requisites are finalized, the operation
        log:printWarn("FHIR repository/DB syncing functionality is not implemented yet. Please check the implementation details.");
    } else {
        // download the files to the local file system
        foreach OutputFile item in exportSummaryClone.output {
            log:printDebug("Downloading the file.", url = item.url);
            string fsFilePath = string `${config.tempDirectory}${PATH_SEPARATOR}${exportId}${PATH_SEPARATOR}${item.'type}-exported.ndjson`;
            error? downloadFileResult = saveFileInFS(item.url, fsFilePath);
            if downloadFileResult is error {
                log:printError("Error occurred while downloading the file.", downloadFileResult);
                continue;
            }
            log:printDebug("File downloaded successfully.", file = string `${item.'type}-exported.ndjson`);
        }
    }
    lock {
        updateExportTaskStatusInMemory(taskMap = exportTasks, exportTaskId = exportId, newStatus = "Downloaded");
    }
    return null;
}

class PollingTask {
    *task:Job;
    string exportId;
    string lastStatus;
    string location;
    BulkExportConfig bulkExportConfig;
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
                        log:printDebug("Exporting completed, unscheduling the job and downloading files.", exportId = self.exportId);
                        error? unscheduleJobResult = unscheduleJob(self.jobId);
                        if unscheduleJobResult is error {
                            log:printError("Error occurred while unscheduling the job.", unscheduleJobResult);
                        }

                        // download the files
                        log:printDebug("Downloading files for export task.", exportId = self.exportId);
                        error? downloadFilesResult = downloadFiles(payload, self.exportId, self.bulkExportConfig);
                        if downloadFilesResult is error {
                            log:printError("Error in downloading files: " + downloadFilesResult.message());
                        }

                        if self.bulkExportConfig.fileServerType == LOCAL {
                            log:printDebug("Removing the export task from memory and local directory after expiry.");
                            removeExportTaskFromMemory(self.exportId, self.bulkExportConfig.tempFileExpiryTime);

                            // Remove the data after expiry
                            _ = start removeData(self.exportId, self.bulkExportConfig.tempDirectory, self.bulkExportConfig.tempFileExpiryTime);
                        } else {
                            log:printDebug("Removing the export task from memory.");
                            removeExportTaskFromMemory(self.exportId);
                        }

                        log:printDebug("Export task completed and files downloaded successfully.", exportId = self.exportId);
                    } else if status == 202 {
                        string progress = check statusResponse.getHeader(X_PROGRESS);
                        PollingEvent pollingEvent = {id: self.exportId, eventStatus: "Success", exportStatus: progress};
                        log:printDebug("Export task is still in progress.", exportId = self.exportId, progress = progress);
                        lock {
                            boolean _ = addPollingEventFuntion(exportTasks, pollingEvent.clone());
                        }
                        self.setLastStaus("In-progress");
                    }
                } else {
                    log:printDebug("Error occurred while getting the status.", statusResponse);
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

    isolated function init(string exportId, string location, BulkExportConfig config) {
        self.exportId = exportId;
        self.lastStatus = "In-progress";
        self.location = location;
        self.bulkExportConfig = config;

        do {
            if check file:test(config.tempDirectory, file:EXISTS) {
                log:printDebug("Local directory exists.", tempDirectory = config.tempDirectory);
            } else {
                check file:createDir(config.tempDirectory, file:RECURSIVE);
                log:printDebug("Local directory created successfully.", tempDirectory = config.tempDirectory);
            }
        } on fail var err {
            log:printError("Error occurred while creating the local directory.", err);
            panic error(string `Error occurred while creating the local directory: ${err.message()}`);
        }
    }

    function setLastStaus(string newStatus) {
        self.lastStatus = newStatus;
    }

    isolated function setId(task:JobId jobId) {
        self.jobId = jobId;
    }
}

isolated function submitBackgroundJob(string taskId, string location, BulkExportConfig config) {
    do {
        task:JobId|() _ = check executeJob(
                new PollingTask(
                    exportId = taskId,
                    location = location,
                    config = config
                ),
                config.pollingInterval);
        log:printDebug("Polling location recieved: " + location);
    } on fail var e {
        log:printError("Error occurred while getting the location or scheduling the Job", e);
    }
}

isolated function removeData(string exportId, string export_directory, decimal expiryTime) returns error? {
    log:printDebug("Removing data for export id: " + exportId + " after expiry of " + expiryTime.toString() + " seconds.");
    worker name {
        runtime:sleep(expiryTime);
    }
    wait name;

    log:printDebug("Removing data for export id: " + exportId + ", Directory: " + export_directory);
    string directoryPath = string `${export_directory}${PATH_SEPARATOR}${exportId}`;
    if check file:test(directoryPath, file:EXISTS) {
        check file:remove(directoryPath, file:RECURSIVE);
        log:printDebug("Temporary directory removed successfully.");
    } else {
        log:printDebug("Temporary directory does not exist.");
    }
    removeExpiredExportTask(exportId);
}

isolated function getExportedFileUrls(string exportId, BulkExportConfig config) returns ExportedFileUrlInfo|error {
    ExportedFileUrlInfo exportedFileUrlInfo = {
        exportId: exportId,
        output: []
    };

    if config.fileServerType == FTP {
        ftp:Client fileClient = check new ({
            host: config.fileServerUrl,
            port: config.fileServerPort,
            auth: {
                credentials: (config.fileServerUsername != "") ? {
                        username: config.fileServerUsername,
                        password: config.fileServerPassword
                    } : ()
            }
        });

        ftp:FileInfo[] fileDataList = check fileClient->list(string `${config.fileServerDirectory}/${exportId}`);

        foreach ftp:FileInfo fileData in fileDataList {
            string resourceType = regex:split(fileData.name, "-exported.ndjson")[0];

            exportedFileUrlInfo.output.push({
                url: fileData.friendlyURI,
                'type: resourceType
            });
        }
    } else if config.fileServerType == FHIR {
        // TODO: Implement FHIR repository/DB syncing functionality
        return error("FHIR repository/DB syncing functionality is not implemented yet. Please check the implementation details.");
    } else {
        string directoryPath = string `${config.tempDirectory}${PATH_SEPARATOR}${exportId}`;
        if !check file:test(directoryPath, file:EXISTS) {
            log:printDebug("Exported files not found for exportId: " + exportId);
            return error(string `Exported files not found for exportId: ${exportId}, May be the export is not completed yet or the files have been removed.`);
        }

        file:MetaData[] exportedDir = check file:readDir(directoryPath);

        foreach file:MetaData exportedFile in exportedDir {
            string[] nonEmptyParts = regex:split(exportedFile.absPath, "\\\\").filter(s => s != "");
            string lastPart = nonEmptyParts[nonEmptyParts.length() - 1];

            // get the resource type from the file name
            string resourceType = regex:split(lastPart, "-exported.ndjson")[0];

            string absPath = exportedFile.absPath;
            exportedFileUrlInfo.output.push({
                url: regex:replaceAll(absPath, "\\\\", PATH_SEPARATOR),
                'type: resourceType
            });
        }

        exportedFileUrlInfo.expiryTime = time:utcToString(check getExpiryTimeForExportTask(exportId));
    }

    return exportedFileUrlInfo;
}
