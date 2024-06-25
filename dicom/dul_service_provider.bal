import ballerina/tcp;
import ballerinax/health.dicom;

# DUL Service Provider
isolated class DULServiceProvider {
    private final tcp:Client socketClient;

    function init(Association association) returns error? {
        self.socketClient = check new (association.getClientConfig().peer, association.getClientConfig().port);
    }

    function sendPdu(Primitive primitive) returns error? {
        // Construct PDU
        Pdu pdu = check primitiveToPdu(primitive);

        // Encode PDU
        byte[] & readonly encodedPdu = check self.encodePdu(pdu);

        // Send to peer
        check self.socketClient->writeBytes(encodedPdu);
    }

    public function receivePdu() returns Primitive[]|error {
        // // Get from peer
        // // TODO: This read could include multiple PDUs, so have to come up with a way to read those properly
        // (byte[] & readonly) readBytes = check self.socketClient->readBytes();

        // // Decode and get PDU
        // Pdu pdu = check self.decodePdu(readBytes);

        // // TODO: Construct confirmation primitive
        // Primitive primitive = check pduToPrimitive(pdu);

        // // Return primitive
        // return primitive;

        // Get from peer
        (byte[] & readonly) readBytes = check self.socketClient->readBytes();

        Primitive[] primitives = [];

        while (readBytes.length() > 0) {
            // Decode and get PDU
            [Pdu, int] [pdu, pduLength] = check self.decodePdu(readBytes);

            // Construct confirmation primitive
            Primitive primitive = check pduToPrimitive(pdu);
            primitives.push(primitive);

            // Get remaining bytes
            readBytes = readBytes.slice(pduLength, readBytes.length()).cloneReadOnly();
        }

        // Return array of primitives
        return primitives;
    }

    // TODO: Add other PDU types
    function encodePdu(Pdu pdu) returns byte[] & readonly|error {
        if pdu is AAssociateRqPdu {
            return encodeAAssociateRqPdu(pdu);
        } else if pdu is AAbortPdu {
            return encodeAAbortPdu(pdu);
        } else if pdu is AReleaseRqPdu {
            return encodeAReleaseRqPdu(pdu);
        } else if pdu is PDataTfPdu {
            return encodePdataTfPdu(pdu);
        } else {
            return error("Unsupported PDU for encoding");
        }
    }

    function decodePdu(byte[] & readonly pduBytes) returns [Pdu, int]|error {
        // For all PDUs:
        // +---------+-------------+
        // | Byte(s) | Description |
        // +---------+-------------+
        // | 1       | PDU-type    |
        // | 2       | Reserved    |
        // | 3-6     | PDU-length  |
        // +---------+-------------+

        // PDU header (1 PDU-type byte + 1 Reserved byte + 4 PDU-length bytes)
        byte[] pduHeaderBytes = pduBytes.slice(0, 6);

        // PDU type
        byte pduTypeByte = pduHeaderBytes[0];
        PduType|error? pduType = getPduType(pduTypeByte);
        if pduType !is PduType {
            return error("Could not determine the PDU type of the PDU");
        }

        // PDU length
        byte[] pduLengthBytes = pduHeaderBytes.slice(2);
        int pduLength = check dicom:bytesToInt(pduLengthBytes, dicom:BIG_ENDIAN);

        if pduBytes.length() != (6 + pduLength) {
            return error("Invalid PDU length");
        }

        // PDU body bytes
        byte[] pduBodyBytes = pduBytes.slice(pduHeaderBytes.length(), pduHeaderBytes.length() + pduLength);

        // Parse the rest of the PDU based on the type
        match pduType {
            A_ASSOCIATE_AC => {
                return [check parseAAssociateAcPdu(pduBodyBytes), 6 + pduBodyBytes.length()];
            }
            A_ASSOCIATE_RJ => {
                return [check parseAAssociateRjPdu(pduBodyBytes), 6 + pduBodyBytes.length()];
            }
            A_RELEASE_RP => {
                return [check parseAReleaseRpPdu(pduBodyBytes), 6 + pduBodyBytes.length()];
            }
            P_DATA_TF => {
                return [check parsePDataTfPdu(pduBodyBytes), 6 + pduBodyBytes.length()];
            }
            _ => {
                return error(string `Unsupported PDU for parsing: ${pduType}`);
            }
        }
    }
}
