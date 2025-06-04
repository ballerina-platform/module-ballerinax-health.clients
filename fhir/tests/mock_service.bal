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

import ballerina/http;

http:Service FhirMockService = service object {
    // System-level GET operation: $diff
    resource function get Patient/\$diff() returns http:Response {
        http:Response response = new ();
        response.statusCode = http:STATUS_OK;
        response.setPayload({"result": "diff-operation-success"}, FHIR_JSON);
        return response;
    }

    // Instance-level GET operation: $everything
    resource function get Patient/[string id]/\$everything() returns http:Response {
        http:Response response = new ();
        if id == "pat1" {
            response.statusCode = http:STATUS_OK;
            response.setPayload({"result": "everything-operation-success", "id": id}, FHIR_JSON);
        } else {
            response.statusCode = http:STATUS_NOT_FOUND;
            response.setPayload({"error": "Patient not found"}, FHIR_JSON);
        }
        return response;
    }

    // Instance-level POST operation: $validate
    resource function post Patient/[string id]/\$validate(http:Request req) returns http:Response {
        http:Response response = new ();
        json|error payload = req.getJsonPayload();
        if id == "pat1" && payload is json {
            response.statusCode = http:STATUS_OK;
            response.setPayload({"result": "validate-operation-success", "id": id, "resource": payload}, FHIR_JSON);
        } else {
            response.statusCode = http:STATUS_BAD_REQUEST;
            response.setPayload({"error": "Invalid patient or payload"}, FHIR_JSON);
        }
        return response;
    }

    resource function get [string 'type]/[string id](string? _format) returns http:Response {
        http:Response response = new ();
        if id == "pat1" {
            response.statusCode = http:STATUS_OK;
            if _format == () || _format == FHIR_JSON {
                response.setPayload(testGetResourceDataJson, FHIR_JSON);
            } else {
                response.setPayload(testGetResourceDataXml, FHIR_XML);
            }
        } else if 'type == PATIENT && id == EXPORT {
            response.statusCode = http:STATUS_ACCEPTED;
            response.setHeader(CONTENT_LOCATION, string `${localhost}${testServerBaseUrl}/exportStatus/1`);
            return response;
        } else {
            response.statusCode = http:STATUS_NOT_FOUND;
            response.setPayload(testGetResourceFailedData, FHIR_JSON);
        }
        return response;
    }

    resource function get [string 'type]/[string id]/_history/[string vid](string? _format) returns http:Response {
        http:Response response = new ();
        if vid == "100" {
            response.statusCode = http:STATUS_OK;
            if _format == () || _format == FHIR_JSON {
                response.setPayload(testGetResourceDataJson, FHIR_JSON);
            } else {
                response.setPayload(testGetResourceDataXml, FHIR_XML);
            }
        } else {
            response.statusCode = http:STATUS_NOT_FOUND;
            response.setPayload(testGetResourceFailedData, FHIR_JSON);
        }
        return response;
    }

    @http:ResourceConfig {
        consumes: ["application/fhir+json", "application/fhir+xml"]
    }
    resource function put [string 'type]/[string id](http:Request payload) returns http:Response|error {
        http:Response response = new ();
        response.statusCode = http:STATUS_OK;
        response.addHeader(LOCATION, string `base_url/fhir/Patient/${id}/_history/100`);

        string|error preference = payload.getHeader(PREFER_HEADER);

        if preference is string && preference != MINIMAL {
            response.setPayload(testGetResourceDataJson, FHIR_JSON);
        }
        check response.setContentType(FHIR_JSON);
        return response;
    }

    @http:ResourceConfig {
        consumes: [
            "application/json",
            "application/xml",
            "application/fhir+json",
            "application/fhir+xml",
            "application/json-patch+json",
            "application/xml-patch+xml"
        ]
    }
    resource function patch [string 'type]/[string id](http:Request payload) returns http:Response {
        http:Response response = new ();
        if id == "pat1" {
            response.statusCode = http:STATUS_OK;
            response.addHeader(LOCATION, string `base_url/fhir/Patient/${id}/_history/100`);

            string|error preference = payload.getHeader(PREFER_HEADER);

            if preference is string && preference != MINIMAL {
                response.setPayload(testGetResourceDataJson, FHIR_JSON);
            }
        } else {
            response.statusCode = http:STATUS_NOT_FOUND;
            response.setPayload(testPatchResourceFailedData, FHIR_JSON);
        }
        return response;
    }

    resource function delete [string 'type]/[string id]() returns http:Response {
        http:Response response = new ();
        if id == "pat1" {
            response.statusCode = http:STATUS_NO_CONTENT;
        } else {
            response.statusCode = http:STATUS_NOT_FOUND;
            response.setPayload(testDeleteResourceFailedData, FHIR_JSON);
        }
        return response;
    }

    resource function get [string 'type]/[string id]/_history(string? _format) returns http:Response|error {
        http:Response response = new ();
        if id == "pat1" {
            response.statusCode = http:STATUS_OK;
            if _format == () || _format == FHIR_JSON {
                response.setPayload(testGetResourceDataJson, FHIR_JSON);
            } else {
                response.setPayload(testGetResourceDataXml, FHIR_XML);
            }
        } else {
            response.statusCode = http:STATUS_NOT_FOUND;
            response.setPayload(testGetResourceFailedData, FHIR_JSON);
        }
        return response;
    }

    @http:ResourceConfig {
        consumes: ["application/fhir+json", "application/fhir+xml"]
    }
    resource function post [string 'type](http:Request payload) returns http:Response {
        http:Response response = new ();
        response.statusCode = http:STATUS_CREATED;
        response.addHeader(LOCATION, "base_url/fhir/Patient/pat1/_history/100");

        string|error preference = payload.getHeader(PREFER_HEADER);

        if preference is string && preference != MINIMAL {
            response.setPayload(testGetResourceDataJson, FHIR_JSON);
        }
        return response;
    }

    resource function get [string 'type](string? offset, string? _format) returns http:Response {
        http:Response response = new ();

        if ('type == "$export") {
            response.statusCode = http:STATUS_ACCEPTED;
            response.setHeader(CONTENT_LOCATION, string `${localhost}${testServerBaseUrl}/exportStatus/1`);
            return response;
        }

        response.statusCode = http:STATUS_OK;
        if _format == FHIR_JSON || _format == () {
            if offset == "0" || offset is () {
                response.setPayload(testSearchDataSet1Json, FHIR_JSON);

            } else if offset == "1" {
                response.setPayload(testSearchDataSet2Json, FHIR_JSON);

            }
        } else {
            response.setPayload(testSearchDataSet1Xml, FHIR_XML);
        }
        return response;
    }

    resource function post [string 'type]/_search(string? offset, string? _format) returns http:Response {
        http:Response response = new ();

        if ('type == "$export") {
            response.statusCode = http:STATUS_ACCEPTED;
            response.setHeader(CONTENT_LOCATION, string `${localhost}${testServerBaseUrl}/exportStatus/1`);
            return response;
        }

        response.statusCode = http:STATUS_OK;
        if _format == FHIR_JSON || _format == () {
            if offset == "0" || offset is () {
                response.setPayload(testSearchDataSet1Json, FHIR_JSON);

            } else if offset == "1" {
                response.setPayload(testSearchDataSet2Json, FHIR_JSON);

            }
        } else {
            response.setPayload(testSearchDataSet1Xml, FHIR_XML);
        }
        return response;
    }

    resource function get [string 'type]/_history() returns http:Response {
        http:Response response = new ();
        response.statusCode = http:STATUS_OK;
        response.setPayload(testHistoryDataJson, FHIR_JSON);
        return response;

    }

    resource function get metadata(string? mode, string? _format) returns http:Response {
        http:Response response = new ();
        response.statusCode = http:STATUS_OK;
        if mode == FULL {
            if _format == FHIR_JSON || _format == () {
                response.setPayload(testCapabilityStatementJson, FHIR_JSON);
            } else {
                response.setPayload(testCapabilityStatementXml, FHIR_XML);
            }
        } else {
            if _format == FHIR_JSON || _format == () {
                response.setPayload(testCapStatementData, FHIR_JSON);
            } else {
                response.setPayload(testCapStatementDataXml, FHIR_XML);
            }
        }
        return response;
    }

    resource function get _history() returns http:Response {
        http:Response response = new ();
        response.statusCode = http:STATUS_OK;
        response.setPayload(testHistoryDataJson, FHIR_JSON);
        return response;
    }

    resource function get .() returns http:Response {
        http:Response response = new ();
        response.statusCode = http:STATUS_OK;
        response.setPayload(testSearchDataSet2Json, FHIR_JSON);
        return response;
    }

    resource function post _search() returns http:Response {
        http:Response response = new ();
        response.statusCode = http:STATUS_OK;
        response.setPayload(testSearchDataSet2Json, FHIR_JSON);
        return response;
    }

    resource function post .() returns http:Response {
        http:Response response = new ();
        response.statusCode = http:STATUS_OK;
        response.setPayload(testBundleDataJson, FHIR_JSON);
        return response;
    }

    resource function get Group/[string id]/[string export]() returns http:Response {
        http:Response response = new ();
        if export == EXPORT {
            response.statusCode = http:STATUS_ACCEPTED;
            response.setHeader(CONTENT_LOCATION, string `${localhost}${testServerBaseUrl}/exportStatus/1`);
            return response;
        }
        response.statusCode = http:STATUS_NOT_FOUND;
        response.setPayload(testGetResourceFailedData, FHIR_JSON);
        return response;
    }

    resource function get exportStatus/[string id]() returns http:Response {
        http:Response response = new ();
        if id == "1" {
            response.statusCode = http:STATUS_ACCEPTED;
            response.setHeader("X-Progress", "Build in progress - Status set to BUILDING ");
        } else {
            response.statusCode = http:STATUS_OK;
            response.setPayload(testExportFileManifestData, FHIR_JSON);
        }
        return response;
    }

    resource function delete exportStatus/[string id]() returns http:Response {
        http:Response response = new ();
        if id == "1" {
            response.statusCode = http:STATUS_ACCEPTED;
            response.setPayload(testBulkExportCancelResponse, FHIR_JSON);
        } else {
            response.statusCode = http:STATUS_NOT_FOUND;
            response.setPayload(testBulkExportCancelInvalidIDResponse, FHIR_JSON);
        }
        return response;
    }

    resource function get Binary/[string id]() returns http:Response {
        http:Response response = new ();
        if id == "123" {
            response.statusCode = http:STATUS_OK;
            response.setPayload(testBulkExportFileData, FHIR_ND_JSON);
        } else {
            response.statusCode = http:STATUS_NOT_FOUND;
            response.setPayload(testBulkFileInvalidIDResponse, FHIR_JSON);
        }
        return response;
    }

};

