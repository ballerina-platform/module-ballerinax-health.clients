Package containing a generic HL7 client that can be used to connect to an HL7 Exchange(Server).

## Package overview

This package is used to connect to a HL7 exchange(server) using the HL7Client.

### Compatibility

|                        | Version                                        |
|------------------------|------------------------------------------------|
| REST API Specification | <https://hl7.org/fhir/http.html>               |
| Bulk Data Export IG    | <https://hl7.org/fhir/uv/bulkdata/export.html> |

### Features and Capabilities

* Send HL7 message to remote HL7 exchage using TCP

## Usage

This module provides the `HL7Client` client to send HL7 messages to remote HL7 endpoints.

```ballerina
import ballerinax/hl7v2;
import ballerinax/health.clients.hl7;

public function main() returns error? {
    // Initialize the client
    hl7:HL7Client hl7Client = check new("localhost", 9876);
    
    // Create an HL7 message
    hl7v2:Message adtMessage = check getHL7Message();
    hl7v23:adt_a01 adtMessage = {
    msh: {
        msh1: "|",
        msh2: "^~\\&",
        msh3: {
            hd1: "HOSPITAL_EMR"
        },
        msh4: {
            hd1: "MAIN_HOSPITAL"
        },
        msh5: {
            hd1: "RAPP"
        },
        msh6: {
            hd1: "198808181126"
        },
        msh7: {
            ts1: "2020-05-08T13:06:43"
        },
        msh9: {
            msg1: "ADT",
            msg2: "A01"
        },
        msh10: "99302882jsh",
        msh11: {
            pt1: "P"
        },
        msh12: {
            vid1: hl7v24:VERSION
        },
        msh15: "AL",
        msh17: "44",
        msh18: ["ASCII"]
    },
    evn: {
        evn1: "NEW_ADMISSION"
    },
    pid: {
        pid5: [
            {
                xpn1: {
                    fn1: "Doe"},
                xpn2: "John",
                xpn3: "Hamish"
            }
        ]
    },pv1: {}
    };
    
    // Send the message
    hl7v2:Message|hl7v2:HL7Error response = hl7Client->sendMessage(adtMessage);
    
    if response is hl7v2:Message {
        // Process response
    } else {
        // Handle error
    }
}
```

#### Configuring Secure Connection
To configure TLS for the HL7 client, you can pass a `secureSocket` configuration in the `tcp:ClientConfiguration` when initializing the client. This allows secure communication with the HL7 server.

```ballerina
hl7:HL7Client hl7Client = check new("localhost", 9876, config = {
    secureSocket: {
        // public certificate for server verification
        cert: "../resource/path/to/public.crt"
    }
});
```

## Error Handling

The client returns various types of `hl7v2:HL7Error` instances based on the type of error:

- `HL7_V2_MSG_VALIDATION_ERROR`: When there are issues with the message content (empty message, invalid version, etc.)
- `HL7_V2_CLIENT_ERROR`: When there are issues with the client connection
- `HL7_V2_PARSER_ERROR`: When there are issues parsing the response message
