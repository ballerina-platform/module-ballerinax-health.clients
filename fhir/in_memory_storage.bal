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

isolated function addExportTasktoMemory(map<ExportTask> taskMap, ExportTask exportTask) returns boolean {
    // add the export task to the memory
    exportTask.lastUpdated = time:utcNow();
    lock {
        taskMap[exportTask.id] = exportTask;
    }
    return true;
}

isolated function addPollingEventToMemory(map<ExportTask> taskMap, PollingEvent pollingEvent) returns boolean {
    // add the polling event to the memory
    ExportTask exportTask = taskMap.get(pollingEvent.id);
    exportTask.lastUpdated = time:utcNow();
    exportTask.lastStatus = pollingEvent.exportStatus ?: "In-progress";
    lock {
        taskMap.get(pollingEvent.id).pollingEvents.push(pollingEvent);
    }
    return true;
}

isolated function updateExportTaskStatusInMemory(map<ExportTask> taskMap, string exportTaskId, string newStatus) returns boolean {
    ExportTask exportTask = taskMap.get(exportTaskId);
    exportTask.lastUpdated = time:utcNow();
    exportTask.lastStatus = newStatus;
    return true;
}

isolated function getExportTaskFromMemory(string exportId) returns ExportTask|error {
    // get the export task from the memory
    ExportTask? exportTask;
    lock {
        exportTask = exportTasks.get(exportId).clone();
    }
    if exportTask is ExportTask {
        return exportTask.clone();
    } else {
        return error("ExportTask not found for exportId: " + exportId);
    }
}
