// Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com).
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
import ballerina/log;
import ballerina/tcp;
import ballerinax/health.hl7v2;

type HD record {
    *hl7v2:CompositeType;
    ST hd1 = "";
    ST hd2 = "";
    ST hd3 = "";
};

type MSH record {
    *hl7v2:Segment;
    string name = "MSH";
    ST msh1 = "";
    ST msh2 = "";
    HD msh3;
    ST msh12 = "";
};

@hl7v2:MessageDefinition {
    segments: {}
}
type TST_2XX record {
    *hl7v2:Message;
    string name = "TST_2XX";
    MSH msh;
};

service class TcpMockService {
    *tcp:Service;

    remote function onConnect(tcp:Caller caller) returns tcp:ConnectionService {
        log:printInfo(string `Client connected to echoServer: ${caller.remotePort}`);
        return new HL7ServiceMockConnectionService();
    }
}

service class HL7ServiceMockConnectionService {
    *tcp:ConnectionService;

    remote function onBytes(tcp:Caller caller, readonly & byte[] data) returns byte[]|tcp:Error? {
        string|error recievedMsg = string:fromBytes(data);
        if recievedMsg is string {
            log:printInfo(string `Received HL7 Message: ${recievedMsg}`);
            return data;
        }
        log:printInfo("Error occurred while receiving HL7 message.");
        return error(string `Error occurred while processing the received message: ${recievedMsg.message()}`);
    }

    remote function onError(tcp:Error err) {
        log:printInfo(string `An error occurred while receiving HL7 message: ${err.message()}`);
    }

    remote function onClose() {
        log:printInfo("Client left.");
    }
}
