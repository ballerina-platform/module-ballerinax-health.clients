Package containing a generic FHIR client connector that can be used to connect to a FHIR server.

## Package overview

This package is used to connect to a FHIR server using the FHIRConnector.

### Compatibility

|                        | Version                                        |
|------------------------|------------------------------------------------|
| REST API Specification | <https://hl7.org/fhir/http.html>               |
| Bulk Data Export IG    | <https://hl7.org/fhir/uv/bulkdata/export.html> |

### Features and Capabilities

* Connects to a FHIR server that supports any widely used authentication mechanism. Eg: Oauth2, basic auth, etc.
* Support for all the FHIR interactions mentioned in the above specification.
* Support for all the FHIR bulk data export operations.
* Handle authentication to the server.
* Caching and managing the access tokens.
* Support for both FHIR+JSON and FHIR+XML payloads.
* Rewrite FHIR server URL in the response payload and headers with a custom URL.
