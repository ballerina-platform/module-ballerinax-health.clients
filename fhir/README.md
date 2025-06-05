
# Ballerina FHIR Client Connector

A generic FHIR client module for Ballerina, enabling seamless integration with FHIR servers for healthcare applications. This connector supports all standard FHIR operations, including CRUD, conditional interactions, and bulk data export, with support for various authentication mechanisms.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
  - [Initialize the Connector](#initialize-the-connector)
  - [CRUD and Conditional Operation Examples](#crud-and-conditional-operation-examples)
    - [1. Create a Resource (Conditional Create)](#1-create-a-resource-conditional-create)
    - [2. Read a Resource by ID](#2-read-a-resource-by-id)
    - [3. Update a Resource (Conditional Update)](#3-update-a-resource-conditional-update)
    - [4. Patch a Resource (Conditional Patch)](#4-patch-a-resource-conditional-patch)
    - [5. Delete a Resource (Conditional Delete)](#5-delete-a-resource-conditional-delete)
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

Add the dependency to your Ballerina project's `Ballerina.toml`:

```toml
[dependency]
org = "ballerinax"
name = "health.clients.fhir"
version = "2.1.1"
```

Or use the Ballerina package manager:

```sh
bal add ballerinax/health.clients.fhir
```

## Configuration

### Authentication

The connector supports multiple authentication methods. For example, to use OAuth2 Client Credentials:

```ballerina
import ballerina/http;

http:OAuth2ClientCredentialsGrantConfig ehrSystemAuthConfig = {
    tokenUrl: "<tokenUrl>",
    clientId: "<clientId>",
    clientSecret: "<clientSecret>",
    scopes: ["system/Patient.read", "system/Patient.write"]
};
```

### Connector Configuration

```ballerina
import ballerinax/health.clients.fhir as fhir_client;

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

### CRUD and Conditional Operation Examples

Below are sample usages for basic and conditional FHIR operations.

#### 1. Create a Resource (Conditional Create)

```ballerina
import ballerinax/health.fhir.r4;

r4:CodeSystem codeSystem = {
    id: "account-status",
    url: "http://hl7.org/fhir/account-status",
    version: "1.0.0",
    name: "AccountStatus",
    title: "Account Status Codes",
    status: r4:CODE_STATUS_ACTIVE,
    content: r4:CODE_CONTENT_EXAMPLE,
    concept: [
        { definition: "The account is active and in use." }
    ]
};

map<string[]> condition = { "url": ["http://hl7.org/fhir/account-status"] };

fhir_client:FHIRResponse|fhir_client:FHIRError response = 
    fhirConnector->create(codeSystem.toJson(), onCondition = condition);

if response is fhir_client:FHIRResponse {
    io:println("Response status code: ", response.httpStatusCode);
    io:println("Response body: ", response.'resource.toJson());
} else {
    io:println("FHIR Error: (conditional create) ", response.message());
}
```

#### 2. Read a Resource by ID

```ballerina
fhir_client:FHIRResponse|fhir_client:FHIRError response = 
    fhirConnector->getById("Patient", "123456");

if response is fhir_client:FHIRResponse {
    io:println("Response status code: ", response.httpStatusCode);
    io:println("Response body: ", response.'resource.toJson());
} else {
    io:println("FHIR Error: (read) ", response.message());
}
```

#### 3. Update a Resource (Conditional Update)

```ballerina
import ballerinax/health.fhir.r4;

r4:CodeSystem codeSystem = {
    id: "account-status",
    url: "http://hl7.org/fhir/account-status",
    version: "1.0.0",
    name: "AccountStatus",
    title: "Account Status Codes",
    status: r4:CODE_STATUS_ACTIVE,
    content: r4:CODE_CONTENT_EXAMPLE,
    concept: [
        { definition: "The account is active and in use." }
    ]
};

map<string[]> condition = { "url": ["http://hl7.org/fhir/account-status"] };

fhir_client:FHIRResponse|fhir_client:FHIRError response = 
    fhirConnector->update(codeSystem.toJson(), onCondition = condition);

if response is fhir_client:FHIRResponse {
    io:println("Response status code: ", response.httpStatusCode);
    io:println("Response body: ", response.'resource.toJson());
} else {
    io:println("FHIR Error: (conditional update) ", response.message());
}
```

#### 4. Patch a Resource (Conditional Patch)

```ballerina
json patchData = [
    {
        "op": "replace",
        "path": "/active",
        "value": false
    }
];

fhir_client:FHIRResponse|fhir_client:FHIRError response = 
    fhirConnector->patch(fhir_client:PATIENT, patchData, id = "123");

if response is fhir_client:FHIRResponse {
    io:println("Response status code: ", response.httpStatusCode);
    io:println("Response body: ", response.'resource.toJson());
} else {
    io:println("FHIR Error: (conditional patch) ", response.message());
}
```

#### 5. Delete a Resource (Conditional Delete)

```ballerina
map<string[]> condition = { "url": ["http://hl7.org/fhir/account-status"] };

fhir_client:FHIRResponse|fhir_client:FHIRError response = 
    fhirConnector->delete("CodeSystem", onCondition = condition);

if response is fhir_client:FHIRResponse {
    io:println("Response status code: ", response.httpStatusCode);
    io:println("Response body: ", response.'resource.toJson());
} else {
    io:println("FHIR Error: (conditional delete) ", response.message());
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
