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
import ballerina/io;
import ballerinax/health.base.auth;

# Represents FHIR client connector configurations
#
# + baseURL - FHIR server base URL  
# + mimeType - global MIME type of the return response, can be configured at method level as well  
# + authConfig - Authentication configs that will be used to create the http client  
# + urlRewrite - Whether to rewrite FHIR server URL, can be configured at method level as well  
# + replacementURL - Base url of the service to rewrite FHIR server URLs  
# + bulkFileServerConfig - Bulk export file server configs  
# + httpVersion - The HTTP version understood by the client  
# + http1Settings - Configurations related to HTTP/1.x protocol
# + http2Settings - Configurations related to HTTP/2 protocol  
# + timeout - The maximum time to wait (in seconds) for a response before closing the connection  
# + forwarded - The choice of setting `forwarded`/`x-forwarded` header  
# + poolConfig - Configurations associated with request pooling  
# + cache - HTTP caching related configurations  
# + compression - Specifies the way of handling compression (`accept-encoding`) header  
# + circuitBreaker - Configurations associated with the behaviour of the Circuit Breaker  
# + retryConfig - Configurations associated with retrying  
# + responseLimits - Configurations associated with inbound response size limits  
# + proxy - Proxy server related options  
# + validation - Enables the inbound payload validation functionalty which provided by the constraint package. Enabled by default  
# + socketConfig - Provides settings related to client socket configuration  
# + secureSocket - Provides settings related to SSL/TLS
public type FHIRConnectorConfig record {|
    @display {label: "FHIR server base url"}
    string baseURL;
    @display {label: "MIME type of the return response"}
    MimeType mimeType = FHIR_JSON;
    @display {label: "Authentication configs of the FHIR server"}
    (http:ClientAuthConfig|auth:PKJWTAuthConfig) authConfig?;
    @display {label: "Rewrite FHIR server URL"}
    boolean urlRewrite = false;
    @display {label: "Base url of the service to rewrite FHIR server URLs"}
    string replacementURL?;
    @display {label: "Bulk export file server configs"}
    BulkFileServerConfig bulkFileServerConfig?;
    @display {label:"The HTTP version understood by the client"}
    http:HttpVersion httpVersion = http:HTTP_2_0;
    @display {label:"Configurations related to HTTP/1.x protocol"}
    http:ClientHttp1Settings http1Settings = {};
    @display {label:"Configurations related to HTTP/2 protocol"}
    http:ClientHttp2Settings http2Settings = {};
    @display {label:"The maximum time to wait (in seconds) for a response before closing the connection"}
    decimal timeout = 30;
    @display {label:"The choice of setting `forwarded`/`x-forwarded` header"}
    string forwarded = "disable";
    @display {label:"Configurations associated with request pooling"}
    http:PoolConfiguration? poolConfig = ();
    @display {label:"HTTP caching related configurations"}
    http:CacheConfig cache = {};
    @display {label:"Specifies the way of handling compression (`accept-encoding`) header"}
    http:Compression compression = http:COMPRESSION_AUTO;
    @display {label:"Configurations associated with the behaviour of the Circuit Breaker"}
    http:CircuitBreakerConfig? circuitBreaker = ();
    @display {label:"Configurations associated with retrying"}
    http:RetryConfig? retryConfig = ();
    @display {label:"Configurations associated with inbound response size limits"}
    http:ResponseLimitConfigs responseLimits = {};
    @display {label:"Proxy server related options"}
    http:ProxyConfig? proxy = ();
    @display {label:"Enables the inbound payload validation functionalty which provided by the constraint package. Enabled by default"}
    boolean validation = true;
    @display {label:"Provides settings related to client socket configuration"}
    http:ClientSocketConfig socketConfig = {};
    @display {label:"Provides settings related to SSL/TLS"}
    http:ClientSecureSocket? secureSocket = ();
|};

# Configs of the file server where bulk export files will be stored
#
# + fileServerUrl - Bulk export file server base url
public type BulkFileServerConfig record {|
    *http:ClientConfiguration;
    @display {label: "Bulk export file server base url"}
    string fileServerUrl;
|};

# Represents a success response coming from the fhir server side
#
# + httpStatusCode - HTTP status code from the interaction  
# + 'resource - Field Description  
# + serverResponseHeaders - Map of header values returning from the server
public type FHIRResponse record {|
    int httpStatusCode;
    json|xml 'resource;
    map<string> serverResponseHeaders;

|};

# Represents a bulk file response coming from the fhir server side
#
# + httpStatusCode - HTTP status code returned from the server 
# + dataStream - Bulk data file stream   
# + serverResponseHeaders - Map of header values returned from the server
public type FHIRBulkFileResponse record {|
    int httpStatusCode;
    stream<byte[], io:Error?> dataStream;
    map<string> serverResponseHeaders;
|};

# Represents the details of the error response that represents an unsuccessful interaction with the server
#
# + httpStatusCode - HTTP status code from the interaction  
# + 'resource - Field Description  
# + serverResponseHeaders - Map of header values returning from the server
public type FHIRServerErrorDetails record {|
    int httpStatusCode;
    json|xml 'resource;
    map<string> serverResponseHeaders;

|};

# Represents the error type for an unsuccessful interaction with the server 
public type FHIRServerError distinct error<FHIRServerErrorDetails>;

# Represent Connector related errors
#
# + errorDetails - the full error 
public type FHIRConnectorErrorDetail record {|
    error errorDetails?;
|};

# Represents the error type for connector side errors
public type FHIRConnectorError distinct error<FHIRConnectorErrorDetail>;

# Represents the errors that can be returned from the connector 
public type FHIRError FHIRServerError|FHIRConnectorError;

// TODO: have to change the var data types
# Represents parameters that can be used in a history interaction, add more name value pairs if necessary
#
# + _count - The maximum number of search results on a single response
# + _since - Only include resource versions that were created at or after the given instant in time  
# + _at - Only include resource versions that were current at some point during the  specified time period
# + _list - Only include resource versions that are referenced in the specified list
public type HistorySearchParameters record {
    string _count = "10";
    string _since?;
    string _at?;
    string _list?;
};

// TODO: have to change the var data types

# Represents the common search parameters across all resources
#
# + _id - Logical id of this artifact  
# + _lastUpdated - When the resource version last changed
# + _list - All resources in nominated list (by id, Type/id, url or one of the magic List types)
# + _profile - Profiles this resource claims to conform to
# + _query - A custom search profile that describes a specific defined query operation
# + _source - Identifies where the resource comes from	
# + _security - Security Labels applied to this resource
# + _tag - Tags applied to this resource
# + _text - Search on the narrative text (html) of the resource
# + _type - Used when a search is performed in a context which doesn't limit the search to indicate which types are being searched. See the FHIR search page for further discussion
# + _content - Search on the entire content of the resource
# + _filter - Filter search parameter which supports a more sophisticated grammar for searching
# + _has - Provides limited support for reverse chaining - that is, selecting resources based on the properties of resources that refer to them (instead of chaining where resources can be selected based on the properties of resources that they refer to)
public type BaseSearchParameters record {|
    string _id?;
    string[] _lastUpdated?;
    string _list?;
    string _profile?;
    string _query?;
    string _source?;
    string _security?;
    string _tag?;
    string _text?;
    string _type?;
    string _content?;
    string _filter?;
    string _has?;

|};

# Represents parameters that can be used in a search interaction, add more name value pairs if necessary
public type SearchParameters record {
    *BaseSearchParameters;
};

# Represents common parameters that can be used in bulk export kick off request
#
# + _outputFormat - Output encoding style  
# + _since - Time instant where only resources that were last updated on or after the given time will be included in the export  
# + _type - Array of resource types to include in the export  
# + _typeFilter - Array of search URL that can be used to narrow the scope of the export
public type BaseBulkExportParameters record {|
    string _outputFormat = FHIR_ND_JSON;
    string _since?;
    string[] _type?;
    string[] _typeFilter?;
|};

# Represents parameters that can be used in bulk export kick off request, add more name value pairs if necessary
public type BulkExportParameters record {
    *BaseBulkExportParameters;
};

# Represents a FHIR resource identifier, typically used for conditional create, update, or delete operations.
#
# + system - The namespace or system that issues the identifier (e.g., a URI)
# + value - The actual identifier value assigned to the resource
type ResourceIdentifier record {
    string system;
    string value;
};

# Represents the possible types that can be used as a condition in conditional FHIR interactions.
#
# Used in conditional create, update, or delete operations.
# Can be one of:
# - `ResourceIdentifier`: A structured identifier with system and value.
# - `SearchParameters`: A set of search parameters to match resources.
# - `map<string[]>`: A map of key-value pairs (with array values) representing search conditions.
# - `string`: The conditional URL directly as a string (e.g., `"identifier=12345"`).
#
# For a conditional create, update or delete, you can:
# - Provide the conditional URL directly as a string for the `onCondition` parameter.
# - Or, provide conditional parameters as a `ResourceIdentifier`, `SearchParameters`, or `map<string[]>` to construct the conditional URL.
public type OnCondition ResourceIdentifier|SearchParameters|map<string[]>|string;

type ResourceTypeNId record {|
    string 'type;
    string? id;
|};

type ResourceLocationDetails record {|
    string resourceId;
    string 'version;
|};

type XmlNameSpaceNRoot record {|
    string? namespace;
    string? rootName;
|};

type Pagination record {|
    string next?;
    string previous?;
    string self?;
|};
