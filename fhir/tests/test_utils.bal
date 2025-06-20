// Copyright (c) 2023, WSO2 LLC. (http://www.wso2.com).

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

import ballerina/lang.runtime;
import ballerina/file;
import ballerina/log;
import ballerina/io;

isolated boolean isEndOfExport = false;

type Export record {
    string exportId;
    string pollingUrl;
};

isolated function waitForPatientExport() {
    worker waitForExport {
        runtime:sleep(3);
    }

    wait waitForExport;

    lock {
        isEndOfExport = true;
    }
}

isolated function createExportFile(string exportId) returns error? {
    string fileName = DEFAULT_EXPORT_DIRECTORY + Path_Seperator + exportId + Path_Seperator + PATIENT + "-exported.ndjson";
    check file:createDir(DEFAULT_EXPORT_DIRECTORY + Path_Seperator + exportId, file:RECURSIVE);
    check file:create(fileName);
    
    log:printDebug("Export file created successfully.", fileName = fileName);

    check io:fileWriteBytes(fileName, testBulkExportFileData.toBytes());
}
