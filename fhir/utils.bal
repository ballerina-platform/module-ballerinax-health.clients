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
import ballerina/url;

isolated function setFormatNSummaryParameters(MimeType? mimeType, SummaryType? summary) returns string {
    string paramString = "";
    if mimeType is MimeType {
        paramString += string `${QUESTION_MARK}${_FORMAT}${EQUALS_SIGN}${mimeType}`;
    }
    if summary is SummaryType {
        paramString += string `${QUESTION_MARK}${AMPERSAND}${_SUMMARY}${EQUALS_SIGN}${summary}`;
    }
    return paramString;
}

isolated function setFormatParameters(MimeType? mimeType) returns string =>
    mimeType is () ? "" : string `${_FORMAT}${EQUALS_SIGN}${mimeType}`;

isolated function extractHeadersFromResponse(http:Response response) returns map<string> {
    map<string> headerMap = {};
    string[] headers = response.getHeaderNames();

    foreach string header in headers {
        var headerValue = response.getHeader(header);
        if headerValue is string {
            headerMap[header] = headerValue;
        }
    }
    return headerMap;
}

isolated function getHeaderValueFromRequest(http:Request request, string headerName) returns string {
    var value = request.getHeader(headerName);
    if (value is string) {
        return value;
    } else {
        return "";
    }
}

isolated function extractContentTypeFromResponse(http:Response response) returns string {
    string contentType = response.getContentType();
    string[] split = re `;`.split(contentType);
    return split[0];
}

isolated function extractResponseBody(http:Response response) returns xml|json|error {
    string contentType = extractContentTypeFromResponse(response);
    json|xml responseBody = "";

    if contentType == FHIR_JSON {
        responseBody = check response.getJsonPayload();
    } else if contentType == FHIR_XML {
        responseBody = check response.getXmlPayload();

    }
    return responseBody;
}

isolated function getFhirResourceResponse(http:Response response) returns FHIRResponse|FHIRError {
    do {
        xml|json responseBody = check extractResponseBody(response);
        map<string> responseHeaders = extractHeadersFromResponse(response);
        int statusCode = response.statusCode;
        if statusCode == STATUS_CODE_OK {
            return {httpStatusCode: statusCode, 'resource: responseBody, serverResponseHeaders: responseHeaders};
        } else {
            return error(FHIR_SERVER_ERROR, httpStatusCode = statusCode, 'resource = responseBody, serverResponseHeaders = responseHeaders);
        }
    } on fail var e {
        return error(string `${FHIR_CONNECTOR_ERROR}: ${e.message()}`, errorDetails = e);
    }

}

isolated function extractXmlNamespaceNRoot(string element) returns XmlNameSpaceNRoot {
    XmlNameSpaceNRoot data = {namespace: (), rootName: ()};
    string[] split = re `\}`.split(element);
    if split.length() == 1 {
        data.rootName = split[0];
    } else {
        data.rootName = split[1];
        string namespace = split[0];
        if namespace.startsWith("{") {
            data.namespace = namespace.substring(1);
        }
    }
    return data;
}

isolated function setCreateUpdatePatchResourceRequest(MimeType mimeType, PreferenceType preference, json|xml data) returns http:Request {
    http:Request request = new ();
    request.setHeader(ACCEPT_HEADER, mimeType);
    string preferHeader = "return=" + preference;
    request.setHeader(PREFER_HEADER, preferHeader);
    request.setPayload(data);
    string contentType = data is json ? FHIR_JSON : FHIR_XML;
    request.setHeader(CONTENT_TYPE, contentType);
    return request;
}

isolated function setPatchResourceRequest(MimeType mimeType, PreferenceType preference, json|xml data, MimeType|PatchContentType? patchContentType) returns http:Request {
    http:Request request = new ();
    request.setHeader(ACCEPT_HEADER, mimeType);
    string preferHeader = "return=" + preference;
    request.setHeader(PREFER_HEADER, preferHeader);
    request.setPayload(data);
    string contentType = patchContentType != null ? patchContentType : (data is json ? PATCH_JSON : PATCH_XML);
    request.setHeader(CONTENT_TYPE, contentType);
    return request;
}

isolated function extractResourceIdNVid(string url) returns ResourceLocationDetails {
    string[] splitUrl = re `/`.split(url).reverse();
    return <ResourceLocationDetails>{
        resourceId: splitUrl[2],
        'version: splitUrl[0]
    };
}

isolated function getAlteredResourceResponse(http:Response response, PreferenceType preference) returns FHIRResponse|FHIRError {
    do {
        xml|json responseBody = "";

        int statusCode = response.statusCode;
        map<string> responseHeaders = extractHeadersFromResponse(response);

        if statusCode == STATUS_CODE_OK || statusCode == STATUS_CODE_CREATED {
            if preference == MINIMAL {
                string header = check response.getHeader(LOCATION);
                responseBody = extractResourceIdNVid(header);
            } else {
                responseBody = check extractResponseBody(response);
            }
            FHIRResponse fhirResponse = {httpStatusCode: statusCode, 'resource: responseBody, serverResponseHeaders: responseHeaders};
            return fhirResponse;
        } else {
            responseBody = check extractResponseBody(response);
            FHIRServerError fhirServerError = error(FHIR_SERVER_ERROR, httpStatusCode = statusCode, 'resource = responseBody, serverResponseHeaders = responseHeaders);
            return fhirServerError;
        }
    } on fail var e {
        return error(string `${FHIR_CONNECTOR_ERROR}: ${e.message()}`, errorDetails = e);
    }
}

isolated function getDeleteResourceResponse(http:Response response) returns FHIRResponse|FHIRError {
    do {
        int statusCode = response.statusCode;
        xml|json responseBody = "";
        map<string> responseHeaders = extractHeadersFromResponse(response);

        if statusCode == STATUS_CODE_OK {
            responseBody = check extractResponseBody(response);
            FHIRResponse fhirResponse = {httpStatusCode: statusCode, 'resource: responseBody, serverResponseHeaders: responseHeaders};
            return fhirResponse;
        } else if statusCode == STATUS_CODE_NO_CONTENT || statusCode == STATUS_CODE_ACCEPTED {
            FHIRResponse fhirResponse = {httpStatusCode: statusCode, 'resource: responseBody, serverResponseHeaders: responseHeaders};
            return fhirResponse;
        } else {
            responseBody = check extractResponseBody(response);
            FHIRServerError fhirServerError = error(FHIR_SERVER_ERROR, httpStatusCode = statusCode, 'resource = responseBody, serverResponseHeaders = responseHeaders);
            return fhirServerError;
        }
    } on fail var e {
        return error(string `${FHIR_CONNECTOR_ERROR}: ${e.message()}`, errorDetails = e);
    }
}

isolated function formUrlFromMap(map<anydata> data) returns string {
    string url = "";
    string[] keys = data.keys();
    foreach string key in keys {
        url += key + EQUALS_SIGN + data.get(key).toString() + AMPERSAND;
    }
    return url;
}

isolated function setHistoryParams(HistorySearchParameters params, MimeType? returnMimeType) returns string =>
    string `${QUESTION_MARK}${formUrlFromMap(params)}${setFormatParameters(returnMimeType)}`;

isolated function getBundleResponse(http:Response response) returns FHIRResponse|FHIRError {
    do {
        int statusCode = response.statusCode;
        json|xml responseBody = check extractResponseBody(response);
        map<string> responseHeaders = extractHeadersFromResponse(response);

        if statusCode == STATUS_CODE_OK {
            FHIRResponse fhirResponse = {httpStatusCode: statusCode, 'resource: responseBody, serverResponseHeaders: responseHeaders};
            return fhirResponse;
        } else {
            FHIRServerError fhirServerError = error(FHIR_SERVER_ERROR, httpStatusCode = statusCode, 'resource = responseBody, serverResponseHeaders = responseHeaders);
            return fhirServerError;
        }
    } on fail var e {
        return error(string `${FHIR_CONNECTOR_ERROR}: ${e.message()}`, errorDetails = e);
    }
}

isolated function setSearchParams(SearchParameters|map<string[]>? qparams, MimeType? returnMimeType) returns string {
    string url = "";
    if (qparams is SearchParameters) {
        foreach string key in qparams.keys() {
            if (qparams.get(key) is string[]) {
                string[] params = <string[]>qparams.get(key);
                foreach string param in params {
                    url += key + EQUALS_SIGN + param + AMPERSAND;
                }
            } else {
                string val = <string>qparams.get(key);
                url += key + EQUALS_SIGN + val + AMPERSAND;
            }
        }
    }
    if (qparams is map<string[]>) {
        foreach string key in qparams.keys() {
            foreach string param in qparams.get(key) {
                url += key + EQUALS_SIGN + param + AMPERSAND;
            }
        }
    }
    url += setFormatParameters(returnMimeType);
    return url.endsWith("&") ? url.substring(0, url.length() - 1) : url;
}

isolated function setCapabilityParams(map<anydata>? params, MimeType? returnMimeType) returns string {
    string url = AMPERSAND;
    if params is map<anydata> {
        url += formUrlFromMap(params);
    }
    url += setFormatParameters(returnMimeType);
    if url == AMPERSAND {
        url = "";
    }
    return url;
}

isolated function setBundleRequest(xml|json data, MimeType mimeType) returns http:Request {
    http:Request request = new ();
    request.setHeader(ACCEPT_HEADER, mimeType);
    request.setPayload(data);
    return request;
}

isolated function setPaginationUrls(string relation, string url, Pagination paginationData) returns Pagination {
    if relation == NEXT {
        paginationData.next = url;
    } else if relation == PREVIOUS || relation == PREV {
        paginationData.previous = url;
    } else if relation == SELF {
        paginationData.self = url;
    }
    return paginationData;
}

isolated function extractPageUrlsFromJson(json bundle) returns Pagination|error {
    json links = check bundle.link;
    json[] linksList = check links.ensureType();
    Pagination pagination = {};
    foreach json item in linksList {
        json relation = check item.relation;
        json url = check item.url;
        pagination = setPaginationUrls(relation.toString(), url.toString(), pagination);
    }
    return pagination;
}

isolated function extractPageUrlsFromXml(xml bundle) returns Pagination|error {

    xml:Element rootElement = <xml:Element>bundle;
    XmlNameSpaceNRoot xmlValues = extractXmlNamespaceNRoot(rootElement.getName());
    string? namespace = xmlValues.namespace;
    string linkName = namespace is string ? string `{${namespace}}${XML_LINK}` : XML_LINK;
    xml<xml:Element> linkList = rootElement.elementChildren(linkName);
    string relationName = namespace is string ? string `{${namespace}}${XML_RELATION}` : XML_RELATION;
    string urlName = namespace is string ? string `{${namespace}}${XML_URL}` : XML_URL;
    Pagination pagination = {};
    foreach xml:Element item in linkList {
        string relation = check item.elementChildren(relationName).value;
        string url = check item.elementChildren(urlName).value;
        pagination = setPaginationUrls(relation, url, pagination);
    }
    return pagination;
}

isolated function extractNextPageUrl(FHIRResponse|json|xml data, string baseUrl) returns string|error? {
    json|xml bundle = data is FHIRResponse ? data.'resource : <json|xml>data;
    Pagination paginationResult;
    if bundle is json {
        paginationResult = check extractPageUrlsFromJson(bundle);
    } else {
        paginationResult = check extractPageUrlsFromXml(bundle);
    }
    string? fullUrl = paginationResult.next;
    if fullUrl is string {
        return fullUrl.trim().substring(baseUrl.length());
    }
    return ();
}

isolated function extractPrevPageUrl(FHIRResponse|json|xml data, string baseUrl) returns string|error? {
    json|xml bundle = data is FHIRResponse ? data.'resource : <json|xml>data;
    Pagination paginationResult;
    if bundle is json {
        paginationResult = check extractPageUrlsFromJson(bundle);
    } else {
        paginationResult = check extractPageUrlsFromXml(bundle);
    }
    string? fullUrl = paginationResult.previous;
    if fullUrl is string {
        return fullUrl.trim().substring(baseUrl.length());
    }
    return ();
}

isolated function extractResourceTypeNId(json|xml data, boolean extractId = true) returns ResourceTypeNId|error {
    string? rType = ();
    string? rId = ();
    if data is json {
        json|error typeValue = data.resourceType;
        if typeValue is json {
            rType = typeValue.toString();
        } else {
            return error(ERROR_WHEN_RETRIEVING_RESOURCE_TYPE);
        }
        json|error idValue = data.id;
        if idValue is json {
            rId = idValue.toString();
        } else {
            if (extractId) {
                return error(ERROR_WHEN_RETRIEVING_RESOURCE_ID);
            }
        }
    } else {
        xml:Element rootElement = <xml:Element>data;
        XmlNameSpaceNRoot xmlValues = extractXmlNamespaceNRoot(rootElement.getName());
        rType = xmlValues.rootName ?: "";
        string? namespace = xmlValues.namespace;
        string|error idValue;
        if namespace is string {
            idValue = data.elementChildren(string `{${namespace}}${XML_ID}`).value;
        } else {
            idValue = data.elementChildren(XML_ID).value;
        }

        if idValue is string {
            rId = idValue.toString();
        }
    }
    if rType == () {
        return error(RESOURCE_TYPE_NOT_FOUND_IN_DATA);
    }
    if rId == () && extractId {
        return error(RESOURCE_ID_NOT_FOUND_IN_DATA);
    }
    ResourceTypeNId extractedData = {id: rId, 'type: rType};
    return extractedData;
}

isolated function validateBundleData(json|xml data, BundleType bundleType) returns boolean|error {
    json|error typeValue;
    if data is json {
        typeValue = data.'type;
    } else {
        xml:Element rootElement = <xml:Element>data;
        XmlNameSpaceNRoot xmlValues = extractXmlNamespaceNRoot(rootElement.getName());
        string? namespace = xmlValues.namespace;
        if namespace is string {
            typeValue = data.elementChildren(string `{${namespace}}${XML_TYPE}`).value;
        } else {
            typeValue = data.elementChildren(XML_TYPE).value;
        }
    }
    return typeValue is string ? typeValue == bundleType : error(BUNDLE_MISSING_TYPE);
}

isolated function getOperationOutcome(string detail) returns json {
    return {
        "resourceType": "OperationOutcome",
        "issue": [
            {
                "severity": "error",
                "code": "processing",
                "details": {
                    "text": detail
                }
            }
        ]
    };
}

# Extracts the resource type from the given payload.
#
# + data - FHIR payload  
# + extractId - Whether to extract the resource id or not
# + return - The resource type or an error if the resource type is not found
public isolated function extractResourceType(json|xml data, boolean extractId = true) returns string|error {
    string? rType = ();
    if data is json {
        json|error typeValue = data.resourceType;
        if typeValue is json {
            rType = typeValue.toString();
        } else {
            return error(ERROR_WHEN_RETRIEVING_RESOURCE_TYPE);
        }
    } else {
        xml:Element rootElement = <xml:Element>data;
        XmlNameSpaceNRoot xmlValues = extractXmlNamespaceNRoot(rootElement.getName());
        rType = xmlValues.rootName ?: "";
    }
    if rType == () {
        return error(MISSING_RES_TYPE);
    }
    return rType;
}

# Creates an HTTP response with an operation outcome error.
#
# + msg - Error message to populate the operation outcome  
# + statusCode - HTTP status code to be set in the response
# + return - The HTTP response with the operation outcome error
public isolated function handleError(string msg, int statusCode = http:STATUS_INTERNAL_SERVER_ERROR) returns http:Response {
    http:Response finalResponse = new ();
    finalResponse.setPayload(getOperationOutcome(msg), FHIR_JSON);
    finalResponse.statusCode = statusCode;
    return finalResponse;
}

# Creates an HTTP response from the given FHIRResponse.
#
# + fhirResponse - FHIR response to be converted to HTTP response
# + return - The HTTP response
public isolated function handleResponse(FHIRResponse|FHIRError fhirResponse) returns http:Response {
    http:Response finalResponse = new ();
    string contentType = FHIR_JSON;
    if fhirResponse is FHIRResponse {
        finalResponse.statusCode = fhirResponse.httpStatusCode;
        finalResponse.setPayload(fhirResponse.'resource);
        if fhirResponse.serverResponseHeaders.hasKey(http:CONTENT_TYPE) {
            contentType = fhirResponse.serverResponseHeaders.get(http:CONTENT_TYPE);
        }
        error? contentTypeResult = finalResponse.setContentType(contentType);
        if contentTypeResult is error {
            finalResponse.setPayload(getOperationOutcome(PAYLOAD_CONSTRUCTION_ERROR));
            finalResponse.statusCode = http:STATUS_INTERNAL_SERVER_ERROR;
        }
    } else {
        if fhirResponse is FHIRServerError {
            finalResponse.statusCode = fhirResponse.detail().httpStatusCode;
            if fhirResponse.detail().serverResponseHeaders.hasKey(http:CONTENT_TYPE) {
                contentType = fhirResponse.detail().serverResponseHeaders.get(http:CONTENT_TYPE);
            }
            error? contentTypeResult = finalResponse.setContentType(contentType);
            if contentTypeResult is error {
                finalResponse.setPayload(getOperationOutcome(PAYLOAD_CONSTRUCTION_ERROR));
                finalResponse.statusCode = http:STATUS_INTERNAL_SERVER_ERROR;
            }
            finalResponse.setPayload(fhirResponse.detail().'resource);
        } else {
            finalResponse.setPayload(getOperationOutcome(fhirResponse.detail().toString()));
            finalResponse.statusCode = http:STATUS_INTERNAL_SERVER_ERROR;
        }
    }
    return finalResponse;
}

// Create url query param string with bulk export parameters.
// For arrays, query param is formed by url encoding the elements and joining them with comma as defined in the specification.
isolated function setBulkExportParams(BulkExportParameters params) returns string|error {
    string paramString = "";

    foreach string key in params.keys() {
        anydata value = params.get(key);
        if value is anydata[] {
            string[] urlEncodedArr = from anydata item in value
                select check url:encode(item.toString(), "UTF-8");

            string joinedParamValue =
                urlEncodedArr
                    .reduce(
                        isolated function(string concat, string next) returns string =>
                            string `${concat}${next}${COMMA}`,
                        initial = ""
                    );
            joinedParamValue = joinedParamValue.substring(0, joinedParamValue.length() - 1);
            paramString += string `${key}${EQUALS_SIGN}${joinedParamValue}${AMPERSAND}`;
        } else {
            string encodedValue = check url:encode(value.toString(), "UTF-8");
            paramString += string `${key}${EQUALS_SIGN}${encodedValue}${AMPERSAND}`;
        }
    }
    return paramString.endsWith(AMPERSAND)
        ? paramString.substring(0, paramString.length() - 1)
        : paramString;
}

isolated function getBulkExportResponse(http:Response response) returns FHIRResponse|FHIRError {
    int statusCode = response.statusCode;
    json|error tempResponseBody = response.getJsonPayload();
    json responseBody;
    if tempResponseBody is http:NoContentError {
        responseBody = ();
    } else if tempResponseBody is json {
        responseBody = tempResponseBody;
    } else {
        return error FHIRConnectorError(string `${FHIR_CONNECTOR_ERROR}: ${tempResponseBody.message()}`, errorDetails = tempResponseBody);
    }
    map<string> responseHeaders = extractHeadersFromResponse(response);
    if statusCode == http:STATUS_OK || statusCode == http:STATUS_ACCEPTED {
        return {
            httpStatusCode: statusCode,
            'resource: responseBody,
            serverResponseHeaders: responseHeaders
        };
    }
    return error FHIRServerError(
        FHIR_SERVER_ERROR,
        httpStatusCode = statusCode,
        'resource = responseBody,
        serverResponseHeaders = responseHeaders
    );
}

isolated function getBulkFileResponse(http:Response response) returns FHIRBulkFileResponse|FHIRError {
    do {
        int statusCode = response.statusCode;
        map<string> responseHeaders = extractHeadersFromResponse(response);

        if statusCode == http:STATUS_OK {
            return {
                httpStatusCode: statusCode,
                serverResponseHeaders: responseHeaders,
                dataStream: check response.getByteStream()
            };
        } else {
            return error FHIRServerError(
                FHIR_SERVER_ERROR,
                httpStatusCode = statusCode,
                'resource = check extractResponseBody(response),
                serverResponseHeaders = responseHeaders
            );
        }
    } on fail var e {
        return error(string `${FHIR_CONNECTOR_ERROR}: ${e.message()}`, errorDetails = e);
    }
}

isolated function extractPath(string fullUrl, string baseUrl) returns string => fullUrl.substring(baseUrl.length());

// Replaces FHIR server base url in the FHIR resource with the given url.
isolated function rewriteServerUrl(FHIRResponse response, string baseUrl, string? fileServerBaseUrl = (), string? replacementUrl = ()) returns FHIRResponse|FHIRConnectorError {
    json|xml data = response.'resource;

    FHIRResponse returnResponse = response.clone();
    do {
        var rewrite = isolated function(string inputString) returns string {
            string rewrittenString = re `${baseUrl}`.replaceAll(inputString, <string>replacementUrl);
            if fileServerBaseUrl is () {
                return rewrittenString;
            }
            return re `${<string>fileServerBaseUrl}`.replaceAll(rewrittenString, <string>fileServerBaseUrl);
        };

        if data is xml {
            string xmlString = data.toString();
            string rewrittenString = rewrite(xmlString);
            xml resultXml = check xml:fromString(rewrittenString);
            returnResponse.'resource = resultXml;
        } else {
            string jsonString = data.toJsonString();
            string rewrittenString = rewrite(jsonString);
            json resultJson = check rewrittenString.fromJsonString();
            returnResponse.'resource = resultJson;
        }

        returnResponse.serverResponseHeaders = response.serverResponseHeaders.'map(rewrite);
        return returnResponse;
    } on fail var e {
        return error(string `${FHIR_CONNECTOR_ERROR}: ${e.message()}`, errorDetails = e);
    }
}

isolated function constructHttpConfigs(FHIRConnectorConfig|BulkFileServerConfig config) returns http:ClientConfiguration {
    http:ClientConfiguration httpConfig = {
        httpVersion: config.httpVersion,
        http1Settings: config.http1Settings.cloneReadOnly(),
        http2Settings: config.http2Settings,
        timeout: config.timeout,
        forwarded: config.forwarded,
        poolConfig: config.poolConfig,
        cache: config.cache,
        compression: config.compression,
        circuitBreaker: config.circuitBreaker,
        retryConfig: config.retryConfig,
        responseLimits: config.responseLimits,
        proxy: config.proxy,
        validation: config.validation,
        socketConfig: config.socketConfig,
        secureSocket: config.secureSocket,
        auth: config is FHIRConnectorConfig 
                    ? (config.authConfig is http:ClientAuthConfig ? <http:ClientAuthConfig?>config.authConfig : ()) 
                    : config.auth
    };
    return httpConfig;
}
