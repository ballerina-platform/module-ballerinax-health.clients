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

# FHIR accepted MIME types
public enum MimeType {
    FHIR_JSON = "application/fhir+json",
    FHIR_XML = "application/fhir+xml"
}

# Types of resources 
public enum ResourceType {
    PATIENT = "Patient",
    PRACTITIONER = "Practitioner",
    GROUP = "Group"
}

# Specifies the subset of the resource to be returned
public enum SummaryType {
    TRUE = "true",
    FALSE = "false",
    TEXT = "text",
    DATA = "data",
    COUNT = "count"
}

# Specifies the content that should return when performing create,update or patch 
public enum PreferenceType {
    MINIMAL = "minimal",
    REPRESENTATION = "representation",
    OPERATION_OUTCOME = "OperationOutcome"
}

# Specifies the information that should return in the capability statement
public enum ModeType {
    FULL = "full",
    NORMATIVE = "normative",
    TERMINOLOGY = "terminology"
}

# Types of a FHIR bundle
public enum BundleType {
    BATCH = "batch",
    TRANSACTION = "transaction"
}

# FHIR accepted PATCH content types
public enum PatchContentType {
    PATCH_JSON = "application/json-patch+json",
    PATCH_XML = "application/xml-patch+xml"
}

public enum BulkExportOutputType {
    FHIR_ND_JSON = "application/fhir+ndjson"
}

public enum BulkExportLevel {
    EXPORT_PATIENT = "Patient",
    EXPORT_SYSTEM = "System",
    EXPORT_GROUP = "Group"
}

public enum RequestMode {
    GET = "GET",
    POST = "POST"
}

# Constant symbols
const AMPERSAND = "&";
const SLASH = "/";
const QUOTATION_MARK = "\"";
const QUESTION_MARK = "?";
const EQUALS_SIGN = "=";
const COMMA = ",";

# FHIR  parameters 
const _FORMAT = "_format";
const _SUMMARY = "_summary";
const _HISTORY = "_history";
const METADATA = "metadata";
const MODE = "mode";

# Resource paths
const _SEARCH = "_search";

# Bulk export
const EXPORT = "$export";

# x-www-form-urlencoded content type
const APPLICATION_X_WWW_FORM_URLENCODED = "application/x-www-form-urlencoded";

# Server Status codes
const STATUS_CODE_OK = 200;
const STATUS_CODE_CREATED = 201;
const STATUS_CODE_NO_CONTENT = 204;
const STATUS_CODE_ACCEPTED = 202;

# Request Headers
const ACCEPT_HEADER = "Accept";
const PREFER_HEADER = "Prefer";
const LOCATION = "Location";
const CONTENT_TYPE = "Content-Type";
const CONTENT_LOCATION = "Content-Location";

# Error messages 
const RESOURCE_ID_NOT_FOUND_IN_DATA = "The provided resource data doesn't contain a id value";
const RESOURCE_TYPE_NOT_FOUND_IN_DATA = "The provided resource data doesn't contain a resource type value";
const ERROR_WHEN_RETRIEVING_RESOURCE_TYPE = "Error occurred when retrieving resource type from the FHIR payload";
const ERROR_WHEN_RETRIEVING_RESOURCE_ID = "Error occurred when retrieving resource ID from the FHIR payload";
const FHIR_SERVER_ERROR = "FHIR server side error";
const FHIR_CONNECTOR_ERROR = "FHIR connector side error";
const BUNDLE_TYPE_ERROR = "Provided bundle type is incompatible with the method, expected bundle type: ";
const BUNDLE_MISSING_TYPE = "Provided bundle doesn't contain the attribute 'type'";
const PAYLOAD_CONSTRUCTION_ERROR = "Error occurred when constructing the response payload";
const MISSING_RES_TYPE = "Resource type not found";
const REPLACEMENT_URL_NOT_PROVIDED = "URL rewrite is set to true, but replacement URL is not provided";
const GROUP_ID_NOT_PROVIDED = "The parameter 'groupId' is not provided for Group Bulk Export operation";
const INTERNATIONAL_401_NOT_SUPPORTED = "International401 parameters are not supported for GET requests";

# XML attributes
const XML_ID = "id";
const XML_TYPE = "type";
const XML_LINK = "link";
const XML_RELATION = "relation";
const XML_URL = "url";

# pagination
const NEXT = "next";
const PREVIOUS = "previous";
const PREV = "prev";
const SELF = "self";

