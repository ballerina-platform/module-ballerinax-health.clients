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

import ballerina/time;

//This file represents the in-memory storage of the export tasks and polling events.

final isolated map<ExportTask> exportTasks = {};
final isolated map<time:Utc> exportTaskExpiryTimes = {};

isolated function addExportTaskToMemory(map<ExportTask> taskMap, ExportTask exportTask) returns boolean {
    // add the export task to the memory
    exportTask.lastUpdated = time:utcToString(time:utcNow());
    lock {
        taskMap[exportTask.id] = exportTask;
    }
    return true;
}

isolated function addPollingEventToMemory(map<ExportTask> taskMap, PollingEvent pollingEvent) returns boolean {
    // add the polling event to the memory
    ExportTask exportTask = taskMap.get(pollingEvent.id);
    exportTask.lastUpdated = time:utcToString(time:utcNow());
    exportTask.lastStatus = pollingEvent.exportStatus ?: "In-progress";
    lock {
        taskMap.get(pollingEvent.id).pollingEvents.push(pollingEvent);
    }
    return true;
}

isolated function updateExportTaskStatusInMemory(map<ExportTask> taskMap, string exportTaskId, string newStatus) {
    ExportTask exportTask = taskMap.get(exportTaskId);
    exportTask.lastUpdated = time:utcToString(time:utcNow());
    exportTask.lastStatus = newStatus;
}

isolated function getExportTaskFromMemory(string exportId) returns ExportTask|error {
    // get the export task from the memory
    lock {
        if exportTasks.hasKey(exportId) {
            return exportTasks.get(exportId).clone();
        } else {
            return error("Export task not found for id: " + exportId);
        }
    }
}

isolated function removeExportTaskFromMemory(string exportId, decimal? expiryTime = ()) {
    lock {
        _ = exportTasks.removeIfHasKey(exportId);
    }

    if expiryTime is decimal {
        lock {
            exportTaskExpiryTimes[exportId] = time:utcAddSeconds(time:utcNow(), expiryTime);
        }
    }
}

isolated function getExpiryTimeForExportTask(string exportId) returns time:Utc|error {
    // get the expiry time for the export task
    lock {
        if exportTaskExpiryTimes.hasKey(exportId) {
            return exportTaskExpiryTimes.get(exportId);
        } else {
            return error("Expiry time not found for export task id: " + exportId);
        }
    }
}

isolated function removeExpiredExportTask(string exportId) {
    lock {
        _ = exportTaskExpiryTimes.removeIfHasKey(exportId);
    }
}

// Function types to interact with the storage impl.

type getExportTask function (string exportId) returns ExportTask;

type getPollingEvents function (string exportId) returns [PollingEvent];

type addExportTask isolated function (map<ExportTask> taskMap, ExportTask exportTask) returns boolean;

type addPollingEvent isolated function (map<ExportTask> taskMap, PollingEvent pollingEvent) returns boolean;

type updateExportTaskStatus function (map<ExportTask> taskMap, string exportTaskId, string newStatus) returns boolean;
