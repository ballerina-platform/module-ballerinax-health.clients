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

import ballerina/tcp;
import ballerinax/health.hl7v2;

# String type
type ST string;

# Composite Element record. To be used in Version ID record.
# 
# + ce1 - Identifier
# + ce2 - Text
# + ce3 - Name of Coding System
# + ce4 - Alternate Identifier
# + ce5 - Alternate Text
# + ce6 - Name of Alternate Coding System
type CE record {
    *hl7v2:CompositeType;
    ST ce1 = "";
    ST ce2 = "";
    ST ce3 = "";
    ST ce4 = "";
    ST ce5 = "";
    ST ce6 = "";
};

# Version ID record
#  + vid1 - Version ID
#  + vid2 - Internationalization ID
#  + vid3 - Internal Version ID
type VID record {
    *hl7v2:CompositeType;
    ST vid1 = "";
    CE vid2 = {};
    CE vid3 = {};
};

# HL7 Client implementation.
@display {label: "HL7 Client"}
public isolated client class HL7Client {

    final string host;
    final int port;

    # Initialize HL7 client with given remote host and port.
    # + remoteHost - Remote host to connect to.
    # + remotePort - Remote port to connect to.
    public isolated function init(string remoteHost, int remotePort) returns hl7v2:HL7Error? {

        self.host = remoteHost;
        self.port = remotePort;
    }

    # Send a single HL7 message to given encoded HL7 message to given endpoint.
    # + message - HL7 message as record or encoded binary message. If record is given, it will be encoded to binary message
    # + return - Response HL7 encoded response from the target server. HL7Error if error occurred
    remote function sendMessage(hl7v2:Message|byte[] message) returns hl7v2:Message|hl7v2:HL7Error {

        if message is hl7v2:Message {
            anydata mshSegment = message.get("msh");
            if mshSegment is hl7v2:Segment {
                anydata hl7Version = mshSegment.get("msh12");
                // from hl7v24 onwards, MSH12 has 3 parts vid1(version id), vid2(internationalization id), vid3(internal version id)
                string|error versionId = "";
                if hl7Version is string {
                    versionId = hl7Version;
                } else {
                    json vid = hl7Version.toJson();
                    VID|error value = vid.cloneWithType();

                    if value is error {
                        return error hl7v2:HL7Error(hl7v2:HL7_V2_MSG_VALIDATION_ERROR, message = "Error occurred while parsing HL7 message version.");
                    }
                    versionId = value.vid1;
                }
                
                if versionId is string {
                    byte[]|hl7v2:HL7Error encodedMessage = hl7v2:encode(versionId, message);
                    if encodedMessage is byte[] {
                        byte[]|hl7v2:HL7Error response = self.writeToHL7Stream(encodedMessage);
                        if response is byte[] {
                            hl7v2:Message|hl7v2:HL7Error parseResult = hl7v2:parse(response);
                            if parseResult is hl7v2:HL7Error {
                                return error hl7v2:HL7Error(hl7v2:HL7_V2_CLIENT_ERROR, parseResult, message = "Error occurred while parsing HL7 response message.");
                            }
                            return parseResult;
                        }
                        return response;
                    }
                    return encodedMessage;
                }
                return error hl7v2:HL7Error(hl7v2:HL7_V2_MSG_VALIDATION_ERROR, message = "HL7 message version cannot be empty.");
            }
        } else {
            byte[]|hl7v2:HL7Error response = self.writeToHL7Stream(message);
            if response is byte[] {
                hl7v2:Message|hl7v2:HL7Error parseResult = hl7v2:parse(response);
                if parseResult is hl7v2:HL7Error {
                    return error hl7v2:HL7Error(hl7v2:HL7_V2_PARSER_ERROR, parseResult, message = "Error occurred while parsing HL7 response message.");
                }
            } else {
                return response;
            }
        }
        return error hl7v2:HL7Error(hl7v2:HL7_V2_CLIENT_ERROR, message = "Something went wrong sending HL7 message.");
    }

    # This function is used to send HL7 message to given HL7 endpoint using TCP Client.
    #
    # + message - Byte stream of the HL7 message.
    # + return - Returns byte stream of the HL7 response or HL7Error if error occurred.
    function writeToHL7Stream(byte[] message) returns byte[]|hl7v2:HL7Error {

        if message.length() > 0 {
            do {
                tcp:Client tcpClient = check new (self.host, self.port);
                check tcpClient->writeBytes(message);
                readonly & byte[] receivedData = check tcpClient->readBytes();
                check tcpClient->close();
                return receivedData;
            } on fail var e {
                return error hl7v2:HL7Error(hl7v2:HL7_V2_CLIENT_ERROR, e, message = "Error occurred while sending HL7 message.");
            }
        }
        return error hl7v2:HL7Error(hl7v2:HL7_V2_MSG_VALIDATION_ERROR, message = "HL7 message content cannot be empty.");
    }
}
