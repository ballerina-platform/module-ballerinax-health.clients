# Ballerina FHIR Client Connector

A generic FHIR client module for Ballerina, enabling seamless integration with FHIR servers for healthcare applications. This connector supports all standard FHIR operations, including CRUD, conditional interactions, and bulk data export, with support for various authentication mechanisms.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
  - [Initialize the Connector](#initialize-the-connector)
  - [CRUD Operations: Standard (Non-Conditional) and Conditional Interactions](#crud-operations-standard-non-conditional-and-conditional-interactions)
    - [Create a Resource](#create-a-resource)
    - [Read a Resource](#read-a-resource)
    - [Update a Resource](#update-a-resource)
    - [Patch a Resource](#patch-a-resource)
    - [Delete a Resource](#delete-a-resource)
  - [Search Operations (GET and POST)](#search-operations-get-and-post)
  - [Invoking Custom FHIR Operations](#invoking-custom-fhir-operations)
  - [Bulk Data Operations](#bulk-data-operations)
  - [CapabilityStatement Validation](#capabilitystatement-validation)
- [Bulk Export Usage with FHIR Client](#bulk-export-usage-with-fhir-client)
- [Advanced Features](#advanced-features)
- [References](#references)

---

## Overview

This package provides a Ballerina connector to interact with FHIR servers, supporting all major FHIR operations and authentication mechanisms. It is suitable for building healthcare applications that need to communicate with FHIR-compliant systems.

## Features

- Connect to any FHIR server supporting standard authentication (OAuth2, Basic Auth, PKJWT, etc.)
- Perform all FHIR CRUD operations and conditional interactions
- Support for FHIR Bulk Data Export
- Handle authentication and token management
- Support for FHIR+JSON and FHIR+XML payloads
- Optionally rewrite FHIR server URLs in responses

## Installation

## Importing the Package

Install the package using the Ballerina package manager:

```sh
bal pull ballerinax/health.clients.fhir
```

To use the connector in your Ballerina code, import it as follows:

```ballerina
import ballerinax/health.clients.fhir as fhir_client;
```

## Configuration

### Authentication

The connector supports multiple authentication methods. For example, to use OAuth2 Client Credentials:

```ballerina
import ballerina/http;

http:OAuth2ClientCredentialsGrantConfig ehrSystemAuthConfig = {
    tokenUrl: "<tokenUrl>",
    clientId: "<clientId>",
    clientSecret: "<clientSecret>"
};
```

### Connector Configuration

```ballerina
fhir_client:FHIRConnectorConfig fhirServerConfig = {
    baseURL: "https://hapi.fhir.org/baseR4",
    mimeType: fhir_client:FHIR_JSON,
    authConfig: ehrSystemAuthConfig
};
```

## Usage

### Initialize the Connector

```ballerina
fhir_client:FHIRConnector fhirConnector = check new (fhirServerConfig);
```

### CRUD Operations: Standard (Non-Conditional) and Conditional Interactions

#### Create a Resource

**Standard (Non-Conditional) Create:**

```ballerina
fhir_client:FHIRResponse|fhir_client:FHIRError response =
    fhirConnector->create(resourceJson);
```

**Conditional Create:**

```ballerina
map<string[]> condition = { "identifier": ["12345"] };
fhir_client:FHIRResponse|fhir_client:FHIRError response =
    fhirConnector->create(resourceJson, onCondition = condition);
```

#### Read a Resource

```ballerina
fhir_client:FHIRResponse|fhir_client:FHIRError response =
    fhirConnector->getById("Patient", "123456");
```

#### Update a Resource

**Standard (Non-Conditional) Update:**

```ballerina
fhir_client:FHIRResponse|fhir_client:FHIRError response =
    fhirConnector->update(resourceJson);
```

**Conditional Update:**

```ballerina
map<string[]> condition = { "identifier": ["12345"] };
fhir_client:FHIRResponse|fhir_client:FHIRError response =
    fhirConnector->update(resourceJson, onCondition = condition);
```

#### Patch a Resource

**Standard (Non-Conditional) Patch:**

```ballerina
fhir_client:FHIRResponse|fhir_client:FHIRError response =
    fhirConnector->patch("Patient", patchData, id = "123");
```

**Conditional Patch:**

```ballerina
map<string[]> condition = { "identifier": ["12345"] };
fhir_client:FHIRResponse|fhir_client:FHIRError response =
    fhirConnector->patch("Patient", patchData, onCondition = condition);
```

#### Delete a Resource

**Standard (Non-Conditional) Delete:**

```ballerina
fhir_client:FHIRResponse|fhir_client:FHIRError response =
    fhirConnector->delete("Patient", id = "123");
```

**Conditional Delete:**

```ballerina
map<string[]> condition = { "identifier": ["12345"] };
fhir_client:FHIRResponse|fhir_client:FHIRError response =
    fhirConnector->delete("Patient", onCondition = condition);
```

### Search Operations (GET and POST)

**GET Search:**

```ballerina
fhir_client:FHIRResponse|fhir_client:FHIRError response =
    fhirConnector->search("Patient", searchParameters = { "name": ["John"] });
```

**POST Search:**

```ballerina
fhir_client:FHIRResponse|fhir_client:FHIRError response =
    fhirConnector->search("Patient", mode = fhir_client:POST, searchParameters = { "name": ["John"] });
```

### Invoking Custom FHIR Operations

You can invoke custom FHIR operations (e.g., `$everything`, `$lookup`) using the `callOperation` method.

#### Usage of `mode` parameter in `callOperation`

The `mode` parameter specifies the HTTP method to use when invoking the FHIR operation:

- Use `http:POST` to invoke the operation with an HTTP POST request (this is the default if not specified).
- Use `http:GET` to invoke the operation with an HTTP GET request.

This allows you to control whether the FHIR operation is called using GET or POST, depending on the requirements of the specific FHIR operation.

**Default value:** If you do not specify the `mode` parameter, the default is `POST`.

**Examples:**

```ballerina
// Invoke a custom operation using POST (default)
fhir_client:FHIRResponse|fhir_client:FHIRError response =
    fhirConnector->callOperation("Patient", operationName = "everything", data = {});

// Invoke a custom operation using GET
fhir_client:FHIRResponse|fhir_client:FHIRError response =
    fhirConnector->callOperation("Patient", operationName = "everything", mode = http:GET, id = "123");
```

### Bulk Data Operations

**Start Bulk Export:**

```ballerina
fhir_client:FHIRResponse|fhir_client:FHIRError response =
    fhirConnector->bulkExport(fhir_client:EXPORT_PATIENT);
```

**Check Bulk Export Status:**

- Using content-location URL (polling URL from kickoff response)

    ```ballerina
    fhir_client:FHIRResponse|fhir_client:FHIRError response =
        fhirConnector->bulkStatus("https://example/fhir/bulkstatus/123456");
    ```

- Using exportId (from kickoff response body)

    ```ballerina
    fhir_client:FHIRResponse|fhir_client:FHIRError response =
        fhirConnector->bulkStatus(exportId = "123456");
    ```

**Download Exported File:**

- Using file URL (from status response)

    ```ballerina
    fhir_client:FHIRBulkFileResponse|fhir_client:FHIRError response =
        fhirConnector->bulkFile(fileUrl = "https://example/fhir/files/Patient-123456.ndjson");
    ```

- Using exportId and resourceType

    ```ballerina
    fhir_client:FHIRBulkFileResponse|fhir_client:FHIRError response =
        fhirConnector->bulkFile(exportId = "123456", resourceType = fhir_client:PATIENT);
    ```

**Delete Bulk Export Data:**

- Using content-location URL

    ```ballerina
    fhir_client:FHIRResponse|fhir_client:FHIRError response =
        fhirConnector->bulkDataDelete("https://example/fhir/bulkstatus/123456");
    ```

- Using exportId

    ```ballerina
    fhir_client:FHIRResponse|fhir_client:FHIRError response =
        fhirConnector->bulkDataDelete(exportId = "123456");
    ```

### CapabilityStatement Validation

> **Note:** This validation is available in `ballerinax/health.clients.fhir` version 3.0.0 onwards.

When initializing the `FHIRConnector`, the connector automatically retrieves and validates the FHIR server's [CapabilityStatement](https://hl7.org/fhir/capabilitystatement.html) as part of its `init` function. This validation ensures that the target service is a genuine FHIR server and supports the required FHIR version (such as R4 or R5). If the CapabilityStatement is missing, invalid, or indicates an unsupported FHIR version, the connector initialization will fail. This mechanism is essential for verifying that the service you are connecting to is a compliant FHIR service before performing any operations.

## Bulk Export Usage with FHIR Client

This section describes how to use the bulk export functions provided by the FHIR client, including configuration, execution flow, and example code.

### 1. Configuring `bulkFileServerConfig`

To enable bulk export, you must configure the `bulkFileServerConfig` in your `FHIRConnectorConfig`. This configuration specifies the file server details where exported files will be stored or retrieved from. Example configuration:

```ballerina
fhir_client:BulkFileServerConfig bulkFileServerConfig = {
    'type: "fhir",           // or ftp
    host: "<url>",           // host url of the server 
    directory: "<dir-path>", // directory to save the exported files in the file server, if type is ftp
    username: "<username>",  // username to access the server, if type is ftp
    password: "<password>"   // password to access the server, if type if ftp
};

fhir_client:FHIRConnectorConfig fhirServerConfig = {
    baseURL: "https://bulk-data.smarthealthit.org/fhir",
    mimeType: fhir_client:FHIR_JSON, 
    bulkFileServerConfig: bulkFileServerConfig
};
```

### 2. Bulk Export Execution Flow

The typical steps for performing a bulk export are:

1. **Start the bulk export:**

   ```ballerina
   fhir_client:FHIRResponse response = check fhirConnector->bulkExport(fhir_client:EXPORT_PATIENT);
   json responseBody = response.'resource.toJson();
   string exportId = check responseBody.exportId;
   string pollingUrl = check responseBody.pollingUrl;
   ```

2. **Wait for export completion:**
   Use `waitForBulkExportCompletion(exportId)` to block the main thread until the export is finished. This is especially useful in standalone applications (e.g., inside a `main` function). In service-based applications, this is usually not required.

   ```ballerina
   fhir_client:waitForBulkExportCompletion(exportId);
   ```

3. **Download the exported files:**

   ```ballerina
   fhir_client:FHIRResponse response = check fhirConnector->bulkFile(exportId = exportId, resourceType = fhir_client:PATIENT);
   ```

4. **Delete the exported files from the server:**

   ```ballerina
   fhir_client:FHIRResponse response = check fhirConnector->bulkDataDelete(exportId = exportId);
   ```

### 3. Use Case for `waitForBulkExportCompletion`

- **Standalone Applications:**
  Use `waitForBulkExportCompletion(exportId)` to ensure the main thread waits until the export process is complete before proceeding. This is important to avoid attempting to download files before they are ready.
- **Service Applications:**
  This function is generally not needed, as service handlers are event-driven and can manage asynchronous operations differently.

### Sample: Bulk Export with FHIR Client

```ballerina
import ballerinax/health.clients.fhir as fhir_client;

fhir_client:BulkFileServerConfig bulkFileServerConfig = {
    'type: "fhir", 
    host: "www.example.com/bulk",
    directory: "/target/files", 
    username: "<username>",
    password: "<password>"
};

fhir_client:FHIRConnectorConfig fhirServerConfig = {
    baseURL: "https://bulk-data.smarthealthit.org/fhir",
    mimeType: fhir_client:FHIR_JSON, 
    bulkFileServerConfig: bulkFileServerConfig
};

fhir_client:FHIRConnector fhirConnector = check new (fhirServerConfig);

public function main() returns error? {
    // Start bulk export
    fhir_client:FHIRResponse response = check fhirConnector->bulkExport(fhir_client:EXPORT_PATIENT);
    json responseBody = response.'resource.toJson();
    string exportId = check responseBody.exportId;

    // Wait for export to complete (only needed in standalone/main)
    fhir_client:waitForBulkExportCompletion(exportId);

    // Download exported files
    _ = check fhirConnector->bulkFile(exportId = exportId, resourceType = fhir_client:PATIENT);

    // Delete exported files from server
    _ = check fhirConnector->bulkDataDelete(exportId = exportId);
}
```

## Advanced Features

- **Bulk Data Export**: Configure `bulkFileServerConfig` in the connector config to support file servers for exported data.
- **URL Rewriting**: Enable `urlRewrite` and set `replacementURL` in the config to rewrite FHIR server URLs in responses.
- **PKJWT Authentication**: Supported via `auth:PKJWTAuthConfig`.

## References

- [FHIR REST API Specification](https://hl7.org/fhir/http.html)
- [FHIR Bulk Data Export IG](https://hl7.org/fhir/uv/bulkdata/export.html)
- [Ballerina Language](https://ballerina.io/)

---

This README provides a comprehensive guide for using your Ballerina FHIR client module, including setup, configuration, and practical code samples for common FHIR operations.
