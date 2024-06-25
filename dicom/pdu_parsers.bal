import ballerinax/health.dicom;

isolated function parseAAssociateAcPdu(byte[] pduBodyBytes) returns AAssociateAcPdu|error {
    // Note: Although not required, this function also parses the values of certain reserved fields
    //
    // Based off of Section 9.3.3 in Part 8
    // A-ASSOCIATE-AC PDU:
    // +-------+-------------------+-------------+
    // | Bytes | Field             | Parsed here |
    // +-------+-------------------+-------------+
    // | 1     | PDU-Type          |             |
    // | 2     | Reserved          |             |
    // | 3-6   | PDU-length        |             |
    // | 7-8   | Protocol-version  |      *      |
    // | 9-10  | Reserved          |      *      |
    // | 11-26 | Reserved          |      *      |
    // | 27-42 | Reserved          |      *      |
    // | 43-74 | Reserved          |      *      |
    // | 75-xxx| Variable items    |      *      |
    // +-------+-------------------+-------------+

    // Protocol version
    int protocolVersion = check dicom:bytesToInt(pduBodyBytes.slice(0, 2), dicom:BIG_ENDIAN);

    // Calling AE title reserved
    string calledAeTitleReserved = check string:fromBytes(pduBodyBytes.slice(4, 20));

    // Called AE title reserved
    string callingAeTitleReserved = check string:fromBytes(pduBodyBytes.slice(20, 36));

    // Variable items
    // Starts after 68 reserved bytes
    AAssociateAcVariableItems variableItems = check parseVariableItems(pduBodyBytes.slice(68));

    return {protocolVersion, calledAeTitleReserved, callingAeTitleReserved, variableItems};
}

isolated function parseVariableItems(byte[] variableItemsBytes)
        returns AAssociateAcVariableItems|error {
    // The order of variable items can't be guaranteed, therefore, we have to identify the item type first and 
    // then parse the item accordingly.
    // For all items, the item header:
    // +-------+--------------------------+
    // | Bytes | Field                    |
    // +-------+--------------------------+
    // | 1     | Item-Type                |
    // | 2     | Reserved                 |
    // | 3-4   | Item-length              |
    // +-------+--------------------------+

    // Variable items
    ApplicationContextItem? applicationContextItem = ();
    AAssociateAcPresentationContextItem[] presentationContextItems = [];
    UserInformationItem? userInformationItem = ();

    // Position pointer
    int pos = 0;

    while true {
        byte[]|error itemHeader = trap variableItemsBytes.slice(pos, 4 + pos);

        // End of variable items
        if itemHeader is error {
            // All three must be present in a valid PDU
            // One Application Context Item, one or more Presentation Context Item(s) and one User Information Item
            if applicationContextItem == () || presentationContextItems.length() == 0 || userInformationItem == () {
                return error("Invalid variable items data");
            }
            return {applicationContextItem, presentationContextItems, userInformationItem};
        }

        // Item type
        byte itemTypeByte = itemHeader[0];

        // Item length
        int itemLength = check dicom:bytesToInt(itemHeader.slice(2), dicom:BIG_ENDIAN);

        // Item body
        byte[] itemBodyBytes = variableItemsBytes.slice(pos + itemHeader.length(),
                pos + itemHeader.length() + itemLength);

        match itemTypeByte {
            APPLICATION_CONTEXT_ITEM_TYPE => {
                applicationContextItem = check parseApplicationContextItem(itemBodyBytes);
            }
            AASSOCIATE_AC_PRESENTATION_CONTEXT_ITEM_TYPE => {
                presentationContextItems.push(check parseAAssociateAcPresentationContextItem(itemBodyBytes));
            }
            USER_INFORMATION_ITEM_TYPE => {
                userInformationItem = check parseUserInformationItem(itemBodyBytes);
            }
            _ => {
                // Items of unrecognized types shall be ignored and skipped
            }
        }

        // Update the position pointer
        pos += (itemHeader.length() + itemLength);
    }
}

isolated function parseApplicationContextItem(byte[] itemBodyBytes)
        returns ApplicationContextItem|error {
    // Based off of Section 9.3.2.1 in Part 8
    // Application context item:
    // +-------+--------------------------+-------------+
    // | Bytes | Field                    | Parsed here |
    // +-------+--------------------------+-------------+
    // | 1     | Item-Type                |             |
    // | 2     | Reserved                 |             |
    // | 3-4   | Item-length              |             |
    // | 5-xxx | Application-context-name |      *      |
    // +-------+--------------------------+-------------+

    string applicationContextName = check string:fromBytes(itemBodyBytes);

    return {applicationContextName};
}

isolated function parseAAssociateAcPresentationContextItem(byte[] itemBodyBytes)
        returns AAssociateAcPresentationContextItem|error {
    // Based off of Section 9.3.3.2 in Part 8
    // Presentation context item:
    // +-------+---------------------------+-------------+
    // | Bytes | Field                     | Parsed here |
    // +-------+---------------------------+-------------+
    // | 1     | Item-Type                 |             |
    // | 2     | Reserved                  |             |
    // | 3-4   | Item-length               |             |
    // | 5     | Presentation-context-ID   |      *      |
    // | 6     | Reserved                  |      *      |
    // | 7     | Result/Reason             |      *      |
    // | 8     | Reserved                  |      *      |
    // | 9-xxx | Transfer syntax sub-item  |      *      |
    // +-------+---------------------------+-------------+

    // Presentation context id
    byte presentationContextIdByte = itemBodyBytes[0];

    int presentationContextId = check dicom:bytesToInt([presentationContextIdByte], dicom:BIG_ENDIAN);

    // Result/reason
    byte resultByte = itemBodyBytes[2];
    int result = check dicom:bytesToInt([resultByte], dicom:BIG_ENDIAN);

    // Transfer syntax sub-item
    // TODO: When the Result/Reason field has a value other than acceptance (0), this field shall not be significant
    TransferSyntaxSubItem transferSyntaxSubItem = check parseTransferSyntaxSubItem(itemBodyBytes.slice(4));

    return {presentationContextId, result, transferSyntaxSubItem};
}

isolated function parseTransferSyntaxSubItem(byte[] subItemBytes)
        returns TransferSyntaxSubItem|error {
    // Based off of Section 9.3.3.2.1 in Part 8
    // Transfer syntax sub-item:
    // +-------+---------------------------+
    // | Bytes | Field                     |
    // +-------+---------------------------+
    // | 1     | Item-Type                 |
    // | 2     | Reserved                  |
    // | 3-4   | Item-length               |
    // | 5-xxx | Transfer-syntax-name      |
    // +-------+---------------------------+

    // Item type
    if subItemBytes[0] != TRANSFER_SYNTAX_SUB_ITEM_TYPE {
        return error("Invalid transfer syntax sub-item");
    }

    // Item length
    int itemLength = check dicom:bytesToInt(subItemBytes.slice(2, 4), dicom:BIG_ENDIAN);

    // Transfer syntax name
    string transferSyntaxName = check string:fromBytes(subItemBytes.slice(4, 4 + itemLength));

    return {transferSyntaxName};
}

isolated function parseUserInformationItem(byte[] itemBodyBytes)
        returns UserInformationItem|error {
    // Based off of Section 9.3.3.3 in Part 8
    // Item fields:
    // +-------+---------------------------+-------------+
    // | Bytes | Field                     | Parsed here |
    // +-------+---------------------------+-------------+
    // | 1     | Item-Type                 |             |
    // | 2     | Reserved                  |             |
    // | 3-4   | Item-length               |             |
    // | 5     | User-data                 |      *      |
    // +-------+---------------------------+-------------+

    UserDataSubItems userData = check parseUserDataSubItems(itemBodyBytes);

    return {userData};
}

isolated function parseUserDataSubItems(byte[] userDataSubItemsBytes) returns UserDataSubItems|error {
    // For all user data sub-items:
    // +-------+--------------------------+
    // | Bytes | Field                    |
    // +-------+--------------------------+
    // | 1     | Item-Type                |
    // | 2     | Reserved                 |
    // | 3-4   | Item-length              |
    // +-------+--------------------------+

    MaximumLengthSubItem? maximumLengthSubItem = ();

    // Position pointer
    int pos = 0;

    while true {
        byte[]|error itemHeader = trap userDataSubItemsBytes.slice(pos, 4 + pos);

        // End of variable items
        if itemHeader is error {
            // Maximum length sub-item is required
            if maximumLengthSubItem == () {
                return error("Missing maximum length item in user data sub-items");
            }
            return {maximumLengthSubItem};
        }

        // Sub-item type
        byte subItemTypeByte = itemHeader[0];

        // Sub-item length
        int subItemLength = check dicom:bytesToInt(itemHeader.slice(2), dicom:BIG_ENDIAN);

        // Sub-item body
        byte[] subItemBodyBytes = userDataSubItemsBytes.slice(pos + itemHeader.length(),
                pos + itemHeader.length() + subItemLength);

        match subItemTypeByte {
            MAXIMUM_LENGTH_ITEM_TYPE => {
                maximumLengthSubItem = check parseMaximumLengthSubItem(subItemBodyBytes);
            }
            _ => {
                // Skip any other sub items as they are not supported yet
            }
        }

        pos += (itemHeader.length() + subItemLength);
    }
}

isolated function parseMaximumLengthSubItem(byte[] subItemBodyBytes)
            returns MaximumLengthSubItem|error {
    // Based off of Section D.1.2 in Part 8
    // Item fields:
    // +-------+---------------------------+-------------+
    // | Bytes | Field                     | Parsed here |
    // +-------+---------------------------+-------------+
    // | 1     | Item-Type                 |             |
    // | 2     | Reserved                  |             |
    // | 3-4   | Item-length               |             |
    // | 5-8   | Maximum-length-received   |      *      |
    // +-------+---------------------------+-------------+

    int maximumLengthReceived = check dicom:bytesToInt(subItemBodyBytes, dicom:BIG_ENDIAN);

    return {maximumLengthReceived};
}

isolated function parseAAssociateRjPdu(byte[] pduBodyBytes) returns AAssociateRjPdu|error {
    // Based off of Section 9.3.4 in Part 8
    // A-ASSOCIATE-RJ PDU:
    // +-------+-------------------+-------------+
    // | Bytes | Field             | Parsed here |
    // +-------+-------------------+-------------+
    // | 1     | PDU-Type          |             |
    // | 2     | Reserved          |             |
    // | 3-6   | PDU-length        |             |
    // | 7     | Reserved          |      *      |
    // | 8     | Result            |      *      |
    // | 9     | Source            |      *      |
    // | 10    | Reason/Diag.      |      *      |
    // +-------+-------------------+-------------+

    // Result
    int result = check dicom:bytesToInt([pduBodyBytes[1]], dicom:BIG_ENDIAN);

    // Source
    int 'source = check dicom:bytesToInt([pduBodyBytes[2]], dicom:BIG_ENDIAN);

    // Reason/Diag.
    int reason = check dicom:bytesToInt([pduBodyBytes[3]], dicom:BIG_ENDIAN);

    return {result, 'source, reason};
}

isolated function parseAReleaseRpPdu(byte[] pduBodyBytes) returns AReleaseRpPdu|error {
    // Parsing is not necessary as A-RELEASE-RS-PDU doesn't contain a meaningful body
    return {};
}

isolated function parsePDataTfPdu(byte[] pduBodyBytes) returns PDataTfPdu|error {
    // A P-DATA-TF PDU can contain multiple PDV items
    // For all PDV items:
    // +-------+--------------------------+
    // | Bytes | Field                    |
    // +-------+--------------------------+
    // | 1-4     | Item-length            |
    // +-------+--------------------------+

    PresentationDataValueItem[] presentationDataValueItems = [];
    int pos = 0;

    while pos < pduBodyBytes.length() {
        // PDV item length
        byte[] itemLengthBytes = pduBodyBytes.slice(0, 4);
        int itemLength = check dicom:bytesToInt(itemLengthBytes, dicom:BIG_ENDIAN);

        // PDV item body bytes
        byte[] itemBodyBytes = pduBodyBytes.slice(4, itemLength);

        // PDV item
        PresentationDataValueItem presentationDataValueItem = check parsePresentationDataValueItem(itemBodyBytes);
        presentationDataValueItems.push(presentationDataValueItem);

        pos += (4 + itemLength);
    }

    return {presentationDataValueItems};
}

isolated function parsePresentationDataValueItem(byte[] itemBodyBytes) returns PresentationDataValueItem|error {
    // Based off of Section 9.3.5.1 in Part 8
    // Presentation data value item:
    // +-------+--------------------------+-------------+
    // | Bytes | Field                    | Parsed here |
    // +-------+--------------------------+-------------+
    // | 1-4   | Item-length              |             |
    // | 5     | Presentation-context-ID  |      *      |
    // | 6-xxx | Presentation-data-value  |      *      |
    // +-------+--------------------------+-------------+

    // Presentation context ID
    byte presentationContextIdByte = itemBodyBytes[0];
    int presentationContextId = check dicom:bytesToInt([presentationContextIdByte], dicom:BIG_ENDIAN);

    // PDV
    byte[] presentationDataValue = itemBodyBytes.slice(1);

    return {presentationContextId, presentationDataValue};
}
