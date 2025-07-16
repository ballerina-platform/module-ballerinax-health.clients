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
import ballerina/mime;
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

function sendFileFromFSToFTP(ftp:Client fileClient, string fsFilePath, string ftpFilePath) returns error? {
    stream<io:Block, io:Error?> fileStream = check io:fileReadBlocksAsStream(fsFilePath, 1024);
    check fileClient->put(ftpFilePath, fileStream);
    check fileStream.close();
}

function downloadFiles(json exportSummary, string exportId, BulkExportConfig config) returns error? {
    ExportSummary exportSummary1 = check exportSummary.cloneWithType(ExportSummary);
    string export_directory = config.localDirectory;
    ftp:Client? fileClient = ();

    if config.fileServerType == "ftp" {
        fileClient = check new ({
            host: config.fileServerUrl,
            port: config.fileServerPort,
            auth: {
                credentials: (config.fileServerUsername != "") ? {
                        username: config.fileServerUsername,
                        password: config.fileServerPassword
                    } : ()
            }
        });
    }

    foreach OutputFile item in exportSummary1.output {
        log:printDebug("Downloading the file.", url = item.url);

        string fsFilePath = string `${export_directory}${PATH_SEPARATOR}${exportId}${PATH_SEPARATOR}${item.'type}-exported.ndjson`;
        error? downloadFileResult = saveFileInFS(item.url, fsFilePath);
        if downloadFileResult is error {
            log:printError("Error occurred while downloading the file.", downloadFileResult);
            continue;
        }

        if config.fileServerType == "ftp" {
            if fileClient is () {
                continue;
            }
            // path of the ftp server where the file will be uploaded
            string ftpFilePath = string `${config.fileServerDirectory}/${exportId}/${item.'type}-exported.ndjson`;
            error? uploadFileResult = sendFileFromFSToFTP(<ftp:Client>fileClient, fsFilePath, ftpFilePath);
            if uploadFileResult is error {
                log:printError("Error occurred while sending the file to ftp. " + uploadFileResult.message());
            } else {
                log:printDebug("File sent to FTP server successfully.", file = string `${item.'type}-exported.ndjson`);
            }
        } else if config.fileServerType == "fhir" {
            // TODO: Implement FHIR repository/DB syncing functionality
            // 1. Deduplication mechanism for exported FHIR resources
            // 2. Maintaining traceability to original source systems
            // 3. Data validation and transformation processes
            // 4. Conflict resolution strategies for overlapping data
            // Until these syncing pre-requisites are finalized, the operation
        }
    }
    lock {
        updateExportTaskStatusInMemory(taskMap = exportTasks, exportTaskId = exportId, newStatus = "Downloaded");
    }
    log:printInfo("All files downloaded successfully.");
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
                        log:printDebug("Export task completed.", exportId = self.exportId, payload = payload);
                        error? unscheduleJobResult = unscheduleJob(self.jobId);
                        if unscheduleJobResult is error {
                            log:printError("Error occurred while unscheduling the job.", unscheduleJobResult);
                        }

                        // download the files
                        log:printDebug("Target server configuration is provided. Downloading files to the target server.");
                        error? downloadFilesResult = downloadFiles(payload, self.exportId, self.bulkExportConfig);
                        if downloadFilesResult is error {
                            log:printError("Error in downloading files. " + downloadFilesResult.message());
                        }

                        log:printDebug("Removing the export task from memory and local directory after expiry.");
                        removeExportTaskFromMemory(self.exportId, self.bulkExportConfig.tempFileExpiryTime);

                        // Remove the data after expiry
                        _ = start removeData(self.exportId, self.bulkExportConfig.localDirectory, self.bulkExportConfig.tempFileExpiryTime);

                        lock {
                            updateExportTaskStatusInMemory(taskMap = exportTasks, exportTaskId = self.exportId, newStatus = "Export Completed. Files Downloaded.");
                        }
                        log:printDebug("Export task completed and files downloaded.", exportId = self.exportId);

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
            if check file:test(config.localDirectory, file:EXISTS) {
                log:printDebug("Local directory exists.", localDirectory = config.localDirectory);
            } else {
                check file:createDir(config.localDirectory, file:RECURSIVE);
                log:printDebug("Local directory created successfully.", localDirectory = config.localDirectory);
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

isolated function getExportedFileUrls(string exportId, BulkExportConfig config) returns map<json>|error {
    string directoryPath = string `${config.localDirectory}${PATH_SEPARATOR}${exportId}`;
    if !check file:test(directoryPath, file:EXISTS) {
        log:printDebug("Exported files not found for exportId: " + exportId);
        return error(string `Exported files not found for exportId: ${exportId}, May be the export is not completed yet or the files have been removed.`);
    }

    json[] output = [];
    if config.fileServerType == "ftp" {
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

            output.push({
                "url": fileData.friendlyURI,
                "type": resourceType
            });
        }
    } else {
        file:MetaData[] exportedDir = check file:readDir(directoryPath);

        foreach file:MetaData exportedFile in exportedDir {
            string[] nonEmptyParts = regex:split(exportedFile.absPath, "\\\\").filter(s => s != "");
            string lastPart = nonEmptyParts[nonEmptyParts.length() - 1];

            // get the resource type from the file name
            string resourceType = regex:split(lastPart, "-exported.ndjson")[0];

            string absPath = exportedFile.absPath;
            output.push({
                "url": regex:replaceAll(absPath, "\\\\", PATH_SEPARATOR),
                "type": resourceType
            });
        }
    }

    time:Utc expiryTime = check getExpiryTimeForExportTask(exportId);

    return {
        "exportId": exportId,
        "expiryTime": time:utcToString(expiryTime),
        "output": output
    };
}

isolated function getExportedFile(string exportId, string resourceType, string export_directory) returns FHIRBulkFileResponse|error {
    // check if the exportId is valid
    time:Utc|error exportTaskExpiryTask = getExpiryTimeForExportTask(exportId);
    if exportTaskExpiryTask is error {
        return error(string `Export task not found for exportId: ${exportId}, ${BULK_EXPORT_NOT_COMPLETED_OR_REMOVED}`);
    }

    string filePath = string `${export_directory}${PATH_SEPARATOR}${exportId}${PATH_SEPARATOR}${resourceType}-exported.ndjson`;

    if !check file:test(filePath, file:EXISTS) {
        return error(string `Exported file not found for exportId: ${exportId} and resourceType: ${resourceType}, ${BULK_EXPORT_NOT_COMPLETED_OR_REMOVED}`);
    }

    mime:Entity entity = new;
    entity.setFileAsEntityBody(filePath);

    http:Response response = new;
    response.setEntity(entity);
    error? contentType = response.setContentType("gzip");
    if contentType is error {
        log:printError("Error occurred while setting the content type: ");
    }
    return getBulkFileResponse(response);
}
