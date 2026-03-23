## Overview

This is a HL7 v2 client implemented in Ballerina. It enables applications to connect to HL7 exchanges (servers) over TCP and send HL7 v2 messages to remote HL7 servers.

## Key Features

- Send HL7 v2 messages to remote HL7 servers using TCP
- Use a simple `HL7Client` API for request-response interactions
- Configure TLS using `secureSocket` settings for secure transport
- Receive typed HL7 response messages and structured HL7 errors

## Installation

### Importing the Connector

Import the connector in your Ballerina project:

```ballerina
import ballerinax/health.clients.hl7 as hl7;
```

## Usage

This module provides the `HL7Client` client to send HL7 messages to remote HL7 endpoints.

```ballerina
import ballerinax/hl7v2;
import ballerinax/hl7v23;
import ballerinax/hl7v24;
import ballerinax/health.clients.hl7 as hl7;

public function main() returns error? {
    // Initialize the client
    hl7:HL7Client hl7Client = check new ("localhost", 9876);

    // Create an HL7 message
    hl7v23:adt_a01 adtMessage = {
        msh: {
            msh1: "|",
            msh2: "^~\\&",
            msh3: {hd1: "HOSPITAL_EMR"},
            msh4: {hd1: "MAIN_HOSPITAL"},
            msh5: {hd1: "RAPP"},
            msh6: {hd1: "198808181126"},
            msh7: {ts1: "2020-05-08T13:06:43"},
            msh9: {msg1: "ADT", msg2: "A01"},
            msh10: "99302882jsh",
            msh11: {pt1: "P"},
            msh12: {vid1: hl7v24:VERSION},
            msh15: "AL",
            msh17: "44",
            msh18: ["ASCII"]
        },
        evn: {evn1: "NEW_ADMISSION"},
        pid: {
            pid5: [{
                xpn1: {fn1: "Doe"},
                xpn2: "John",
                xpn3: "Hamish"
            }]
        },
        pv1: {}
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

### Configuring a Secure Connection

To configure TLS for the HL7 client, pass a `secureSocket` configuration in the `tcp:ClientConfiguration` when initializing the client.

```ballerina
hl7:HL7Client hl7Client = check new ("localhost", 9876, config = {
    secureSocket: {
        // Public certificate for server verification
        cert: "../resource/path/to/public.crt"
    }
});
```

## Error Handling

The client returns `hl7v2:HL7Error` values based on the error category:

- `HL7_V2_MSG_VALIDATION_ERROR`: Issues with message content (for example, empty message or invalid version)
- `HL7_V2_CLIENT_ERROR`: Client transport or connectivity issues
- `HL7_V2_PARSER_ERROR`: Issues while parsing the response message

## References

- [Ballerina Central - health.clients.hl7](https://central.ballerina.io/ballerinax/health.clients.hl7)
- [HL7 International](https://www.hl7.org/)
- [Ballerina Language](https://ballerina.io/)
