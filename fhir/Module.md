## Overview

The connector serves as an interface for interacting with FHIR servers, allowing easy integration of FHIR data.

## Usage

Import the package to a Ballerina program.

```ballerina
import ballerinax/health.clients.fhir;
```

Create the required authentication configuration. The connector can accept various client authentication configurations supported by Ballerina, such as basic authentication, token-based authentication, etc. For instance, if it is required to use the client credentials grant, the config has to be created like the following.

```ballerina
http:OAuth2ClientCredentialsGrantConfig ehrSystemAuthConfig = {
    tokenUrl: "<tokenUrl>",
    clientId: "<clientId>",
    clientSecret: "<clientSecret>",
    scopes: ["system/Patient.read, system/Patient.write"]
};
```

Initialize the connector configuration record.

```ballerina
fhir:FHIRConnectorConfig ehrSystemConfig = {
    baseURL: "https://test.org/fhir/r4",
    mimeType: fhir:FHIR_JSON,
    authConfig : ehrSystemAuthConfig
};
```

Initialize the connector.

```ballerina
fhir:FHIRConnector fhirConnectorObj = check new (ehrSystemConfig);
```

Invoke the connector operations by passing the required parameters.

```ballerina
fhir:FHIRResponse|fhir:FHIRError fhirResponse = fhirConnectorObj->getById("Patient", "123456");
```

### Pkjwt Support

In addition to the authentication methods supported by Ballerina, the connector also supports private key JWT authentication, which requires creating the config as following.

* Import the health.base authentication package.

    ```ballerina
    import ballerinax/health.base.auth;
    ```

* Create the auth config.

    ```ballerina
    auth:PkjwtAuthConfig ehrSystemAuthConfig = {
        keyFile: "<path_to_key_file>",
        clientId: "<clientId>",
        tokenEndpoint: "<tokenUrl>"
    };
    ```

This can be passed to the connector configuration.

### Bulk Data Export Operations Support

This connector supports FHIR Bulk Data Export operations and does not require any additional configuration.
However, if the generated files get stored in another file server apart from the FHIR server,
add the file server configurations to the connector configuration record.

* Update the connector config.

    ```ballerina
    fhir:FHIRConnectorConfig ehrSystemConfig = {
        baseURL: "https://test.org/fhir/r4",
        mimeType: fhir:FHIR_JSON,
        authConfig : ehrSystemAuthConfig,
        fileServerBaseURL: "https://storage.test.org",
        fileServerAuthConfig: fileServerAuthConfig,
    };
    ```

Now the exported files can be accessed from the file server using the connector.

### Rewrite FHIR Server URL

This connector can rewrite/replace FHIR server URL in the response payload and headers with a custom URL.

* Update the connector config to enable this feature.

    ```ballerina
    fhir:FHIRConnectorConfig ehrSystemConfig = {
        baseURL: "https://test.org/fhir/r4",
        mimeType: fhir:FHIR_JSON,
        authConfig : ehrSystemAuthConfig,
        urlRewrite: true,
        replacementURL: "https://my.fhir.service/r4"
    };
    ```

Now the FHIR server URLs will get replaced with the replacement URL.
