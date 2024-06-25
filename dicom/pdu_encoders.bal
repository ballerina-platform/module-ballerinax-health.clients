import ballerinax/health.dicom;

// DICOM Upper Layer (DUL) Protocol Data Unit (PDU) encoders
// A-ASSOCIATE-RQ PDU
public isolated function encodeAAssociateRqPdu(AAssociateRqPdu aAssociateRqPdu) returns byte[] & readonly|error {
    // Associate request PDU encoding logic is based off of Section 9.3.2 in Part 8
    // A-ASSOCIATE-RQ PDU Fields:
    // +-------+-------------------+
    // | Bytes | Field             |
    // +-------+-------------------+
    // | 1     | PDU-Type          |
    // | 2     | Reserved          |
    // | 3-6   | PDU-length        |
    // | 7-8   | Protocol-version  |
    // | 9-10  | Reserved          |
    // | 11-26 | Called-AE-title   |
    // | 27-42 | Calling-AE-title  |
    // | 43-74 | Reserved          |
    // | 75-xxx| Variable items    |
    // +-------+-------------------+
    byte[] aAssociateRqPduBytes = [];

    // PDU type
    byte pduType = UL_PDU_TYPES.get(A_ASSOCIATE_RQ);

    // Reserved byte
    byte[] reservedByte = createReservedBytes(1);

    // Protocol version
    byte[] protocolVersionBytes = check intToResizedBytes(aAssociateRqPdu.protocolVersion, dicom:BIG_ENDIAN, 2);

    // Reserved 2 bytes
    byte[] reserved2Bytes = createReservedBytes(2);

    // Called AE title
    byte[] calledAeTitleBytes = constructAeTitle(aAssociateRqPdu.calledAeTitle);

    // Calling AE title
    byte[] callingAeTitleBytes = constructAeTitle(aAssociateRqPdu.callingAeTitle);

    // Reserved 32 bytes
    byte[] reserved32Bytes = createReservedBytes(32);

    // Variable items
    byte[] variableItemsBytes = check encodeVariableItems(aAssociateRqPdu.variableItems);

    // PDU length
    int pduLength = protocolVersionBytes.length() + reserved2Bytes.length() + calledAeTitleBytes.length()
        + callingAeTitleBytes.length() + reserved32Bytes.length() + variableItemsBytes.length();

    byte[] pduLengthBytes = check intToResizedBytes(pduLength, dicom:BIG_ENDIAN, 4);

    aAssociateRqPduBytes.push(pduType);
    aAssociateRqPduBytes.push(...reservedByte);
    aAssociateRqPduBytes.push(...pduLengthBytes);
    aAssociateRqPduBytes.push(...protocolVersionBytes);
    aAssociateRqPduBytes.push(...reserved2Bytes);
    aAssociateRqPduBytes.push(...calledAeTitleBytes);
    aAssociateRqPduBytes.push(...callingAeTitleBytes);
    aAssociateRqPduBytes.push(...reserved32Bytes);
    aAssociateRqPduBytes.push(...variableItemsBytes);

    return aAssociateRqPduBytes.cloneReadOnly();
}

isolated function encodeVariableItems(AAssociateRqVariableItems variableItems) returns byte[]|error {
    byte[] variableItemsBytes = [];

    // Application context item
    byte[] applicationContextItemBytes = check encodeApplicationContextItem(variableItems.applicationContextItem);
    variableItemsBytes.push(...applicationContextItemBytes);

    // Presentation context items
    foreach AAssociateRqPresentationContextItem presentationContextItem in variableItems.presentationContextItems {
        byte[] presentationContextItemBytes = check encodePresentationContextItem(presentationContextItem);
        variableItemsBytes.push(...presentationContextItemBytes);
    }

    // User info item
    byte[] userInformationItemBytes = check encodeUserInformationItem(variableItems.userInformationItem);
    variableItemsBytes.push(...userInformationItemBytes);

    return variableItemsBytes;
}

isolated function encodeApplicationContextItem(ApplicationContextItem applicationContextItem) returns byte[]|error {
    // Application Context Item encoding logic is based off of Section 9.3.2.1 in Part 8
    // Application context item fields:
    // +-------+--------------------------+
    // | Bytes | Field                    |
    // +-------+--------------------------+
    // | 1     | Item-Type                |
    // | 2     | Reserved                 |
    // | 3-4   | Item-length              |
    // | 5-xxx | Application-context-name |
    // +-------+--------------------------+
    byte[] applicationContextItemBytes = [];

    // Item type
    byte itemTypeByte = APPLICATION_CONTEXT_ITEM_TYPE;

    // Reserved byte
    byte[] reservedByte = createReservedBytes(1);

    // Application context name
    byte[] applicationContextNameBytes = applicationContextItem.applicationContextName.toBytes();

    // Item length
    byte[] applicationContextNameLengthBytes = check intToResizedBytes(applicationContextNameBytes.length(),
            dicom:BIG_ENDIAN, 2);

    applicationContextItemBytes.push(itemTypeByte);
    applicationContextItemBytes.push(...reservedByte);
    applicationContextItemBytes.push(...applicationContextNameLengthBytes);
    applicationContextItemBytes.push(...applicationContextNameBytes);

    return applicationContextItemBytes;
}

isolated function encodePresentationContextItem(AAssociateRqPresentationContextItem presentationContextItem) returns byte[]|error {
    // Presentation Context Item encoding logic is based off of Section 9.3.2.2 in Part 8
    // Presentation context item fields:
    // +-------+------------------------------------+
    // | Bytes | Field                              |
    // +-------+------------------------------------+
    // | 1     | Item-Type                          |
    // | 2     | Reserved                           |
    // | 3-4   | Item-length                        |
    // | 5     | Presentation-context-ID            |
    // | 6     | Reserved                           |
    // | 7     | Reserved                           |
    // | 8     | Reserved                           |
    // | 9-xxx | Abstract/Transfer Syntax Sub-Items |
    // +-------+------------------------------------+
    byte[] presentationContextItemBytes = [];

    // Item type
    byte itemTypeBytes = AASSOCIATE_RQ_PRESENTATION_CONTEXT_ITEM_TYPE;

    // Reserved byte
    byte[] reservedByte = createReservedBytes(1);

    // Presentation context ID
    byte[] presentationContextId = check intToResizedBytes(presentationContextItem.presentationContextId,
            dicom:LITTLE_ENDIAN, 1);

    // Reserved 3 bytes
    byte[] reserved3Bytes = createReservedBytes(3);

    // Abstract/Transfer Syntax sub items
    byte[] abstractAndTransferSyntaxSubItems =
            check encodeAbstractTransferSyntaxSubItems(presentationContextItem.abstractTransferSyntaxSubItems);

    // Item length
    int itemLength = presentationContextId.length() + reserved3Bytes.length()
            + abstractAndTransferSyntaxSubItems.length();

    byte[] itemLengthBytes = check intToResizedBytes(itemLength, dicom:BIG_ENDIAN, 2);

    presentationContextItemBytes.push(itemTypeBytes);
    presentationContextItemBytes.push(...reservedByte);
    presentationContextItemBytes.push(...itemLengthBytes);
    presentationContextItemBytes.push(...presentationContextId);
    presentationContextItemBytes.push(...reserved3Bytes);
    presentationContextItemBytes.push(...abstractAndTransferSyntaxSubItems);

    return presentationContextItemBytes;
}

isolated function encodeAbstractTransferSyntaxSubItems(AbstractTransferSyntaxSubItems abstractTransferSyntaxSubItems)
        returns byte[]|error {
    byte[] abstractTransferSyntaxSubItemsBytes = [];

    // Abstract syntax sub item 
    byte[] abstractSyntaxSubItemBytes =
                            check encodeAbstractSyntaxSubItem(abstractTransferSyntaxSubItems.abstractSyntaxSubItem);
    abstractTransferSyntaxSubItemsBytes.push(...abstractSyntaxSubItemBytes);

    // Transfer syntax sub items
    byte[] transferSyntaxSubItemsBytes = [];
    foreach TransferSyntaxSubItem transferSyntaxSubItem in abstractTransferSyntaxSubItems.transferSyntaxSubItems {
        byte[] transferSyntaxSubItemBytes = check encodeTransferSyntaxSubItem(transferSyntaxSubItem);
        transferSyntaxSubItemsBytes.push(...transferSyntaxSubItemBytes);
    }
    abstractTransferSyntaxSubItemsBytes.push(...transferSyntaxSubItemsBytes);

    return abstractTransferSyntaxSubItemsBytes;
}

isolated function encodeAbstractSyntaxSubItem(AbstractSyntaxSubItem abstractSyntaxSubItem) returns byte[]|error {
    // Abstract syntax subitem construction logic is based off of Section 9.3.2.2.1 in Part 8
    // Abstract syntax sub-item fields:
    // +-------+------------------------------------+
    // | Bytes | Field                              |
    // +-------+------------------------------------+
    // | 1     | Item-Type                          |
    // | 2     | Reserved                           |
    // | 3-4   | Item-length                        |
    // | 5-xxx | Abstract-syntax-name               |
    // +-------+------------------------------------+
    byte[] abstractSyntaxSubItemBytes = [];

    // Item type
    byte itemTypeByte = ABSTRACT_SYNTAX_SUB_ITEM_TYPE;

    // Reserved byte
    byte[] reservedByte = createReservedBytes(1);

    // Abstract syntax name
    byte[] abstractSyntaxName = abstractSyntaxSubItem.abstractSyntaxName.toBytes();

    // Item length
    byte[] itemLengthBytes = check intToResizedBytes(abstractSyntaxName.length(), dicom:BIG_ENDIAN, 2);

    abstractSyntaxSubItemBytes.push(itemTypeByte);
    abstractSyntaxSubItemBytes.push(...reservedByte);
    abstractSyntaxSubItemBytes.push(...itemLengthBytes);
    abstractSyntaxSubItemBytes.push(...abstractSyntaxName);

    return abstractSyntaxSubItemBytes;
}

isolated function encodeTransferSyntaxSubItem(TransferSyntaxSubItem transferSyntaxSubItem) returns byte[]|error {
    // Transfer syntax subitem construction logic is based off of Section 9.3.2.2.2 in Part 8
    // Transfer syntax sub-item fields:
    // +-------+------------------------------------+
    // | Bytes | Field                              |
    // +-------+------------------------------------+
    // | 1     | Item-Type                          |
    // | 2     | Reserved                           |
    // | 3-4   | Item-length                        |
    // | 5-xxx | Transfer-syntax-name(s)            |
    // +-------+------------------------------------+
    byte[] transferSyntaxSubItemBytes = [];

    // Item type
    byte itemTypeByte = TRANSFER_SYNTAX_SUB_ITEM_TYPE;

    // Reserved byte
    byte[] reservedByte = createReservedBytes(1);

    // Transfer syntax
    byte[] transferSyntaxBytes = transferSyntaxSubItem.transferSyntaxName.toBytes();

    // Item length
    byte[] itemLengthBytes = check intToResizedBytes(transferSyntaxBytes.length(), dicom:BIG_ENDIAN, 2);

    transferSyntaxSubItemBytes.push(itemTypeByte);
    transferSyntaxSubItemBytes.push(...reservedByte);
    transferSyntaxSubItemBytes.push(...itemLengthBytes);
    transferSyntaxSubItemBytes.push(...transferSyntaxBytes);

    return transferSyntaxSubItemBytes;
}

isolated function encodeUserInformationItem(UserInformationItem userInformationItem) returns byte[]|error {
    // User information item construction logic is based off of Section 9.3.2.3 in Part 8
    // User information item fields:
    // +-------+------------------------------------+
    // | Bytes | Field                              |
    // +-------+------------------------------------+
    // | 1     | Item-Type                          |
    // | 2     | Reserved                           |
    // | 3-4   | Item-length                        |
    // | 5-xxx | User-data                          |
    // +-------+------------------------------------+
    byte[] userInformationItemBytes = [];

    // Item type
    byte itemTypeByte = USER_INFORMATION_ITEM_TYPE;

    // Reserved byte
    byte[] reservedByte = createReservedBytes(1);

    // User data
    byte[] userDataBytes = check encodeUserData(userInformationItem.userData);

    // Item length
    byte[] itemLengthBytes = check intToResizedBytes(userDataBytes.length(), dicom:BIG_ENDIAN, 2);

    userInformationItemBytes.push(itemTypeByte);
    userInformationItemBytes.push(...reservedByte);
    userInformationItemBytes.push(...itemLengthBytes);
    userInformationItemBytes.push(...userDataBytes);

    return userInformationItemBytes;
}

// TODO: Add other user data encoding support
isolated function encodeUserData(UserDataSubItems userDataSubItems) returns byte[]|error {
    byte[] userDataBytes = [];

    // Maximum length sub item
    MaximumLengthSubItem maximumLengthSubItem = userDataSubItems.maximumLengthSubItem;
    byte[] maximumLengthSubItemBytes = check encodeMaximumLengthSubItem(maximumLengthSubItem);
    userDataBytes.push(...maximumLengthSubItemBytes);

    return userDataBytes;
}

isolated function encodeMaximumLengthSubItem(MaximumLengthSubItem maximumLengthSubItem)
        returns byte[]|error {
    // Maximum length sub item construction logic is based off of Section D.1.1 in Part 8
    // Maximum length sub item fields:
    // +-------+------------------------------------+
    // | Bytes | Field                              |
    // +-------+------------------------------------+
    // | 1     | Item-Type                          |
    // | 2     | Reserved                           |
    // | 3-4   | Item-length                        |
    // | 5-8   | Maximum-length-received            |
    // +-------+------------------------------------+
    byte[] maximumLengthSubItemBytes = [];

    // Item type
    byte itemTypeByte = MAXIMUM_LENGTH_ITEM_TYPE;

    // Reserved byte
    byte[] reservedByte = createReservedBytes(1);

    // Maximum length received
    byte[] maximumLengthReceivedBytes = check intToResizedBytes(maximumLengthSubItem.maximumLengthReceived,
            dicom:BIG_ENDIAN, 4);

    // Item length
    byte[] itemLengthBytes = check intToResizedBytes(maximumLengthReceivedBytes.length(), dicom:BIG_ENDIAN, 2);

    maximumLengthSubItemBytes.push(itemTypeByte);
    maximumLengthSubItemBytes.push(...reservedByte);
    maximumLengthSubItemBytes.push(...itemLengthBytes);
    maximumLengthSubItemBytes.push(...maximumLengthReceivedBytes);

    return maximumLengthSubItemBytes;
}

// A-RELEASE-RQ PDU
public isolated function encodeAReleaseRqPdu(AReleaseRqPdu pdu) returns byte[] & readonly|error {
    // Based off of Section 9.3.6 in Part 8
    // A-RELEASE-RQ PDU fields:
    // +-------+------------------------------------+
    // | Bytes | Field                              |
    // +-------+------------------------------------+
    // | 1     | PDU-type                           |
    // | 2     | Reserved                           |
    // | 3-6   | PDU-length                         |
    // | 7-10  | Reserved                           |
    // +-------+------------------------------------+
    byte[] releaseRequestPdu = [];

    // PDU type
    byte pduType = UL_PDU_TYPES.get(A_RELEASE_RQ);

    // Reserved byte
    byte[] reservedByte = createReservedBytes(1);

    // PDU length - fixed value of 00000004H
    byte[] pduLength = [0x00, 0x00, 0x00, 0x04];

    // Reserved 4 bytes
    byte[] reserved4Bytes = createReservedBytes(4);

    releaseRequestPdu.push(pduType);
    releaseRequestPdu.push(...reservedByte);
    releaseRequestPdu.push(...pduLength);
    releaseRequestPdu.push(...reserved4Bytes);

    return releaseRequestPdu.cloneReadOnly();
}

// A-ABORT-RQ PDU
public isolated function encodeAAbortPdu(AAbortPdu pdu) returns byte[] & readonly|error {
    byte[] abortRequestPdu = [];

    // PDU type
    byte pduType = UL_PDU_TYPES.get(A_ABORT);

    // Reserved byte
    byte[] reservedByte = createReservedBytes(1);

    // PDU length - fixed value of 00000004H
    byte[] pduLength = [0x00, 0x00, 0x00, 0x04];

    // Reserved byte
    byte[] reservedByte2 = reservedByte;

    // Reserved byte
    byte[] reservedByte3 = reservedByte;

    // Source
    byte[] 'source = check intToResizedBytes(pdu.'source, dicom:BIG_ENDIAN, 1);

    // Reason
    byte[] reason = check intToResizedBytes(pdu.reason, dicom:BIG_ENDIAN, 1);

    abortRequestPdu.push(pduType);
    abortRequestPdu.push(...reservedByte);
    abortRequestPdu.push(...pduLength);
    abortRequestPdu.push(...reservedByte2);
    abortRequestPdu.push(...reservedByte3);
    abortRequestPdu.push(...'source);
    abortRequestPdu.push(...reason);

    return abortRequestPdu.cloneReadOnly();
}

// P-DATA-TF PDU
public isolated function encodePdataTfPdu(PDataTfPdu pdu) returns byte[] & readonly|error {
    // P-DATA PDU construction logic is based off of Section 9.3.5 in Part 8
    byte[] pdataPdu = [];

    // PDU type
    byte pduType = UL_PDU_TYPES.get(P_DATA_TF);

    // Reserved byte
    byte[] reservedByte = createReservedBytes(1);

    // Presentation data value item(s)
    byte[] pdvItems = [];
    foreach PresentationDataValueItem pdvItem in pdu.presentationDataValueItems {
        byte[] pdvItemBytes = check encodePresentationDataValueItem(pdvItem);
        pdvItems.push(...pdvItemBytes);
    }

    // PDU length
    byte[] pduLengthBytes = check intToResizedBytes(pdvItems.length(), dicom:BIG_ENDIAN, 4);

    pdataPdu.push(pduType);
    pdataPdu.push(...reservedByte);
    pdataPdu.push(...pduLengthBytes);
    pdataPdu.push(...pdvItems);

    return pdataPdu.cloneReadOnly();
}

isolated function encodePresentationDataValueItem(PresentationDataValueItem presentationDataValueItem)
        returns byte[]|error {
    // Presentation data value item construction logic is based off of Section 9.3.5.1 in Part 8
    byte[] presentationDataValueItemBytes = [];

    byte[] presentationContextId = check intToResizedBytes(presentationDataValueItem.presentationContextId,
            dicom:BIG_ENDIAN, 1);

    // Presentation data value
    byte[] presentationDataValue = presentationDataValueItem.presentationDataValue;

    // Item length
    int itemLength = presentationContextId.length() + presentationDataValue.length();
    byte[] itemLengthBytes = check intToResizedBytes(itemLength, dicom:BIG_ENDIAN, 4);

    presentationDataValueItemBytes.push(...itemLengthBytes);
    presentationDataValueItemBytes.push(...presentationContextId);
    presentationDataValueItemBytes.push(...presentationDataValue);

    return presentationDataValueItemBytes;
}
