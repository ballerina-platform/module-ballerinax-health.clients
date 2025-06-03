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

FHIRConnectorConfig config = {
    baseURL: localhost + testServerBaseUrl,
    mimeType: FHIR_JSON
};
FHIRConnector fhirConnector = check new (config);

FHIRConnectorConfig urlRewriteConfig = {
    baseURL: localhost + testServerBaseUrl,
    mimeType: FHIR_JSON,
    urlRewrite: true,
    replacementURL: replacementUrl
};
FHIRConnector urlRewriteConnector = check new (urlRewriteConfig);

listener http:Listener listenerEP = check new (8080);

@test:BeforeSuite
function setup() returns error? {
    check listenerEP.attach(FhirMockService, testServerBaseUrl);
    check listenerEP.'start();
    log:printInfo("FHIR mock service has started");

}

@test:Config {}
function testUrlRewrite() returns FHIRError? {

    // json
    // Connector config set to enable url rewrite
    FHIRResponse res1 = check urlRewriteConnector->getConformance();
    test:assertEquals(res1.'resource, testCapabilityStatementJsonUrlRewritten, "Failed to rewrite url and return correct resource.");

    // Override connector config to disable url rewrite
    FHIRResponse res2 = check fhirConnector->getConformance();
    test:assertEquals(res2.'resource, testCapabilityStatementJson, "Failed to return correct resource.");

    // xml
    // Connector config set to enable url rewrite
    FHIRResponse res3 = check urlRewriteConnector->getConformance(returnMimeType = FHIR_XML);
    test:assertEquals(res3.'resource, testCapabilityStatementXmlUrlRewritten, "Failed to rewrite url and return correct resource.");

    // Override connector config to disable url rewrite
    FHIRResponse res4 = check fhirConnector->getConformance(returnMimeType = FHIR_XML);
    test:assertEquals(res4.'resource, testCapabilityStatementXml, "Failed to return correct resource.");

    // Testing URL rewrite on headers
    FHIRResponse res5 = check urlRewriteConnector->bulkExport(EXPORT_SYSTEM);
    string rewrittenPollingUrl = res5.serverResponseHeaders["content-location"] ?: "";
    test:assertEquals(rewrittenPollingUrl, string `${replacementUrl}/exportStatus/1`, "Failed to url rewrite headers");

}

@test:Config {}
function testGetById() returns FHIRError? {

    // Format param is set to default
    FHIRResponse result1 = check fhirConnector->getById(PATIENT, "pat1");
    test:assertEquals(result1.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result1.'resource, testGetResourceDataJson, "Failed to return the resource data.");

    // Format param is set to xml
    FHIRResponse result2 = check fhirConnector->getById(PATIENT, "pat1", returnMimeType = FHIR_XML);
    test:assertEquals(result2.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result2.'resource, testGetResourceDataXml, "Failed to return the resource data.");

    // resource doesn't exists
    FHIRResponse|FHIRError result3 = fhirConnector->getById(PATIENT, "pat170");
    if result3 is FHIRError {
        if result3 is FHIRServerError {
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
function testGetByVersion() returns FHIRError? {

    // Format param is set to default
    FHIRResponse result1 = check fhirConnector->getByVersion(PATIENT, "pat1", "100");
    test:assertEquals(result1.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result1.'resource, testGetResourceDataJson, "Failed to return the resource data.");

    // Format param is set to xml
    FHIRResponse result2 = check fhirConnector->getByVersion(PATIENT, "pat1", "100", returnMimeType = FHIR_XML);
    test:assertEquals(result2.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result2.'resource, testGetResourceDataXml, "Failed to return the resource data.");

    // resource doesn't exists
    FHIRResponse|FHIRError result3 = fhirConnector->getByVersion(PATIENT, "pat1", "101");
    if result3 is FHIRError {
        if result3 is FHIRServerError {
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
function testUpdate() returns FHIRError? {
    // json data
    FHIRResponse result1 = check fhirConnector->update(testUpdateResourceDataJson);
    test:assertEquals(result1.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result1.'resource, locationDetails, "Failed to return location details.");

    //xml data 
    FHIRResponse result2 = check fhirConnector->update(testUpdateResourceDataXml);
    test:assertEquals(result2.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result2.'resource, locationDetails, "Failed to return location details.");

    //prefer head set to representation
    FHIRResponse result3 = check fhirConnector->update(testUpdateResourceDataJson, returnPreference = REPRESENTATION);
    test:assertEquals(result3.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result3.'resource, testGetResourceDataJson, "Failed to return location details.");

    // data doesn't contain id attribute
    FHIRResponse|FHIRError result4 = fhirConnector->update(testUpdateResourceDataJsonMissingId);
    if result4 is FHIRError {
        if result4 is FHIRConnectorError {
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

    // Conditional update using a conditional URL (resource exists)
    FHIRResponse result5 = check fhirConnector->update(testUpdateResourceDataJson, onCondition = { "url": "exists" });
    test:assertEquals(result5.httpStatusCode, 200, "Failed to return the correct status code for conditional update (resource exists)");

    // Conditional update using a conditional URL (resource does not exist)
    FHIRResponse result6 = check fhirConnector->update(testUpdateResourceDataJson, onCondition = { "url": "notfound" });
    test:assertEquals(result6.httpStatusCode, 200, "Failed to return the correct status code for conditional update (resource not found)");
    test:assertEquals(result6.'resource, locationDetails, "Failed to return location details for conditional update (resource not found).");

    // invalid conditional URL
    FHIRResponse|FHIRError result7 = fhirConnector->update(testUpdateResourceDataJson, onCondition = "?url=invalid");
    if result7 is FHIRError {
        if result7 is FHIRConnectorError {
            error? e = result7.detail().errorDetails;
            if (e is error) {
                test:assertEquals(e.message(), "Conditional URL should be in the format \"ResourceType?searchParam=value\".", "Failed to return invalid conditional URL error");
            }

        } else {
            test:assertFail("Failed to respond with the correct error type:FhirConnectorError");
        }
    } else {
        test:assertFail("Failed to respond with the correct error");
    }   
}

@test:Config {}
function testPatch() returns FHIRError? {
    // resource exists
    FHIRResponse result1 = check fhirConnector->patch(PATIENT, testPatchResourceDataXml, id = "pat1", patchContentType = FHIR_XML);
    test:assertEquals(result1.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result1.'resource, locationDetails, "Failed to return location details.");

    // resource doesn't exists
    FHIRResponse|FHIRError result2 = fhirConnector->patch(PATIENT, testPatchResourceDataXml, id = "pat2", patchContentType = FHIR_XML);
    if result2 is FHIRError {
        if result2 is FHIRServerError {
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
function testDelete() returns FHIRError? {
    // requested resource exists
    FHIRResponse result1 = check fhirConnector->delete(PATIENT, "pat1");
    test:assertEquals(result1.httpStatusCode, 204, "Failed to return the correct status code");

    // resource not found
    FHIRResponse|FHIRError result2 = fhirConnector->delete(PATIENT, "pat2");
    if result2 is FHIRError {
        if result2 is FHIRServerError {
            test:assertEquals(result2.detail().httpStatusCode, 404, "Failed to return the correct status code");
            test:assertEquals(result2.detail().'resource, testDeleteResourceFailedData, "Failed to return the operation outcome");

        } else {
            test:assertFail("Failed to respond with the correct error type:FhirServerError");
        }
    } else {
        test:assertFail("Failed to respond with the correct error");

    }

    // Conditional delete using a conditional URL (resource exists)
    FHIRResponse result3 = check fhirConnector->delete(PATIENT, onCondition = { "url": "exists" });
    test:assertEquals(result3.httpStatusCode, 204, "Failed to return the correct status code for conditional delete (resource exists)");

    // Conditional delete using search parameters (resource exists)
    SearchParameters condParams = {_id: "pat1"};
    FHIRResponse result5 = check fhirConnector->delete(PATIENT, onCondition = condParams);
    test:assertEquals(result5.httpStatusCode, 204, "Failed to return the correct status code for conditional delete (resource exists)");

    // Conditional delete using a conditional URL (resource does not exist)
    FHIRResponse|FHIRError result4 = fhirConnector->delete(PATIENT, onCondition = { "url": "notfound" });
    if result4 is FHIRError {
        if result4 is FHIRServerError {
            test:assertEquals(result4.detail().httpStatusCode, 404, "Failed to return the correct status code for conditional delete (resource not found)");
            test:assertEquals(result4.detail().'resource, testDeleteResourceFailedData, "Failed to return the operation outcome for conditional delete (resource not found)");
        } else {
            test:assertFail("Failed to respond with the correct error type:FhirServerError (conditional delete)");
        }
    } else {
        test:assertFail("Failed to respond with the correct error for conditional delete (resource not found)");
    }

    // Conditional delete using a conditional URL (resource exists)
    FHIRResponse result6 = check fhirConnector->delete(PATIENT, id = "pat1", onCondition = { "url": "exists" });
    test:assertEquals(result6.httpStatusCode, 204, "Failed to return the correct status code for conditional delete (resource exists)");
}

@test:Config {}
function testGetInstanceHistory() returns FHIRError? {
    // requested resource exists 
    FHIRResponse result1 = check fhirConnector->getInstanceHistory(PATIENT, "pat1");
    test:assertEquals(result1.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result1.'resource, testGetResourceDataJson, "Failed to return resource bundle");

    // requested resource doesn't exits 
    FHIRResponse|FHIRError result2 = fhirConnector->getInstanceHistory(PATIENT, "pat10");
    if result2 is FHIRError {
        if result2 is FHIRServerError {
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
function testCreate() returns FHIRError? {
    // create with default values
    FHIRResponse result1 = check fhirConnector->create(testUpdateResourceDataJson);
    test:assertEquals(result1.httpStatusCode, 201, "Failed to return the correct status code");
    test:assertEquals(result1.'resource, locationDetails, "Failed to return location details.");

    //prefer header set to representation and xml data
    FHIRResponse result2 = check fhirConnector->create(testUpdateResourceDataXml, returnPreference = REPRESENTATION);
    test:assertEquals(result2.httpStatusCode, 201, "Failed to return the correct status code");
    test:assertEquals(result2.'resource, testGetResourceDataJson, "Failed to return location details.");

    // Conditional create using a conditional URL
    FHIRResponse result3 = check fhirConnector->create(testUpdateResourceDataJson, onCondition = PATIENT + "?url=example.com");
    test:assertEquals(result3.httpStatusCode, 201, "Failed to return the correct status code for conditional create by URL");

    // Conditional create using a map<string[]>
    map<string[]> condMap = {url: ["example.com/pat1"]};
    FHIRResponse result4 = check fhirConnector->create(testUpdateResourceDataJson, onCondition = condMap);
    test:assertEquals(result4.httpStatusCode, 201, "Failed to return the correct status code for conditional create by map<string[]>");

    // Conditional create using a SearchParameters record
    SearchParameters condParams = {_id: "pat1"};
    FHIRResponse result5 = check fhirConnector->create(testUpdateResourceDataJson, onCondition = condParams);
    test:assertEquals(result5.httpStatusCode, 201, "Failed to return the correct status code for conditional create by SearchParameters");   
}

@test:Config {}
function testSearch() returns FHIRError? {
    FHIRResponse result1 = check fhirConnector->search(PATIENT);
    test:assertEquals(result1.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result1.'resource, testSearchDataSet1Json, "Failed to return search result bundle.");

    // Using default params. urlRewrite set to true
    FHIRResponse result2 = check urlRewriteConnector->search(PATIENT);
    test:assertEquals(result2.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result2.'resource, testSearchDataSet1JsonUrlRewritten, "Failed to return URL rewritten search result bundle.");

    FHIRResponse result3 = check fhirConnector->search(PATIENT, mode = POST);
    test:assertEquals(result3.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result3.'resource, testSearchDataSet1Json, "Failed to return the correct Patient bundle.");
}

@test:Config {}
function testGetHistory() returns FHIRError? {
    FHIRResponse result1 = check fhirConnector->getHistory(PATIENT, parameters = {_count: "5", _since: "2010-05-05"});
    test:assertEquals(result1.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result1.'resource, testHistoryDataJson, "Failed to return history result bundle.");

    // Using default params. urlRewrite set to true
    FHIRResponse result2 = check urlRewriteConnector->getHistory(PATIENT, parameters = {_count: "5", _since: "2010-05-05"});
    test:assertEquals(result2.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result2.'resource, testHistoryDataJsonUrlRewritten, "Failed to return URL rewritten history result bundle.");
}

@test:Config {}
function testGetConformance() returns FHIRError? {
    // get full capability statement. urlRewrite set to true 
    FHIRResponse result1 = check urlRewriteConnector->getConformance();
    test:assertEquals(result1.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result1.'resource, testCapabilityStatementJsonUrlRewritten, "Failed to return url rewritten capability statement.");

    //returns other types of modes
    FHIRResponse result2 = check fhirConnector->getConformance(mode = TERMINOLOGY);
    test:assertEquals(result2.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result2.'resource, testCapStatementData, "Failed to return capability statement.");
}

@test:Config {}
function testGetAllHistory() returns FHIRError? {
    FHIRResponse result1 = check fhirConnector->getAllHistory(parameters = {_count: "5"});
    test:assertEquals(result1.httpStatusCode, http:STATUS_OK, "Failed to return the correct status code");
    test:assertEquals(result1.'resource, testHistoryDataJson, "Failed to return history result bundle.");

    // Using default params. urlRewrite set to true
    FHIRResponse result2 = check urlRewriteConnector->getAllHistory(parameters = {_count: "5"});
    test:assertEquals(result2.httpStatusCode, http:STATUS_OK, "Failed to return the correct status code");
    test:assertEquals(result2.'resource, testHistoryDataJsonUrlRewritten, "Failed to return URL rewritten history result bundle.");
}

@test:Config {}
function testSearchAll() returns FHIRError? {
    FHIRResponse result1 = check fhirConnector->searchAll(searchParameters = {_id: ["50"]});
    test:assertEquals(result1.httpStatusCode, http:STATUS_OK, "Failed to return the correct status code");
    test:assertEquals(result1.'resource, testSearchDataSet2Json, "Failed to return search result bundle.");

    // Using default params. urlRewrite set to true
    FHIRResponse result2 = check urlRewriteConnector->searchAll(searchParameters = {_id: ["50"]});
    test:assertEquals(result2.httpStatusCode, http:STATUS_OK, "Failed to return the correct status code");
    test:assertEquals(result2.'resource, testSearchDataSet2JsonUrlRewritten, "Failed to return URL rewritten search result bundle.");

    FHIRResponse result3 = check fhirConnector->searchAll(searchParameters = {_id: ["50"]}, mode = POST);
    test:assertEquals(result3.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result3.'resource, testSearchDataSet2Json, "Failed to return the correct Patient bundle.");
}

@test:Config {}
function testBatchRequest() returns FHIRError? {
    // json request
    FHIRResponse result1 = check fhirConnector->batchRequest(testBatchDataJson);
    test:assertEquals(result1.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result1.'resource, testBundleDataJson, "Failed to return batch result bundle.");

    // xml request
    FHIRResponse result2 = check fhirConnector->batchRequest(testBatchDataXml);
    test:assertEquals(result2.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result2.'resource, testBundleDataJson, "Failed to return batch result bundle.");

    // invalid bundle type
    FHIRResponse|FHIRError result3 = fhirConnector->batchRequest(testTransactionDataJson);
    if result3 is FHIRError {
        if result3 is FHIRConnectorError {
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
function testTransaction() returns FHIRError? {
    // json request
    FHIRResponse result1 = check fhirConnector->'transaction(testTransactionDataJson);
    test:assertEquals(result1.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result1.'resource, testBundleDataJson, "Failed to return batch result bundle.");

    // invalid bundle type
    FHIRResponse|FHIRError result2 = fhirConnector->'transaction(testBatchDataJson);
    if result2 is FHIRError {
        if result2 is FHIRConnectorError {
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
function testNextBundle() returns FHIRError? {
    FHIRResponse initialResultJson = check urlRewriteConnector->search(PATIENT);

    // next bundle exists JSON
    FHIRResponse? nextBundleJson = check urlRewriteConnector->nextBundle(initialResultJson);

    if nextBundleJson is FHIRResponse {
        test:assertEquals(nextBundleJson.httpStatusCode, 200, "Failed to return the correct status code");
        test:assertEquals(nextBundleJson.'resource, testSearchDataSet2JsonUrlRewritten, "Failed to get the next page bundle data");

    } else {
        test:assertFail("Failed to retrieve the next bundle");
    }

    // next bundle doesn't exists 
    FHIRResponse? nextBundle2 = check urlRewriteConnector->nextBundle(nextBundleJson);
    if nextBundle2 is () {
        test:assertTrue(true);
    } else {
        test:assertFail("Failed to return () when there is no next bundle");
    }

    // next bundle exists XML
    FHIRResponse initialResultXml = check urlRewriteConnector->search(PATIENT, returnMimeType = FHIR_XML);
    FHIRResponse? nextBundleXml = check urlRewriteConnector->nextBundle(initialResultXml);

    if nextBundleXml is FHIRResponse {
        test:assertEquals(nextBundleXml.httpStatusCode, 200, "Failed to return the correct status code");
        test:assertEquals(nextBundleXml.'resource, testSearchDataSet1XmlUrlRewritten, "Failed to get the next page bundle data");

    } else {
        test:assertFail("Failed to retrieve the next bundle");
    }

}

@test:Config {}
function testPreviousBundle() returns FHIRError?|error {

    FHIRResponse initialResult = check urlRewriteConnector->search(PATIENT);

    //  previous bundle doesn't exists 
    FHIRResponse? prevBundle = check urlRewriteConnector->previousBundle(initialResult);
    if prevBundle is () {
        test:assertTrue(true);
    } else {
        test:assertFail("Failed to return () when there is no previous bundle");
    }

    // previous bundle exists 
    FHIRResponse? nextBundle = check urlRewriteConnector->nextBundle(initialResult);

    FHIRResponse? prevBundle2 = check urlRewriteConnector->previousBundle(nextBundle);
    if prevBundle2 is FHIRResponse {
        test:assertEquals(prevBundle2.httpStatusCode, 200, "Failed to return the correct status code");
        test:assertEquals(prevBundle2.'resource, testSearchDataSet1JsonUrlRewritten, "Failed to get the previous page bundle data");
    } else {
        test:assertFail("Failed to retrieve the previous bundle");
    }

}

@test:Config {}
function testBulkExportKickOff() returns FHIRError? {
    // System export kick off
    FHIRResponse result1 = check fhirConnector->bulkExport(EXPORT_SYSTEM);
    test:assertEquals(result1.httpStatusCode, 202, "Failed to return the correct status code");
    test:assertTrue(result1.serverResponseHeaders["content-location"] != (), "Failed to return bulk export content location header");

    // Patient level export kick off
    FHIRResponse result2 = check fhirConnector->bulkExport(EXPORT_PATIENT);
    test:assertEquals(result2.httpStatusCode, 202, "Failed to return the correct status code");
    test:assertTrue(result2.serverResponseHeaders["content-location"] != (), "Failed to return bulk export content location header");

    // Export group kick off
    FHIRResponse result3 = check fhirConnector->bulkExport(EXPORT_GROUP, "123");
    test:assertEquals(result3.httpStatusCode, 202, "Failed to return the correct status code");
    test:assertTrue(result3.serverResponseHeaders["content-location"] != (), "Failed to return bulk export content location header");

    // Export group kick off with no group id
    FHIRResponse|FHIRError result4 = fhirConnector->bulkExport(EXPORT_GROUP);
    if result4 is FHIRError {
        if result4 is FHIRConnectorError {
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
    FHIRResponse result5 = check fhirConnector->bulkExport(
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
function testBulkExportStatus() returns FHIRError? {
    // System export kick off
    FHIRResponse result1 = check fhirConnector->bulkExport(EXPORT_SYSTEM);
    string pollingUrl = result1.serverResponseHeaders["content-location"] ?: "";

    // Polling the export status
    FHIRResponse result2 = check fhirConnector->bulkStatus(pollingUrl);
    test:assertEquals(result2.httpStatusCode, 202, "Failed to return the correct status code");

    // Polling the export status when export is completed
    FHIRResponse result3 = check fhirConnector->bulkStatus(string `${localhost}${testServerBaseUrl}/exportStatus/2`);
    test:assertEquals(result3.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result3.'resource, testExportFileManifestData, "Failed to return the bulk export manifest");

    // Polling the export status when export is completed - url rewrite is enabled
    FHIRResponse result4 = check urlRewriteConnector->bulkStatus(string `${replacementUrl}/exportStatus/2`);
    test:assertEquals(result4.httpStatusCode, 200, "Failed to return the correct status code");
    test:assertEquals(result4.'resource, testExportFileManifestDataUrlRewritten, "Failed to return the url rewritten bulk export manifest");

}

@test:Config {}
function testBulkExportCancel() returns FHIRError? {
    // System export kick off
    FHIRResponse result1 = check fhirConnector->bulkExport(EXPORT_SYSTEM);
    string pollingUrl = result1.serverResponseHeaders["content-location"] ?: "";

    // Cancel the export
    FHIRResponse result2 = check fhirConnector->bulkDataDelete(pollingUrl);
    test:assertEquals(result2.httpStatusCode, 202, "Failed to return the correct status code");
    test:assertEquals(result2.'resource, testBulkExportCancelResponse, "Failed to return the bulk export cancel success payload");

    // Using an invalid polling url
    FHIRResponse|FHIRError result3 = fhirConnector->bulkDataDelete(string `${localhost}${testServerBaseUrl}/exportStatus/3`);
    if result3 is FHIRError {
        if result3 is FHIRServerError {
            FHIRServerErrorDetails e = result3.detail();
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
    FHIRResponse result1 = check urlRewriteConnector->bulkStatus(string `${replacementUrl}/exportStatus/2`);
    string fileUrl = (check (<json[]>(check (<json>result1.'resource).output))[0].url).toString();

    // Accessing the file
    FHIRBulkFileResponse result2 = check urlRewriteConnector->bulkFile(fileUrl);
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
    FHIRBulkFileResponse|FHIRError result3 = urlRewriteConnector->bulkFile(fileUrl + "invalid");
    if result3 is FHIRError {
        if result3 is FHIRServerError {
            FHIRServerErrorDetails e = result3.detail();
            test:assertEquals(e.httpStatusCode, 404, "Failed to return the correct status code");
            test:assertEquals(e.'resource, testBulkFileInvalidIDResponse, "Failed to return the correct error response payload");
        } else {
            test:assertFail("Failed to respond with the correct error type:FhirServerError");
        }
    } else {
        test:assertFail("Failed to respond with the correct error");
    }
}

@test:Config {}
function testCallOperation() returns FHIRError? {
    // 1. System-level GET operation: $diff
    FHIRResponse diffResp = check fhirConnector->callOperation(
        'type = PATIENT,
        operationName = "diff",
        mode = GET
    );
    test:assertEquals(diffResp.httpStatusCode, 200, "Failed to return the correct status code for $diff");
    test:assertEquals(<json>diffResp.'resource, {"result": "diff-operation-success"}, "Failed to return correct $diff response");

    // 2. Instance-level GET operation: $everything
    FHIRResponse everythingResp = check fhirConnector->callOperation(
        'type = PATIENT,
        operationName = "everything",
        mode = GET,
        id = "pat1"
    );
    test:assertEquals(everythingResp.httpStatusCode, 200, "Failed to return the correct status code for $everything");
    test:assertEquals(<json>everythingResp.'resource, {"result": "everything-operation-success", "id": "pat1"}, "Failed to return correct $everything response");

    // 3. Instance-level POST operation: $validate
    FHIRResponse validateResp = check fhirConnector->callOperation(
        'type = PATIENT,
        operationName = "validate",
        mode = POST,
        id = "pat1",
        data = testGetResourceDataJson
    );
    test:assertEquals(validateResp.httpStatusCode, 200, "Failed to return the correct status code for $validate");
}

@test:AfterSuite
function teardown() returns error? {
    check listenerEP.gracefulStop();
    log:printInfo("FHIR mock service has stopped");

}
