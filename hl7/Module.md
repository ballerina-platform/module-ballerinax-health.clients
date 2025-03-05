# Module Overview

## Package

The `HL7Client` module provides a client implementation for sending HL7 (Health Level Seven) messages to HL7 servers using TCP connections.

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

## Classes

### HL7Client

Represents an isolated client that can be used to send HL7 messages to a remote server.

```ballerina
public isolated client class HL7Client {
    // Client implementation
}
```

#### Methods

##### `init`
```ballerina
public isolated function init(string remoteHost, int remotePort) returns hl7v2:HL7Error?
```

Initializes the HL7 client with the given remote host and port.

###### Parameters
- `remoteHost`: Remote host to connect to.
- `remotePort`: Remote port to connect to.

###### Return Value
- `hl7v2:HL7Error?`: An error if initialization fails.

##### `sendMessage`
```ballerina
remote function sendMessage(hl7v2:Message|byte[] message) returns hl7v2:Message|hl7v2:HL7Error
```

Sends a single HL7 message to the configured endpoint.

###### Parameters
- `message`: HL7 message as a record or encoded binary message. If a record is given, it will be encoded to a binary message.

###### Return Value
- `hl7v2:Message|hl7v2:HL7Error`: The HL7 response message or an error if one occurs.

## Error Handling

The client returns various types of `hl7v2:HL7Error` instances based on the type of error:

- `HL7_V2_MSG_VALIDATION_ERROR`: When there are issues with the message content (empty message, invalid version, etc.)
- `HL7_V2_CLIENT_ERROR`: When there are issues with the client connection
- `HL7_V2_PARSER_ERROR`: When there are issues parsing the response message