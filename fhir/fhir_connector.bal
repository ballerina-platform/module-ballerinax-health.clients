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
import ballerinax/health.base.auth;

# This connector allows you to connect and interact with any FHIR server
@display {label: "FHIR Client Connector"}
public isolated client class FHIRConnector {
    
    # The base URL of the FHIR server
    private final string baseUrl;

    # Whether to rewrite the server URLs in the response payloads
    private final boolean urlRewrite;

    # The replacement URL to be used when rewriting the server URLs
    private final string? replacementURL;

    # The MIME type of the response
    private final MimeType mimeType;

    # The HTTP client to be used for FHIR server communication
    private final http:Client httpClient;

    # The PKJWTAuthHandler if the FHIR server is secured with PKJWT
    private final auth:PKJWTAuthHandler? pkjwtHanlder;

    # The HTTP client to be used for bulk file server communication
    private final http:Client bulkFileHttpClient;

    # The file server URL of the FHIR server
    private final string? fileServerUrl;

    # Initializes the FHIR client connector
    #
    # + connectorConfig - FHIR connector configurations
    # + httpClientConfig - HTTP client configurations
    public function init(FHIRConnectorConfig connectorConfig) returns error? {
        self.baseUrl = connectorConfig.baseURL.endsWith(SLASH) 
            ? connectorConfig.baseURL.substring(0, connectorConfig.baseURL.length() - 1) 
            : connectorConfig.baseURL;
        self.urlRewrite = connectorConfig.urlRewrite;
        self.replacementURL = connectorConfig.replacementURL;
        self.mimeType = connectorConfig.mimeType;
        
        // initialize fhir server http client
        (http:ClientAuthConfig|auth:PKJWTAuthConfig)? authConfig = connectorConfig.authConfig;
        if authConfig is () || authConfig is http:ClientAuthConfig {
            self.httpClient = check new (connectorConfig.baseURL, constructHttpConfigs(connectorConfig));
            self.pkjwtHanlder = ();
        } else {
            self.httpClient = check new (connectorConfig.baseURL);
            self.pkjwtHanlder = new (authConfig);
        }

        BulkFileServerConfig? bulkFileServerConfig = connectorConfig.bulkFileServerConfig;
        if bulkFileServerConfig is BulkFileServerConfig {
            // initialize bulk file server http client
            self.bulkFileHttpClient = check new (bulkFileServerConfig.fileServerUrl, constructHttpConfigs(bulkFileServerConfig));
            self.fileServerUrl = bulkFileServerConfig.fileServerUrl;
        } else {
            self.bulkFileHttpClient = self.httpClient;
            self.fileServerUrl = ();
        }
        if connectorConfig.urlRewrite && connectorConfig.replacementURL == () {
            return error FHIRConnectorError(string `${FHIR_CONNECTOR_ERROR}: ${REPLACEMENT_URL_NOT_PROVIDED}`);
        }
    }

    # Retrieves a FHIR Resource by the resource logical ID
    #
    # + 'type - The name of the resource type  
    # + id - The logical id of the resource  
    # + returnMimeType - The MIME type of the response  
    # + summary - The subset of the resource content to be returned
    # + return - If successful, FhirResponse record else FhirError record
    @display {label: "Get resource by the logical ID"}
    remote isolated function getById(@display {label: "Resource Type"} ResourceType|string 'type,
            @display {label: "Logical ID"} string id,
            @display {label: "Return MIME Type"} MimeType? returnMimeType = (),
            @display {label: "Summary"} SummaryType? summary = ())
            returns FHIRResponse|FHIRError {
        map<string> headerMap = {[ACCEPT_HEADER] : self.mimeType};
        string requestURL = SLASH + 'type + SLASH + id + setFormatNSummaryParameters(returnMimeType, summary);
        do {
            http:Response response = check self.httpClient->get(requestURL, check enrichHeaders(headerMap, self.pkjwtHanlder));
            FHIRResponse result = check getFhirResourceResponse(response);
            if self.urlRewrite {
                return rewriteServerUrl(result, self.baseUrl, replacementUrl = self.replacementURL);
            }
            return result;
        } on fail error e {
            if e is FHIRError {
                return e;
            }
            return error(string `${FHIR_CONNECTOR_ERROR}: ${e.message()}`, errorDetails = e);
        }
    }

    # Retrieves a version specific FHIR resource
    #
    # + 'type - The name of the resource type    
    # + id - The logical id of the resource  
    # + 'version - the version id  
    # + returnMimeType - The MIME type of the response  
    # + summary - The subset of the resource content to be returned
    # + return - If successful, FhirResponse record else FhirError record
    @display {label: "Get resource by version"}
    remote isolated function getByVersion(@display {label: "Resource Type"} ResourceType|string 'type,
            @display {label: "Logical ID"} string id,
            @display {label: "Version ID"} string 'version,
            @display {label: "Return MIME Type"} MimeType? returnMimeType = (),
            @display {label: "Summary"} SummaryType? summary = ())
                                                returns FHIRResponse|FHIRError {
        map<string> headerMap = {[ACCEPT_HEADER] : self.mimeType};
        string requestURL = SLASH + 'type + SLASH + id + SLASH + _HISTORY + SLASH + 'version
                            + setFormatNSummaryParameters(returnMimeType, summary);
        do {
            http:Response response = check self.httpClient->get(requestURL, check enrichHeaders(headerMap, self.pkjwtHanlder));
            FHIRResponse result = check getFhirResourceResponse(response);
            if self.urlRewrite {
                return rewriteServerUrl(result, self.baseUrl, replacementUrl = self.replacementURL);
            }
            return result;
        } on fail error e {
            if e is FHIRError {
                return e;
            }
            return error(string `${FHIR_CONNECTOR_ERROR}: ${e.message()}`, errorDetails = e);
        }
    }

    # Updates an existing resource or creates a new resource if the resource doesn't exist.
    #
    # + data - Resource data  
    # + onCondition - Condition for a conditional update operation.  
    #   - To perform a conditional update, you can:
    #     - Provide the conditional URL directly as a string (e.g., `"Patient?identifier=12345"`).
    #     - Or, provide conditional parameters as a `SearchParameters` or `map<string[]>`, which will be used to construct the conditional URL.
    #   - If not specified, a normal update is performed.
    # + returnMimeType - The MIME type of the response 
    # + returnPreference - To specify the content of the return response
    # + return - If successful, FhirResponse record else FhirError record
    @display {label: "Update resource"}
    remote isolated function update(@display {label: "Resource data"} json|xml data,
            @display {label: "Condition for a Conditional Update"} OnCondition? onCondition = (),
            @display {label: "Return MIME Type"} MimeType? returnMimeType = (),
            @display {label: "Return Preference Type"} PreferenceType returnPreference = MINIMAL)
                                            returns FHIRResponse|FHIRError {
        do {
            http:Request request = setCreateUpdatePatchResourceRequest(self.mimeType, returnPreference, data);
            
            string requestURL;
            if onCondition is string {
                requestURL = onCondition;
            } else {
                ResourceTypeNId typeIdInfo = check extractResourceTypeNId(data);
                requestURL = SLASH + typeIdInfo.'type;
                string? id = typeIdInfo.id;
                if (id is string) {
                    requestURL += SLASH + id;
                }
                requestURL += QUESTION_MARK;
                if onCondition is SearchParameters|map<string[]> {
                    requestURL += getConditionalUrl(onCondition) + AMPERSAND;
                }
                if id is () && onCondition is () {
                    return error(string `${FHIR_CONNECTOR_ERROR}: ` + MISSING_ID_OR_CONDITION, errorDetails = error(string `Either 'id' or 'onCondition' must be provided for update operation.`));
                }
            }
            requestURL += setFormatParameters(returnMimeType);
            
            http:Response response = check self.httpClient->put(sanitizeRequestUrl(requestURL), check enrichRequest(request, self.pkjwtHanlder));
            FHIRResponse result = check getAlteredResourceResponse(response, returnPreference);
            if self.urlRewrite {
                return rewriteServerUrl(result, self.baseUrl, replacementUrl = self.replacementURL);
            }
            return result;
        } on fail error e {
            if e is FHIRError {
                return e;
            }
            return error(string `${FHIR_CONNECTOR_ERROR}: ${e.message()}`, errorDetails = e);
        }
    }

    # Partially Updates an existing resource
    #
    # + 'type - The name of the resource type 
    # + id - The logical id of the resource  
    # + data - Resource data  
    # + onCondition - Condition for a conditional patch operation.  
    #   - To perform a conditional patch, you can:
    #     - Provide the conditional URL directly as a string (e.g., `"Patient?identifier=12345"`).
    #     - Or, provide conditional parameters as a `SearchParameters`, or `map<string[]>`, which will be used to construct the conditional URL.
    #   - If not specified, a normal patch is performed.
    # + returnMimeType - The MIME type of the response  
    # + patchContentType - Content type of the patch payload
    # + returnPreference - To specify the content of the return response
    # + return - If successful, FhirResponse record else FhirError record
    @display {label: "Patch resource"}
    remote isolated function patch(@display {label: "Resource Type"} ResourceType|string 'type,
            @display {label: "Resource data"} json|xml data,
            @display {label: "Logical ID"} string? id = (),
            @display {label: "Condition for a Conditional Patch"} OnCondition? onCondition = (),
            @display {label: "Return MIME Type"} MimeType? returnMimeType = (),
            @display {label: "Patch Content Type"} MimeType|PatchContentType? patchContentType = (),
            @display {label: "Return Preference Type"} PreferenceType returnPreference = MINIMAL)
                                        returns FHIRResponse|FHIRError {
        do {
            http:Request request = setPatchResourceRequest(self.mimeType, returnPreference, data, patchContentType);

            string requestURL;
            if onCondition is string {
                requestURL = onCondition;
            } else {
                requestURL = SLASH + 'type;
                if (id is string) {
                    requestURL += SLASH + id;
                }
                requestURL += QUESTION_MARK;

                if onCondition is SearchParameters|map<string[]> {
                    requestURL += getConditionalUrl(onCondition) + AMPERSAND;
                }

                if id is () && onCondition is () {
                    return error(string `${FHIR_CONNECTOR_ERROR}: ` + MISSING_ID_OR_CONDITION, errorDetails = error(string `Either 'id' or 'onCondition' must be provided for patch operation.`));
                }
            }
            requestURL += setFormatParameters(returnMimeType);

            http:Response response = check self.httpClient->patch(sanitizeRequestUrl(requestURL), check enrichRequest(request, self.pkjwtHanlder));
            FHIRResponse result = check getAlteredResourceResponse(response, returnPreference);
            if self.urlRewrite {
                return rewriteServerUrl(result, self.baseUrl, replacementUrl = self.replacementURL);
            }
            return result;
        } on fail error e {
            if e is FHIRError {
                return e;
            }
            return error(string `${FHIR_CONNECTOR_ERROR}: ${e.message()}`, errorDetails = e);
        }
    }

    # Deletes an existing resource.
    #
    # + 'type - The name of the resource type    
    # + id - The logical id of the resource 
    # + onCondition - Condition for a conditional delete operation.  
    #   - To perform a conditional delete, you can:
    #     - Provide the conditional URL directly as a string (e.g., `"Patient?identifier=12345"`).
    #     - Or, provide conditional parameters as a `SearchParameters`, or `map<string[]>`, which will be used to construct the conditional URL.
    #   - If not specified, a normal delete is performed.
    # + return - If successful, FhirResponse record else FhirError record
    @display {label: "Delete  resource"}
    remote isolated function delete(@display {label: "Resource Type"} ResourceType|string 'type,
            @display {label: "Logical ID"} string? id = (),
            @display {label: "Condition for a Conditional Delete"} OnCondition? onCondition = ())
                                            returns FHIRResponse|FHIRError {
        if id is () && onCondition is () {
            return error(string `${FHIR_CONNECTOR_ERROR}: ` + MISSING_ID_OR_CONDITION, errorDetails = error(string `Either 'id' or 'onCondition' must be provided for delete operation.`));
        }
        string requestURL = SLASH + 'type;
        if id is string {
            requestURL += SLASH + id;
        }
        if onCondition is SearchParameters|map<string[]> {
            requestURL += QUESTION_MARK + getConditionalUrl(onCondition);
        }
        do {
            http:Response response = check self.httpClient->delete(sanitizeRequestUrl(requestURL), check enrichHeaders({}, self.pkjwtHanlder));
            FHIRResponse result = check getDeleteResourceResponse(response);
            if self.urlRewrite {
                return rewriteServerUrl(result, self.baseUrl, replacementUrl = self.replacementURL);
            }
            return result;
        } on fail error e {
            if e is FHIRError {
                return e;
            }
            return error(string `${FHIR_CONNECTOR_ERROR}: ${e.message()}`, errorDetails = e);
        }
    }

    # Retrieves the change history of particular resource
    #
    # + 'type - The name of the resource type 
    # + id - The logical id of the resource  
    # + parameters - The history search parameters 
    # + returnMimeType - The MIME type of the response
    # + return - If successful, FhirResponse record else FhirError record
    @display {label: "Get instance history"}
    remote isolated function getInstanceHistory(@display {label: "Resource Type"} ResourceType|string 'type,
            @display {label: "Logical ID"} string id,
            @display {label: "History Search Parameters"} HistorySearchParameters parameters = {},
            @display {label: "Return MIME Type"} MimeType? returnMimeType = ())
                                            returns FHIRResponse|FHIRError {
        string requestUrl = SLASH + 'type + SLASH + id + SLASH + _HISTORY + setHistoryParams(parameters, returnMimeType);
        map<string> headerMap = {[ACCEPT_HEADER] : self.mimeType};
        do {
            http:Response response = check self.httpClient->get(requestUrl, check enrichHeaders(headerMap, self.pkjwtHanlder));
            FHIRResponse result = check getBundleResponse(response);
            if self.urlRewrite {
                return rewriteServerUrl(result, self.baseUrl, replacementUrl = self.replacementURL);
            }
            return result;
        } on fail error e {
            if e is FHIRError {
                return e;
            }
            return error(string `${FHIR_CONNECTOR_ERROR}: ${e.message()}`, errorDetails = e);
        }
    }

# Creates a new resource
    #
    # + data - Resource data  
    # + onCondition - Condition for a conditional create operation.  
    #   - To perform a conditional create, you can:
    #     - Provide the conditional URL directly as a string (e.g., `"Patient?identifier=12345"`).
    #     - Or, provide conditional parameters as a `SearchParameters`, or `map<string[]>`, which will be used to construct the conditional URL.
    #   - If not specified, a normal create is performed.
    # + returnMimeType - The MIME type of the response 
    # + returnPreference - To specify the content of the return response
    # + return - If successful, FhirResponse record else FhirError record
    @display {label: "Create resource"}
    remote isolated function create(@display {label: "Resource data"} json|xml data,
            @display {label: "Condition for a Conditional Create"} OnCondition? onCondition = (),
            @display {label: "Return MIME Type"} MimeType? returnMimeType = (),
            @display {label: "Return Preference Type"} PreferenceType returnPreference = MINIMAL)
                                            returns FHIRResponse|FHIRError {
        do {
            ResourceTypeNId typeIdInfo = check extractResourceTypeNId(data, extractId = false);
            string? conditionalUrl = ();
            if onCondition is SearchParameters|map<string[]> {
                conditionalUrl = self.baseUrl + SLASH + typeIdInfo.'type + QUESTION_MARK + getConditionalUrl(onCondition);
            } else {
                conditionalUrl = onCondition;
            }
            http:Request request = setCreateUpdatePatchResourceRequest(self.mimeType, returnPreference, data, conditionalUrl);
            string requestURL = SLASH + typeIdInfo.'type + QUESTION_MARK + setFormatParameters(returnMimeType);
            http:Response response = check self.httpClient->post(sanitizeRequestUrl(requestURL), check enrichRequest(request, self.pkjwtHanlder));
            FHIRResponse result = check getAlteredResourceResponse(response, returnPreference);
            if self.urlRewrite {
                return rewriteServerUrl(result, self.baseUrl, replacementUrl = self.replacementURL);
            }
            return result;
        } on fail error e {
            if e is FHIRError {
                return e;
            }
            return error(string `${FHIR_CONNECTOR_ERROR}: ${e.message()}`, errorDetails = e);
        }
    }

    # Searches all resources of a particular type
    #
    # + 'type - The name of the resource type  
    # + mode - The request mode, GET or POST
    # + searchParameters - The search parameters 
    # + returnMimeType - The MIME type of the response
    # + return - If successful, FhirResponse record else FhirError record
    @display {label: "search resource"}
    remote isolated function search(@display {label: "Resource Type"} ResourceType|string 'type,
            @display {label: "Request Mode"} RequestMode mode = GET,
            @display {label: "Search Parameters"} SearchParameters|map<string[]>? searchParameters = (),
            @display {label: "Return MIME Type"} MimeType? returnMimeType = ())
                                    returns FHIRResponse|FHIRError {
        string requestUrl = SLASH + 'type;
        map<string> headerMap = {[ACCEPT_HEADER] : self.mimeType};
        do {
            http:Response response;
            
            if mode == GET {
                requestUrl += setSearchParams(searchParameters, returnMimeType);

                response = check self.httpClient->get(requestUrl, check enrichHeaders(headerMap, self.pkjwtHanlder));
            } else {
                requestUrl += SLASH + _SEARCH + setSearchParams((), returnMimeType);

                http:Request req = new;
                req.setTextPayload(createSearchFormData(searchParameters), contentType = APPLICATION_X_WWW_FORM_URLENCODED);

                response = check self.httpClient->post(requestUrl, req, check enrichHeaders(headerMap, self.pkjwtHanlder));
            }
            
            FHIRResponse result = check getBundleResponse(response);
            if self.urlRewrite {
                return rewriteServerUrl(result, self.baseUrl, replacementUrl = self.replacementURL);
            }
            return result;
        } on fail error e {
            if e is FHIRError {
                return e;
            }
            return error(string `${FHIR_CONNECTOR_ERROR}: ${e.message()}`, errorDetails = e);
        }
    }

    # Retrieves the change history of a particular resource type.
    #
    # + 'type - The name of the resource type 
    # + parameters - The history search parameters 
    # + returnMimeType - The MIME type of the response
    # + return - If successful, FhirResponse record else FhirError record
    @display {label: "Get history for a type"}
    remote isolated function getHistory(@display {label: "Resource Type"} ResourceType|string 'type,
            @display {label: "History Search Parameters"} HistorySearchParameters parameters = {},
            @display {label: "Return MIME Type"} MimeType? returnMimeType = ())
                            returns FHIRResponse|FHIRError {
        string requestUrl = SLASH + 'type + SLASH + _HISTORY + setHistoryParams(parameters, returnMimeType);
        map<string> headerMap = {[ACCEPT_HEADER] : self.mimeType};
        do {
            http:Response response = check self.httpClient->get(requestUrl, check enrichHeaders(headerMap, self.pkjwtHanlder));
            FHIRResponse result = check getBundleResponse(response);
            if self.urlRewrite {
                return rewriteServerUrl(result, self.baseUrl, replacementUrl = self.replacementURL);
            }
            return result;
        } on fail error e {
            if e is FHIRError {
                return e;
            }
            return error(string `${FHIR_CONNECTOR_ERROR}: ${e.message()}`, errorDetails = e);
        }
    }

    # Retrieves information about the server capabilities
    #
    # + mode - The information type required from the server  
    # + returnMimeType - The MIME type of the response  
    # + uriParameters - The additional parameters like _summary, _elements, refer the server capabilities
    # + return - If successful, FhirResponse record else FhirError record
    @display {label: "Get capability statement"}
    remote isolated function getConformance(@display {label: "Mode"} ModeType mode = FULL,
            @display {label: "Return MIME Type"} MimeType? returnMimeType = (),
            @display {label: "Return MIME Type"} map<anydata>? uriParameters = ())
                                            returns FHIRResponse|FHIRError {
        string requestUrl = SLASH + METADATA + QUESTION_MARK + MODE + EQUALS_SIGN + mode +
                            setCapabilityParams(uriParameters, returnMimeType);
        map<string> headerMap = {[ACCEPT_HEADER] : self.mimeType};
        do {
            http:Response response = check self.httpClient->get(requestUrl, headerMap);
            FHIRResponse result = check getFhirResourceResponse(response);
            if self.urlRewrite {
                return rewriteServerUrl(result, self.baseUrl, replacementUrl = self.replacementURL);
            }
            return result;
        } on fail error e {
            if e is FHIRError {
                return e;
            }
            return error(string `${FHIR_CONNECTOR_ERROR}: ${e.message()}`, errorDetails = e);
        }
    }

    # Retrieves the change history for all resources supported by the server.
    #
    # + parameters - The history search parameters 
    # + returnMimeType - The MIME type of the response
    # + return - If successful, FhirResponse record else FhirError record
    @display {label: "Get all history"}
    remote isolated function getAllHistory(@display {label: "History Search Parameters"} HistorySearchParameters parameters = {},
            @display {label: "Return MIME Type"} MimeType? returnMimeType = ())
                                            returns FHIRResponse|FHIRError {
        string requestUrl = SLASH + _HISTORY + setHistoryParams(parameters, returnMimeType);
        map<string> headerMap = {[ACCEPT_HEADER] : self.mimeType};
        do {
            http:Response response = check self.httpClient->get(requestUrl, check enrichHeaders(headerMap, self.pkjwtHanlder));
            FHIRResponse result = check getBundleResponse(response);
            if self.urlRewrite {
                return rewriteServerUrl(result, self.baseUrl, replacementUrl = self.replacementURL);
            }
            return result;
        } on fail error e {
            if e is FHIRError {
                return e;
            }
            return error(string `${FHIR_CONNECTOR_ERROR}: ${e.message()}`, errorDetails = e);
        }
    }

    # Searches across all resources types
    #
    # + searchParameters - The search parameters that are common across all resources 
    # + mode - The request mode, GET or POST
    # + returnMimeType - The MIME type of the response
    # + return - If successful, FhirResponse record else FhirError record
    @display {label: "Search across all resources"}
    remote isolated function searchAll(
            @display {label: "Search Parameters"} SearchParameters|map<string[]> searchParameters,
            @display {label: "Request Mode"} RequestMode mode = GET,
            @display {label: "Return MIME Type"} MimeType? returnMimeType = ())
                                        returns FHIRResponse|FHIRError {
        string requestUrl;
        map<string> headerMap = {[ACCEPT_HEADER] : self.mimeType};
        do {
            http:Response response;
            if mode == GET {
                requestUrl = QUESTION_MARK + setSearchParams(searchParameters, returnMimeType);
                response = check self.httpClient->get(requestUrl, check enrichHeaders(headerMap, self.pkjwtHanlder));
            } else {
                requestUrl = SLASH + _SEARCH + setSearchParams((), returnMimeType);

                http:Request req = new;
                req.setTextPayload(createSearchFormData(searchParameters), contentType = APPLICATION_X_WWW_FORM_URLENCODED);

                response = check self.httpClient->post(requestUrl, req, check enrichHeaders(headerMap, self.pkjwtHanlder));
            }
            FHIRResponse result = check getBundleResponse(response);
            if self.urlRewrite {
                return rewriteServerUrl(result, self.baseUrl, replacementUrl = self.replacementURL);
            }
            return result;
        } on fail error e {
            if e is FHIRError {
                return e;
            }
            return error(string `${FHIR_CONNECTOR_ERROR}: ${e.message()}`, errorDetails = e);
        }
    }

    # Submits a set of actions to perform on a server in a single request, actions will be performed independently as a batch 
    #
    # + data - Resource data
    # + returnMimeType - The MIME type of the response
    # + return - If successful, FhirResponse record else FhirError record
    @display {label: "Batch operation"}
    remote isolated function batchRequest(@display {label: "Resource data"} json|xml data,
            @display {label: "Return MIME Type"} MimeType? returnMimeType = ())
                                        returns FHIRResponse|FHIRError {
        string requestUrl = QUESTION_MARK + setFormatParameters(returnMimeType);
        do {
            boolean validatedResult = check validateBundleData(data, BATCH);
            if validatedResult {
                http:Request request = setBundleRequest(data, self.mimeType);
                http:Response response = check self.httpClient->post(requestUrl, check enrichRequest(request, self.pkjwtHanlder));
                FHIRResponse result = check getBundleResponse(response);
                if self.urlRewrite {
                    return rewriteServerUrl(result, self.baseUrl, replacementUrl = self.replacementURL);
                }
                return result;
            } else {
                return error(FHIR_CONNECTOR_ERROR, errorDetails = error(BUNDLE_TYPE_ERROR + BATCH));
            }
        } on fail error e {
            if e is FHIRError {
                return e;
            }
            return error(string `${FHIR_CONNECTOR_ERROR}: ${e.message()}`, errorDetails = e);
        }
    }

    # Submits a set of actions to perform on a server in a single request,actions will be performed as a single atomic transaction
    #
    # + data - Resource data
    # + returnMimeType - The MIME type of the response
    # + return - If successful, FhirResponse record else FhirError record
    @display {label: "Transaction operation"}
    remote isolated function 'transaction(@display {label: "Resource data"} json|xml data,
            @display {label: "Return MIME Type"} MimeType? returnMimeType = ())
                                        returns FHIRResponse|FHIRError {
        string requestUrl = QUESTION_MARK + setFormatParameters(returnMimeType);
        do {
            boolean validatedResult = check validateBundleData(data, TRANSACTION);
            if validatedResult {
                http:Request request = setBundleRequest(data, self.mimeType);
                http:Response response = check self.httpClient->post(requestUrl, check enrichRequest(request, self.pkjwtHanlder));
                FHIRResponse result = check getBundleResponse(response);
                if self.urlRewrite {
                    return rewriteServerUrl(result, self.baseUrl, replacementUrl = self.replacementURL);
                }
                return result;
            } else {
                return error(FHIR_CONNECTOR_ERROR, errorDetails = error(BUNDLE_TYPE_ERROR + TRANSACTION));
            }

        } on fail error e {
            if e is FHIRError {
                return e;
            }
            return error(string `${FHIR_CONNECTOR_ERROR}: ${e.message()}`, errorDetails = e);
        }
    }

    # Provides support to paginate through resources where applicable(ex: History, Search related bundle resources), retrieves the next bundle if it exists
    #
    # + currentBundle - Current bundle resource should be generated as a result of invoking a connector method. This is to ensure consistency of urlRewrite feature. If the urlRewrite is enabled, the current bundles' urls should be rewritten. 
    # + return - If successful, FhirResponse record else FhirError record
    @display {label: "Get next page of a bundle resource"}
    remote isolated function nextBundle(@display {label: "Current Bundle"} FHIRResponse|json|xml currentBundle)
                                        returns FHIRResponse|FHIRError? {
        do {
            // If the urlRewrite is enabled, replacementURL is of type string, we can cast it safely here.
            string? nextUrl = check extractNextPageUrl(currentBundle, self.urlRewrite ? <string>self.replacementURL : self.baseUrl);
            if nextUrl is () {
                return ();
            }
            map<string> headerMap = {[ACCEPT_HEADER] : self.mimeType};
            http:Response response = check self.httpClient->get(nextUrl, check enrichHeaders(headerMap, self.pkjwtHanlder));
            FHIRResponse result = check getBundleResponse(response);
            if self.urlRewrite {
                return rewriteServerUrl(result, self.baseUrl, replacementUrl = self.replacementURL);
            }
            return result;
        } on fail error e {
            if e is FHIRError {
                return e;
            }
            return error(string `${FHIR_CONNECTOR_ERROR}: ${e.message()}`, errorDetails = e);
        }
    }

    # Provides support to paginate through resources where applicable(ex: History, Search related bundle resources), retrieves the previous bundle if it exists
    #
    # + currentBundle - Current bundle resource should be generated as a result of invoking a connector method. This is to ensure consistency of urlRewrite feature. If the urlRewrite is enabled, the current bundles' urls should be rewritten. 
    # + return - If successful, FhirResponse record else FhirError record
    @display {label: "Get previous page of a bundle resource"}
    remote isolated function previousBundle(@display {label: "Current Bundle"} FHIRResponse|json|xml currentBundle)
                                        returns FHIRResponse|FHIRError? {
        do {
            // If the urlRewrite is enabled, replacementURL is of type string, we can cast it safely here.
            string? prevUrl = check extractPrevPageUrl(currentBundle, self.urlRewrite ? <string>self.replacementURL : self.baseUrl);
            if prevUrl is () {
                return ();
            }
            map<string> headerMap = {[ACCEPT_HEADER] : self.mimeType};
            http:Response response = check self.httpClient->get(prevUrl, check enrichHeaders(headerMap, self.pkjwtHanlder));
            FHIRResponse result = check getBundleResponse(response);
            if self.urlRewrite {
                return rewriteServerUrl(result, self.baseUrl, replacementUrl = self.replacementURL);
            }
            return result;
        } on fail error e {
            if e is FHIRError {
                return e;
            }
            return error(string `${FHIR_CONNECTOR_ERROR}: ${e.message()}`, errorDetails = e);
        }
    }

    # Submits a FHIR bulk data export kickoff request
    #
    # + bulkExportLevel - Bulk export level
    # + groupId - Group ID of the resource group to be exported. Required only if Group export level is selected
    # + bulkExportParameters - Bulk export parameters
    # + return - If successful, FhirResponse record else FhirError record
    @display {label: "Start bulk data export process"}
    remote isolated function bulkExport(@display {label: "Bulk export level"} BulkExportLevel bulkExportLevel,
            @display {label: "Group ID to be exported"} string? groupId = (),
            @display {label: "Bulk export parameters"} BulkExportParameters? bulkExportParameters = ())
                                        returns FHIRResponse|FHIRError {
        do {
            string requestUrl = SLASH;
            if bulkExportLevel == EXPORT_SYSTEM {
                requestUrl += EXPORT;
            } else if bulkExportLevel == EXPORT_PATIENT {
                requestUrl += string `${PATIENT}${SLASH}${EXPORT}`;
            } else if bulkExportLevel == EXPORT_GROUP && groupId != () {
                requestUrl += string `${GROUP}${SLASH}${groupId}${SLASH}${EXPORT}`;
            } else {
                return error FHIRConnectorError(string `${FHIR_CONNECTOR_ERROR}: ${GROUP_ID_NOT_PROVIDED}`);
            }
            requestUrl +=
                bulkExportParameters != ()
                ? QUESTION_MARK + check setBulkExportParams(bulkExportParameters)
                : "";

            map<string> headerMap = {
                [ACCEPT_HEADER] : FHIR_JSON,
                [PREFER_HEADER] : "respond-async"
            };
            http:Response response = check self.httpClient->get(requestUrl, check enrichHeaders(headerMap, self.pkjwtHanlder));
            FHIRResponse result = check getBulkExportResponse(response);
            if self.urlRewrite {
                return rewriteServerUrl(result, self.baseUrl, self.fileServerUrl, self.replacementURL);
            }
            return result;
        } on fail error e {
            if e is FHIRError {
                return e;
            }
            return error(string `${FHIR_CONNECTOR_ERROR}: ${e.message()}`, errorDetails = e);
        }
    }

    # Checks the progress of the bulk data export. Returns the exported file locations if the export status is complete
    #
    # + contentLocation - Bulk status polling url. Found in the response header of the kickoff request
    # + return - If successful, FhirResponse record else FhirError record
    @display {label: "Check bulk data export progress"}
    remote isolated function bulkStatus(@display {label: "Bulk status polling url"} string contentLocation)
                                        returns FHIRResponse|FHIRError {
        do {
            // If the urlRewrite is enabled, replacementURL is of type string, we can cast it safely here.
            string requestUrl = self.urlRewrite
                ? extractPath(contentLocation, <string>self.replacementURL)
                : extractPath(contentLocation, self.baseUrl);
            map<string> headerMap = {};
            http:Response response = check self.httpClient->get(requestUrl, check enrichHeaders(headerMap, self.pkjwtHanlder));
            FHIRResponse result = check getBulkExportResponse(response);
            if self.urlRewrite {
                return rewriteServerUrl(result, self.baseUrl, self.fileServerUrl, self.replacementURL);
            }
            return result;
        } on fail error e {
            if e is FHIRError {
                return e;
            }
            return error(string `${FHIR_CONNECTOR_ERROR}: ${e.message()}`, errorDetails = e);
        }
    }

    # Request to delete exported files on the server. Cancels the bulk export process if it is not completed.
    #
    # + contentLocation - Bulk status polling url. Found in the response header of the kickoff request
    # + return - If successful, FhirResponse record else FhirError record
    @display {label: "Check bulk data export progress"}
    remote isolated function bulkDataDelete(@display {label: "Bulk status polling url"} string contentLocation)
                                        returns FHIRResponse|FHIRError {
        do {
            // If the urlRewrite is enabled, replacementURL is of type string, we can cast it safely here.
            string requestUrl = self.urlRewrite
                ? extractPath(contentLocation, <string>self.replacementURL)
                : extractPath(contentLocation, self.baseUrl);
            map<string> headerMap = {};
            http:Response response = check self.httpClient->delete(requestUrl, check enrichHeaders(headerMap, self.pkjwtHanlder));
            FHIRResponse result = check getBulkExportResponse(response);
            if self.urlRewrite {
                return rewriteServerUrl(result, self.baseUrl, self.fileServerUrl, self.replacementURL);
            }
            return result;
        } on fail error e {
            if e is FHIRError {
                return e;
            }
            return error(string `${FHIR_CONNECTOR_ERROR}: ${e.message()}`, errorDetails = e);
        }
    }

    # Request to get the exported bulk file
    #
    # + fileUrl - Bulk file url. Found in the response body of the bulk status request
    # + additionalHeaders - Additional headers sent with the request
    # + return - If successful, FhirBulkFileResponse record else FhirError record
    @display {label: "Get exported file as a byte[] stream"}
    remote isolated function bulkFile(@display {label: "Exported file url"} string fileUrl,
            @display {label: "Additional headers sent with the request"} map<string>? additionalHeaders = ())
                                        returns FHIRBulkFileResponse|FHIRError {
        do {
            // If the urlRewrite is enabled, replacementURL is of type string, we can cast it safely here.
            string requestUrl = self.urlRewrite
                ? extractPath(fileUrl, <string>self.replacementURL)
                : extractPath(fileUrl, self.fileServerUrl ?: self.baseUrl);
            map<string> otherHeaders = additionalHeaders ?: {};
            map<string> headerMap = {[ACCEPT_HEADER] : FHIR_ND_JSON, ...otherHeaders};
            http:Response response = check self.bulkFileHttpClient->get(requestUrl, headerMap);
            return getBulkFileResponse(response);
        } on fail error e {
            if e is FHIRError {
                return e;
            }
            return error(string `${FHIR_CONNECTOR_ERROR}: ${e.message()}`, errorDetails = e);
        }
    }

    # Invokes a custom FHIR operation (e.g., $lookup, $everything) on a resource type.
    #
    # This function allows invoking FHIR operations that are not covered by standard CRUD methods, such as `$lookup`, `$everything`, or any other custom operation defined by the FHIR server.
    #
    # + 'type - The name of the resource type on which the operation is invoked
    # + operationName - The name of the FHIR operation (e.g., "$lookup", "$everything")
    # + mode - The request mode, GET or POST
    # + id - The logical id of the resource (optional, used for instance-level operations)
    # + queryParameters - Query parameters to be sent with the operation
    # + data - Resource data to be sent in the request body (for POST operations)
    # + returnMimeType - The MIME type of the response
    # + return - If successful, FhirResponse record else FhirError record
    @display {label: "Call custom FHIR operation"}
    remote isolated function callOperation(@display {label: "Resource Type"} ResourceType|string 'type,
            @display {label: "Operation Name"} string operationName,
            @display {label: "Request Mode"} RequestMode mode = GET,
            @display {label: "Logical ID"} string? id = (),
            @display {label: "Query Parameters"} map<string[]>? queryParameters = (),
            @display {label: "Resource data"} json|xml? data = (),
            @display {label: "Return MIME Type"} MimeType? returnMimeType = ())
                                    returns FHIRResponse|FHIRError {
        string requestUrl = SLASH + 'type + setOperationName(operationName, id) + setCallOperationParams(queryParameters, returnMimeType);
        map<string> headerMap = {[ACCEPT_HEADER] : self.mimeType};
        do {
            http:Response response;
            
            if mode == GET {
                response = check self.httpClient->get(requestUrl, check enrichHeaders(headerMap, self.pkjwtHanlder));
            } else {
                http:Request req = new;
                req.setPayload(data, contentType = data is xml ? FHIR_XML : FHIR_JSON);

                response = check self.httpClient->post(requestUrl, req, check enrichHeaders(headerMap, self.pkjwtHanlder));
            }
            
            FHIRResponse result = check getBundleResponse(response);
            if self.urlRewrite {
                return rewriteServerUrl(result, self.baseUrl, replacementUrl = self.replacementURL);
            }
            return result;
        } on fail error e {
            if e is FHIRError {
                return e;
            }
            return error(string `${FHIR_CONNECTOR_ERROR}: ${e.message()}`, errorDetails = e);
        }
    }
}

isolated function enrichHeaders(map<string> headers, auth:PKJWTAuthHandler? handler) returns map<string>|FHIRError {
    if handler is () {
        return headers;
    }
    map<string>|error enrichedHeader = handler.enrichHeaders(headers);
    if enrichedHeader is error {
        return error(string `${FHIR_CONNECTOR_ERROR}: ${enrichedHeader.message()}`, errorDetails = enrichedHeader);
    }
    return enrichedHeader;
}

isolated function enrichRequest(http:Request req, auth:PKJWTAuthHandler? handler) returns http:Request|FHIRError {
    if handler is () {
        return req;
    }
    http:Request|error enrichedReq = handler->enrich(req);
    if enrichedReq is error {
        return error(string `${FHIR_CONNECTOR_ERROR}: ${enrichedReq.message()}`, errorDetails = enrichedReq);
    }
    return enrichedReq;
}
