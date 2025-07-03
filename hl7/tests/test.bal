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
import ballerina/test;
import ballerina/log;
import ballerina/tcp;
import ballerinax/health.hl7v2;

final string msg = "MSH|^~\\&|ADT1|GOOD HEALTH HOSPITAL|GHH LAB, INC.|GOOD HEALTH HOSPITAL|" +
"198808181126|SECURITY|ADT^A01^ADT_A01|MSG00001|P|2.x||\rEVN|A01|200708181123||" +
"\rPID|1||PATID1234^5^M11^ADT1^MR^GOOD HEALTH HOSPITAL~123456789^^^USSSA^SS||" +
"BATMAN^ADAM^A^III||19610615|M||C|2222 HOME STREET^^GREENSBORO^NC^27401-1020|GL|" +
"(555) 555-2004|(555)555-2004||S||PATID12345001^2^M10^ADT1^AN^A|444333333|987654^NC|" +
"\rNK1|1|NUCLEAR^NELDA^W|SPO^SPOUSE||||NK^NEXT OF KIN$\rPV1|1|I|2000^2012^01||||" +
"004777^ATTEND^AARON^A|||SUR||||ADM|A0|";

final string invalidMsg = "MSH|^~\\&|ADT1|GOOD HEALTH HOSPITAL|GHH LAB, INC.|GOOD HEALTH HOSPITAL|" +
"198808181126|SECURITY|ADT^A01^ADT_A01|MSG00001|P|||\rEVN|A01|200708181123||";

tcp:Listener hl7Listener = check new tcp:Listener(59519);

@test:BeforeSuite
function startMockHl7Listener() {
    error? attach = hl7Listener.attach(new TcpMockService());
    if attach is error {
        log:printError(string `Error occurred while attaching the HL7 listener: ${attach.message()}`, attach);
    }
    error? 'start = hl7Listener.'start();
    if 'start is error {
        log:printError(string `Error occurred while starting the HL7 listener: ${'start.message()}`, 'start);
    }
    log:printInfo("HL7 listener started successfully.");
}

@test:Config {}
function testHl7Client() returns error? {
    HL7Client hl7client = check new ("localhost", 59519);
    TST_2XX tstMsg = {
        msh: {
            msh1: "MSH",
            msh2: "^~\\&",
            msh3: {
                hd1: "ADT1",
                hd2: "GOOD HEALTH HOSPITAL",
                hd3: "GHH LAB, INC."
            },
            msh12: "2.x"
        }
    };
    hl7v2:Message|hl7v2:HL7Error response = hl7client->sendMessage(tstMsg);
    //since the concrete parset implementation is not available for 2.x version, the message will be returned as a error string.
    if response is hl7v2:HL7Error {
        test:assertEquals(response.detail().message, "Package not found for HL7 version : 2.x");
    }
    response = hl7client->sendMessage(hl7v2:createHL7WirePayload(string:toBytes(msg)));
    if response is hl7v2:HL7Error {
        test:assertEquals(response.detail().message, "Error occurred while parsing HL7 response message.");
    }

    HL7Client|hl7v2:HL7Error hl7clientForInvalidServer = new ("localhost", 59550);
    if hl7clientForInvalidServer is hl7v2:HL7Error {
        test:assertEquals(hl7clientForInvalidServer.detail().message, "Error occurred while initializing HL7 client.");
    }
}

@test:AfterSuite
function stopMockHl7Listener() {
    error? gracefulStopState = hl7Listener.gracefulStop();
    if gracefulStopState is error {
        log:printError(string `Error occurred while stopping the HL7 listener: ${gracefulStopState.message()}`, gracefulStopState);
    }
    log:printInfo("HL7 listener stopped successfully.");
}
