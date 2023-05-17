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

import ballerina/test;
import ballerina/log;
import ballerina/io;
import ballerina/http;

final string testServerBaseUrl = "/fhir_test_server/r4";
final string localhost = "http://localhost:8080";
final string replacementUrl = "http://localhost:8181/fhir";

FhirConnectorConfig config = {
    baseURL: localhost + testServerBaseUrl,
    mimeType: FHIR_JSON
};
FhirConnector fhirConnector = check new (config);

FhirConnectorConfig urlRewriteConfig = {
    baseURL: localhost + testServerBaseUrl,
    mimeType: FHIR_JSON,
    urlRewrite: true,
    replacementURL: replacementUrl
};
FhirConnector urlRewriteConnector = check new (urlRewriteConfig);

listener http:Listener listenerEP = check new (8080);

@test:BeforeSuite
function setup() returns error? {
    check listenerEP.attach(FhirMockService, testServerBaseUrl);
    check listenerEP.'start();
    log:printInfo("FHIR mock service has started");

}

@test:Config {}
function testUrlRewrite() returns FhirError? {

    // json
    // Connector config set to enable url rewrite
    FhirResponse res1 = check urlRewriteConnector->getConformance();
    test:assertEquals(res1.'resource, testCapabilityStatementJsonUrlRewritten, "Failed to rewrite url and return correct resource.");

    // Override connector config to disable url rewrite
    FhirResponse res2 = check fhirConnector->getConformance();
    test:assertEquals(res2.'resource, testCapabilityStatementJson, "Failed to return correct resource.");

    // xml
    // Connector config set to enable url rewrite
    FhirResponse res3 = check urlRewriteConnector->getConformance(returnMimeType = FHIR_XML);
    test:assertEquals(res3.'resource, testCapabilityStatementXmlUrlRewritten, "Failed to rewrite url and return correct resource.");

    // Override connector config to disable url rewrite
    FhirResponse res4 = check fhirConnector->getConformance(returnMimeType = FHIR_XML);
    test:assertEquals(res4.'resource, testCapabilityStatementXml, "Failed to return correct resource.");

    // Testing URL rewrite on headers
    FhirResponse res5 = check urlRewriteConnector->bulkExport(EXPORT_SYSTEM);
    string rewrittenPollingUrl = res5.serverResponseHeaders["content-location"] ?: "";
    test:assertEquals(rewrittenPollingUrl, string `${replacementUrl}/exportStatus/1`, "Failed to url rewrite headers");

}

@test:Config {}
function testGetById() returns FhirError? {

    // Format param is set to default
    FhirResponse result1 = check fhirConnector->getById(PATIENT, "pat1");
    test:assertEquals(result1.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result1.'resource, testGetResourceDataJson, "Failed to return the resource data.");

    // Format param is set to xml
    FhirResponse result2 = check fhirConnector->getById(PATIENT, "pat1", returnMimeType = FHIR_XML);
    test:assertEquals(result2.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result2.'resource, testGetResourceDataXml, "Failed to return the resource data.");

    // resource doesn't exists
    FhirResponse|FhirError result3 = fhirConnector->getById(PATIENT, "pat170");
    if result3 is FhirError {
        if result3 is FhirServerError {
            test:assertEquals(result3.detail().httpStatusCode, 404, "Failed to return the correct status code");
            test:assertEquals(result3.'detail().'resource, testGetResourceFailedData, "Failed to return the resource data.");
        } else {
            test:assertFail("Failed to respond with the correct error type:FhirServerError");
        }
    } else {
        test:assertFail("Failed to respond with the correct error");

    }

}

@test:Config {}
function testGetByVersion() returns FhirError? {

    // Format param is set to default
    FhirResponse result1 = check fhirConnector->getByVersion(PATIENT, "pat1", "100");
    test:assertEquals(result1.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result1.'resource, testGetResourceDataJson, "Failed to return the resource data.");

    // Format param is set to xml
    FhirResponse result2 = check fhirConnector->getByVersion(PATIENT, "pat1", "100", returnMimeType = FHIR_XML);
    test:assertEquals(result2.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result2.'resource, testGetResourceDataXml, "Failed to return the resource data.");

    // resource doesn't exists
    FhirResponse|FhirError result3 = fhirConnector->getByVersion(PATIENT, "pat1", "101");
    if result3 is FhirError {
        if result3 is FhirServerError {
            test:assertEquals(result3.detail().httpStatusCode, 404, "Failed to return the correct status code");
            test:assertEquals(result3.'detail().'resource, testGetResourceFailedData, "Failed to return the resource data.");
        } else {
            test:assertFail("Failed to respond with the correct error type:FhirServerError");
        }
    } else {
        test:assertFail("Failed to respond with the correct error");

    }

}

@test:Config {}
function testUpdate() returns FhirError? {
    // json data
    FhirResponse result1 = check fhirConnector->update(testUpdateResourceDataJson);
    test:assertEquals(result1.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result1.'resource, locationDetails, "Failed to return location details.");

    //xml data 
    FhirResponse result2 = check fhirConnector->update(testUpdateResourceDataXml);
    test:assertEquals(result2.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result2.'resource, locationDetails, "Failed to return location details.");

    //prefer head set to representation
    FhirResponse result3 = check fhirConnector->update(testUpdateResourceDataJson, returnPreference = REPRESENTATION);
    test:assertEquals(result3.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result3.'resource, testGetResourceDataJson, "Failed to return location details.");

    // data doesn't contain id attribute
    FhirResponse|FhirError result4 = fhirConnector->update(testUpdateResourceDataJsonMissingId);
    if result4 is FhirError {
        if result4 is FhirConnectorError {
            error? e = result4.detail().errorDetails;
            if (e is error) {
                test:assertEquals(e.message(), ERROR_WHEN_RETRIEVING_RESOURCE_ID, "Failed to return ID not found error");
            }

        } else {
            test:assertFail("Failed to respond with the correct error type:FhirConnectorError");
        }
    } else {
        test:assertFail("Failed to respond with the correct error");

    }

}

@test:Config {}
function testPatch() returns FhirError? {
    // resource exists
    FhirResponse result1 = check fhirConnector->patch(PATIENT, "pat1", testPatchResourceDataXml, patchContentType = FHIR_XML);
    test:assertEquals(result1.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result1.'resource, locationDetails, "Failed to return location details.");

    // resource doesn't exists
    FhirResponse|FhirError result2 = fhirConnector->patch(PATIENT, "pat2", testPatchResourceDataXml, patchContentType = FHIR_XML);
    if result2 is FhirError {
        if result2 is FhirServerError {
            test:assertEquals(result2.detail().httpStatusCode, 404, "Failed to return the correct status code");
            test:assertEquals(result2.detail().'resource, testPatchResourceFailedData, "Failed to return the operation outcome");

        } else {
            test:assertFail("Failed to respond with the correct error type:FhirServerError");
        }
    } else {
        test:assertFail("Failed to respond with the correct error");

    }

}

@test:Config {}
function testDelete() returns FhirError? {
    // requested resource exists
    FhirResponse result1 = check fhirConnector->delete(PATIENT, "pat1");
    test:assertEquals(result1.httpStatusCode, 204, "Failed to return the correct status code");

    // resource not found
    FhirResponse|FhirError result2 = fhirConnector->delete(PATIENT, "pat2");
    if result2 is FhirError {
        if result2 is FhirServerError {
            test:assertEquals(result2.detail().httpStatusCode, 404, "Failed to return the correct status code");
            test:assertEquals(result2.detail().'resource, testDeleteResourceFailedData, "Failed to return the operation outcome");

        } else {
            test:assertFail("Failed to respond with the correct error type:FhirServerError");
        }
    } else {
        test:assertFail("Failed to respond with the correct error");

    }

}

@test:Config {}
function testGetInstanceHistory() returns FhirError? {
    // requested resource exists 
    FhirResponse result1 = check fhirConnector->getInstanceHistory(PATIENT, "pat1");
    test:assertEquals(result1.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result1.'resource, testGetResourceDataJson, "Failed to return resource bundle");

    // requested resource doesn't exits 
    FhirResponse|FhirError result2 = fhirConnector->getInstanceHistory(PATIENT, "pat10");
    if result2 is FhirError {
        if result2 is FhirServerError {
            test:assertEquals(result2.detail().httpStatusCode, 404, "Failed to return the correct status code");
            test:assertEquals(result2.detail().'resource, testGetResourceFailedData, "Failed to return the operation outcome");

        } else {
            test:assertFail("Failed to respond with the correct error type:FhirServerError");
        }
    } else {
        test:assertFail("Failed to respond with the correct error");

    }

}

@test:Config {}
function testCreate() returns FhirError? {
    // create with default values
    FhirResponse result1 = check fhirConnector->create(testUpdateResourceDataJson);
    test:assertEquals(result1.httpStatusCode, 201, "Failed to return the correct status code");
    test:assertEquals(result1.'resource, locationDetails, "Failed to return location details.");

    //prefer header set to representation and xml data
    FhirResponse result2 = check fhirConnector->create(testUpdateResourceDataXml, returnPreference = REPRESENTATION);
    test:assertEquals(result2.httpStatusCode, 201, "Failed to return the correct status code");
    test:assertEquals(result2.'resource, testGetResourceDataJson, "Failed to return location details.");
}

@test:Config {}
function testSearch() returns FhirError? {
    FhirResponse result1 = check fhirConnector->search(PATIENT);
    test:assertEquals(result1.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result1.'resource, testSearchDataSet1Json, "Failed to return search result bundle.");

    // Using default params. urlRewrite set to true
    FhirResponse result2 = check urlRewriteConnector->search(PATIENT);
    test:assertEquals(result2.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result2.'resource, testSearchDataSet1JsonUrlRewritten, "Failed to return URL rewritten search result bundle.");
}

@test:Config {}
function testGetHistory() returns FhirError? {
    FhirResponse result1 = check fhirConnector->getHistory(PATIENT, parameters = {_count: "5", _since: "2010-05-05"});
    test:assertEquals(result1.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result1.'resource, testHistoryDataJson, "Failed to return history result bundle.");

    // Using default params. urlRewrite set to true
    FhirResponse result2 = check urlRewriteConnector->getHistory(PATIENT, parameters = {_count: "5", _since: "2010-05-05"});
    test:assertEquals(result2.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result2.'resource, testHistoryDataJsonUrlRewritten, "Failed to return URL rewritten history result bundle.");
}

@test:Config {}
function testGetConformance() returns FhirError? {
    // get full capability statement. urlRewrite set to true 
    FhirResponse result1 = check urlRewriteConnector->getConformance();
    test:assertEquals(result1.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result1.'resource, testCapabilityStatementJsonUrlRewritten, "Failed to return url rewritten capability statement.");

    //returns other types of modes
    FhirResponse result2 = check fhirConnector->getConformance(mode = TERMINOLOGY);
    test:assertEquals(result2.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result2.'resource, testCapStatementData, "Failed to return capability statement.");
}

@test:Config {}
function testGetAllHistory() returns FhirError? {
    FhirResponse result1 = check fhirConnector->getAllHistory(parameters = {_count: "5"});
    test:assertEquals(result1.httpStatusCode, http:STATUS_OK, "Failed to return the correct status code");
    test:assertEquals(result1.'resource, testHistoryDataJson, "Failed to return history result bundle.");

    // Using default params. urlRewrite set to true
    FhirResponse result2 = check urlRewriteConnector->getAllHistory(parameters = {_count: "5"});
    test:assertEquals(result2.httpStatusCode, http:STATUS_OK, "Failed to return the correct status code");
    test:assertEquals(result2.'resource, testHistoryDataJsonUrlRewritten, "Failed to return URL rewritten history result bundle.");
}

@test:Config {}
function testSearchAll() returns FhirError? {
    FhirResponse result1 = check fhirConnector->searchAll(searchParameters = {_id: ["50"]});
    test:assertEquals(result1.httpStatusCode, http:STATUS_OK, "Failed to return the correct status code");
    test:assertEquals(result1.'resource, testSearchDataSet2Json, "Failed to return search result bundle.");

    // Using default params. urlRewrite set to true
    FhirResponse result2 = check urlRewriteConnector->searchAll(searchParameters = {_id: ["50"]});
    test:assertEquals(result2.httpStatusCode, http:STATUS_OK, "Failed to return the correct status code");
    test:assertEquals(result2.'resource, testSearchDataSet2JsonUrlRewritten, "Failed to return URL rewritten search result bundle.");
}

@test:Config {}
function testBatchRequest() returns FhirError? {
    // json request
    FhirResponse result1 = check fhirConnector->batchRequest(testBatchDataJson);
    test:assertEquals(result1.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result1.'resource, testBundleDataJson, "Failed to return batch result bundle.");

    // xml request
    FhirResponse result2 = check fhirConnector->batchRequest(testBatchDataXml);
    test:assertEquals(result2.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result2.'resource, testBundleDataJson, "Failed to return batch result bundle.");

    // invalid bundle type
    FhirResponse|FhirError result3 = fhirConnector->batchRequest(testTransactionDataJson);
    if result3 is FhirError {
        if result3 is FhirConnectorError {
            error? e = result3.detail().errorDetails;
            if (e is ()) {

            } else {
                test:assertEquals(e.message(), BUNDLE_TYPE_ERROR + BATCH, "Failed to return invalid bundle type error");
            }
        } else {
            test:assertFail("Failed to respond with the correct error type:FhirConnectorError");
        }
    } else {
        test:assertFail("Failed to respond with the correct error");

    }

}

@test:Config {}
function testTransaction() returns FhirError? {
    // json request
    FhirResponse result1 = check fhirConnector->'transaction(testTransactionDataJson);
    test:assertEquals(result1.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result1.'resource, testBundleDataJson, "Failed to return batch result bundle.");

    // invalid bundle type
    FhirResponse|FhirError result2 = fhirConnector->'transaction(testBatchDataJson);
    if result2 is FhirError {
        if result2 is FhirConnectorError {
            error? e = result2.detail().errorDetails;
            if (e is error) {
                test:assertEquals(e.message(), BUNDLE_TYPE_ERROR + TRANSACTION, "Failed to return invalid bundle type error");
            }

        } else {
            test:assertFail("Failed to respond with the correct error type:FhirConnectorError");
        }
    } else {
        test:assertFail("Failed to respond with the correct error");

    }

}

@test:Config {}
function testNextBundle() returns FhirError? {
    FhirResponse initialResultJson = check urlRewriteConnector->search(PATIENT);

    // next bundle exists JSON
    FhirResponse? nextBundleJson = check urlRewriteConnector->nextBundle(initialResultJson);

    if nextBundleJson is FhirResponse {
        test:assertEquals(nextBundleJson.httpStatusCode, 200, "Failed to return the correct status code");
        test:assertEquals(nextBundleJson.'resource, testSearchDataSet2JsonUrlRewritten, "Failed to get the next page bundle data");

    } else {
        test:assertFail("Failed to retrieve the next bundle");
    }

    // next bundle doesn't exists 
    FhirResponse? nextBundle2 = check urlRewriteConnector->nextBundle(nextBundleJson);
    if nextBundle2 is () {
        test:assertTrue(true);
    } else {
        test:assertFail("Failed to return () when there is no next bundle");
    }

    // next bundle exists XML
    FhirResponse initialResultXml = check urlRewriteConnector->search(PATIENT, returnMimeType = FHIR_XML);
    FhirResponse? nextBundleXml = check urlRewriteConnector->nextBundle(initialResultXml);

    if nextBundleXml is FhirResponse {
        test:assertEquals(nextBundleXml.httpStatusCode, 200, "Failed to return the correct status code");
        test:assertEquals(nextBundleXml.'resource, testSearchDataSet1XmlUrlRewritten, "Failed to get the next page bundle data");

    } else {
        test:assertFail("Failed to retrieve the next bundle");
    }

}

@test:Config {}
function testPreviousBundle() returns FhirError?|error {

    FhirResponse initialResult = check urlRewriteConnector->search(PATIENT);

    //  previous bundle doesn't exists 
    FhirResponse? prevBundle = check urlRewriteConnector->previousBundle(initialResult);
    if prevBundle is () {
        test:assertTrue(true);
    } else {
        test:assertFail("Failed to return () when there is no previous bundle");
    }

    // previous bundle exists 
    FhirResponse? nextBundle = check urlRewriteConnector->nextBundle(initialResult);

    FhirResponse? prevBundle2 = check urlRewriteConnector->previousBundle(nextBundle);
    if prevBundle2 is FhirResponse {
        test:assertEquals(prevBundle2.httpStatusCode, 200, "Failed to return the correct status code");
        test:assertEquals(prevBundle2.'resource, testSearchDataSet1JsonUrlRewritten, "Failed to get the previous page bundle data");
    } else {
        test:assertFail("Failed to retrieve the previous bundle");
    }

}

@test:Config {}
function testBulkExportKickOff() returns FhirError? {
    // System export kick off
    FhirResponse result1 = check fhirConnector->bulkExport(EXPORT_SYSTEM);
    test:assertEquals(result1.httpStatusCode, 202, "Failed to return the correct status code");
    test:assertTrue(result1.serverResponseHeaders["content-location"] != (), "Failed to return bulk export content location header");

    // Patient level export kick off
    FhirResponse result2 = check fhirConnector->bulkExport(EXPORT_PATIENT);
    test:assertEquals(result2.httpStatusCode, 202, "Failed to return the correct status code");
    test:assertTrue(result2.serverResponseHeaders["content-location"] != (), "Failed to return bulk export content location header");

    // Export group kick off
    FhirResponse result3 = check fhirConnector->bulkExport(EXPORT_GROUP, "123");
    test:assertEquals(result3.httpStatusCode, 202, "Failed to return the correct status code");
    test:assertTrue(result3.serverResponseHeaders["content-location"] != (), "Failed to return bulk export content location header");

    // Export group kick off with no group id
    FhirResponse|FhirError result4 = fhirConnector->bulkExport(EXPORT_GROUP);
    if result4 is FhirError {
        if result4 is FhirConnectorError {
            error? e = result4.detail().errorDetails;
            if (e is error) {
                test:assertEquals(e.message(), GROUP_ID_NOT_PROVIDED, "Failed to return invalid group id error");
            }

        } else {
            test:assertFail("Failed to respond with the correct error type:FhirConnectorError");
        }
    } else {
        test:assertFail("Failed to respond with the correct error");
    }

    // System export kick off with params
    FhirResponse result5 = check fhirConnector->bulkExport(
        EXPORT_SYSTEM,
        bulkExportParameters = {
        _since: "2017-01-01T00:00:00Z",
        _type: ["Patient"]
    }
    );
    test:assertEquals(result5.httpStatusCode, 202, "Failed to return the correct status code");
    test:assertTrue(result5.serverResponseHeaders["content-location"] != (), "Failed to return bulk export content location header");
}

@test:Config {}
function testBulkExportStatus() returns FhirError? {
    // System export kick off
    FhirResponse result1 = check fhirConnector->bulkExport(EXPORT_SYSTEM);
    string pollingUrl = result1.serverResponseHeaders["content-location"] ?: "";

    // Polling the export status
    FhirResponse result2 = check fhirConnector->bulkStatus(pollingUrl);
    test:assertEquals(result2.httpStatusCode, 202, "Failed to return the correct status code");

    // Polling the export status when export is completed
    FhirResponse result3 = check fhirConnector->bulkStatus(string `${localhost}${testServerBaseUrl}/exportStatus/2`);
    test:assertEquals(result3.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result3.'resource, testExportFileManifestData, "Failed to return the bulk export manifest");

    // Polling the export status when export is completed - url rewrite is enabled
    FhirResponse result4 = check urlRewriteConnector->bulkStatus(string `${replacementUrl}/exportStatus/2`);
    test:assertEquals(result4.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result4.'resource, testExportFileManifestDataUrlRewritten, "Failed to return the url rewritten bulk export manifest");

}

@test:Config {}
function testBulkExportCancel() returns FhirError? {
    // System export kick off
    FhirResponse result1 = check fhirConnector->bulkExport(EXPORT_SYSTEM);
    string pollingUrl = result1.serverResponseHeaders["content-location"] ?: "";

    // Cancel the export
    FhirResponse result2 = check fhirConnector->bulkDataDelete(pollingUrl);
    test:assertEquals(result2.httpStatusCode, 202, "Failed to return the correct status code");
    test:assertEquals(result2.'resource, testBulkExportCancelResponse, "Failed to return the bulk export cancel success payload");

    // Using an invalid polling url
    FhirResponse|FhirError result3 = fhirConnector->bulkDataDelete(string `${localhost}${testServerBaseUrl}/exportStatus/3`);
    if result3 is FhirError {
        if result3 is FhirServerError {
            FhirServerErrorDetails e = result3.detail();
            test:assertEquals(e.httpStatusCode, 404, "Failed to return the correct status code");
            test:assertEquals(e.'resource, testBulkExportCancelInvalidIDResponse, "Failed to return the correct error response payload");
        } else {
            test:assertFail("Failed to respond with the correct error type:FhirServerError");
        }
    } else {
        test:assertFail("Failed to respond with the correct error");
    }

}

@test:Config {}
function testBulkExportFileAccess() returns error? {
    // Polling the export status when export is completed
    FhirResponse result1 = check urlRewriteConnector->bulkStatus(string `${replacementUrl}/exportStatus/2`);
    string fileUrl = (check (<json[]>(check (<json>result1.'resource).output))[0].url).toString();

    // Accessing the file
    FhirBulkFileResponse result2 = check urlRewriteConnector->bulkFile(fileUrl);
    test:assertEquals(result2.httpStatusCode, 200, "Failed to return the correct status code");

    stream<byte[], io:Error?> fileStream = result2.dataStream;

    byte[][] fileBytes = check from var i in fileStream
        select i;

    byte[] fileData = [];
    foreach byte[] byteArr in fileBytes {
        fileData.push(...byteArr);
    }

    string fileContent = check string:fromBytes(fileData);

    test:assertEquals(fileContent, testBulkExportFileData, "Failed to return the correct file content");

    // With invalid url
    FhirBulkFileResponse|FhirError result3 = urlRewriteConnector->bulkFile(fileUrl + "invalid");
    if result3 is FhirError {
        if result3 is FhirServerError {
            FhirServerErrorDetails e = result3.detail();
            test:assertEquals(e.httpStatusCode, 404, "Failed to return the correct status code");
            test:assertEquals(e.'resource, testBulkFileInvalidIDResponse, "Failed to return the correct error response payload");
        } else {
            test:assertFail("Failed to respond with the correct error type:FhirServerError");
        }
    } else {
        test:assertFail("Failed to respond with the correct error");
    }
}

@test:AfterSuite
function teardown() returns error? {
    check listenerEP.gracefulStop();
    log:printInfo("FHIR mock service has stopped");

}
