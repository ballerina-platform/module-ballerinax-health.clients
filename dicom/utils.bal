import ballerinax/health.dicom;

isolated function createReservedBytes(int length) returns byte[] {
    byte[] bytes = [];
    bytes.setLength(length);
    return bytes;
}

isolated function constructAeTitle(string name) returns byte[] {
    byte[] aeTitle = name.toBytes();
    aeTitle.setLength(16);
    return aeTitle;
}

isolated function getPduType(byte pduTypeByte) returns PduType? {
    match pduTypeByte {
        0x01 => {
            return A_ASSOCIATE_RQ;
        }
        0x02 => {
            return A_ASSOCIATE_AC;
        }
        0x03 => {
            return A_ASSOCIATE_RJ;
        }
        0x04 => {
            return P_DATA_TF;
        }
        0x05 => {
            return A_RELEASE_RQ;
        }
        0x06 => {
            return A_RELEASE_RP;
        }
        0x07 => {
            return A_ABORT;
        }
        _ => {
            return;
        }
    }
}

// isolated function constructCfindReq(dicom:Dataset identifier, dicom:TransferSyntax transferSyntax,
//         int messageId, int priority, int maxPduLength) returns byte[]|error {
//     do {
//         byte[] cFindReq = [];

//         // Construct command set and dataset
//         byte[] commandSetBytes = check constructCommandSet(messageId, priority);
//         byte[] identifierBytes = check constructIdentifier(identifier, transferSyntax);

//         // Construct command set and dataset PDVs
//         byte[] commandSetPdv = check constructPresentationDataValueItem(commandSetBytes, true, true);
//         byte[] identifierPdv = check constructPresentationDataValueItem(identifierBytes, true, false);

//         // Construct P-DATA PDU
//         // If length exceeds max PDU length of the association, fragment message into two PDUs
//         if commandSetBytes.length() + identifierBytes.length() > maxPduLength {
//             byte[] commandSetPdataPdu = check constructPdataTfPdu(commandSetPdv);
//             byte[] identifierPdataPdu = check constructPdataTfPdu(identifierPdv);
//             cFindReq.push(...commandSetPdataPdu);
//             cFindReq.push(...identifierPdataPdu);
//         } else {
//             byte[] pdvItems = [];
//             pdvItems.push(...commandSetPdv);
//             pdvItems.push(...identifierPdv);
//             cFindReq = check constructPdataTfPdu(pdvItems);
//         }
//         return cFindReq;
//     } on fail error e {
//         return error("Error constructing C-FIND P-DATA-TF PDU", e);
//     }
// }

// isolated function constructIdentifier(dicom:Dataset identifier,
//         dicom:TransferSyntax transferSyntax) returns byte[]|error {
//     do {
//         // TODO: Remove 'validateBeforeEncoding' part when validators support all VRs
//         // Must encode sorted
//         // Transfer syntax of the identifier dataset should be the accepted transfer syntax
//         byte[] datasetBytes = check dicom:toBytes(identifier,
//                 transferSyntax, encodeSorted = true, validateBeforeEncoding = false);

//         return datasetBytes;
//     } on fail error e {
//         return error("Error constructing dataset fragment", e);
//     }
// }

isolated function setAssociationState(Association association, PduType pduType) {
    match pduType {
        A_ASSOCIATE_AC => {
            association.setState(ESTABLISHED);
        }
        A_ASSOCIATE_RJ => {
            association.setState(REJECTED);
        }
        A_RELEASE_RP => {
            association.setState(RELEASED);
        }
        A_ABORT => {
            association.setState(ABORTED);
        }
    }
}

isolated function intToResizedBytes(int n, dicom:ByteOrder byteOrder, int length) returns byte[]|error {
    return dicom:resizeNumericBytes(check dicom:intToBytes(n, byteOrder), byteOrder, length);
}

function getKey(map<anydata> 'map, anydata value) returns string? {
    foreach [string, anydata] ['key, val] in 'map.entries() {
        if (val == value) {
            return 'key;
        }
    }
    return ();
}

public function uidToTransferSyntax(UID uid) returns dicom:TransferSyntax|error {
    // TODO: Validate UID
    foreach TransferSyntaxUid mapping in TRANSFER_SYNTAX_UIDS {
        if (mapping.uid == uid) {
            return mapping.syntax;
        }
    }
    return error(string `Could not find the transfer syntax for UID: ${uid}`);
}

public function TransferSyntaxToUid(dicom:TransferSyntax syntax) returns UID|error {
    foreach TransferSyntaxUid mapping in TRANSFER_SYNTAX_UIDS {
        if (mapping.syntax == syntax) {
            return mapping.uid;
        }
    }
    return error(string `Could not find the UID for transfer syntax: ${syntax}`);
}
