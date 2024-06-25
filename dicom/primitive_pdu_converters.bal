public isolated function primitiveToPdu(Primitive primitive) returns Pdu|error {
    // Construct PDU according to primitive type
    if primitive is AAssociate {
        return createAAssociatePdu(primitive);
    } else if primitive is AAbort {
        return createAAbortPdu(primitive);
    } else if primitive is APAbort {
        return createAPAbortPdu(primitive);
    } else if primitive is ARelease {
        return createAReleasePdu(primitive);
    } else if primitive is PData {
        return createPDataTfPdu(primitive);
    } else {
        return error("Unsupported primitive");
    }
}

isolated function createAAssociatePdu(AAssociate primitive) returns AAssociateRqPdu|error {
    string? calledAeTitle = primitive.calledAeTitle;
    if calledAeTitle == () {
        return error("Called AE title can't be nil");
    }

    string? callingAeTitle = primitive.callingAeTitle;
    if callingAeTitle == () {
        return error("Calling AE title can't be nil");
    }

    // Application context item
    ApplicationContextItem applicationContextItem =
                                            check createApplicationContextItem(primitive.applicationContextName);

    // Presentation context items
    AAssociateRqPresentationContextItem[] presentationContextItems = [];
    foreach PresentationContext presentationContextPrimitive in primitive.presentationContextDefinitionList {
        AAssociateRqPresentationContextItem|error presentationContextItem =
                                                        createPresentationContextItem(presentationContextPrimitive);
        if presentationContextItem is AAssociateRqPresentationContextItem {
            presentationContextItems.push(presentationContextItem);
        }
    }

    // User information item
    UserInformationItem userInformationItem =
                                            check createAssociationRqUserInformationItem(primitive.userInformation);

    return {
        calledAeTitle: calledAeTitle,
        callingAeTitle: callingAeTitle,
        variableItems: {
            applicationContextItem,
            presentationContextItems,
            userInformationItem
        }
    };
}

isolated function createAAbortPdu(AAbort primitive) returns AAbortPdu {
    return {
        'source: primitive.'source,
        reason: 0 // Reason is 0 for DICOM UL service-user initiated abort
    };
}

isolated function createAPAbortPdu(APAbort primitive) returns AAbortPdu {
    return {
        'source: 2, // Source is 2 for DICOM UL service-provider initiated abort
        reason: primitive.reason
    };
}

isolated function createAReleasePdu(ARelease primitive) returns AReleaseRqPdu {
    return {};
}

isolated function createPDataTfPdu(PData primitive) returns PDataTfPdu {
    PresentationDataValueItem[] presentationDataValueItems = [];

    foreach PresentationDataValue pdv in primitive.presentationDataValueList {
        PresentationDataValueItem presentationDataValueItem = {
            presentationContextId: pdv.presentationContextId,
            presentationDataValue: pdv.userData
        };
        presentationDataValueItems.push(presentationDataValueItem);
    }

    return {presentationDataValueItems};    
}

public isolated function pduToPrimitive(Pdu pdu) returns Primitive|error {
    // TODO: Add other pdu types
    if pdu is AAssociateAcPdu {
        return aAssociateAcToPrimitive(pdu);
    } else if pdu is AAssociateRjPdu {
        return aAssociateRjToPrimitive(pdu);
    } else if pdu is AReleaseRpPdu {
        return aReleaseRpToPrimitive(pdu);
    }
    return error("Unsupported PDU");
}

isolated function aAssociateAcToPrimitive(AAssociateAcPdu aAssociateAcPdu) returns AAssociate|error {
    AAssociate aAssociatePrimitive = {
        applicationContextName: aAssociateAcPdu.variableItems.applicationContextItem.applicationContextName,
        calledAeTitle: aAssociateAcPdu.calledAeTitleReserved,
        callingAeTitle: aAssociateAcPdu.callingAeTitleReserved,
        userInformation: {
            maximumLength: aAssociateAcPdu.variableItems.userInformationItem.userData.maximumLengthSubItem.maximumLengthReceived
        },
        result: 0x00, // Accepted
        resultSource: 0x01 // DICOM UL service-user
    };

    aAssociatePrimitive.presentationContextDefinitionResultsList =
            check createPresentationContextList(aAssociateAcPdu.variableItems.presentationContextItems);

    return aAssociatePrimitive;
}

isolated function aAssociateRjToPrimitive(AAssociateRjPdu aAssociateRjPdu) returns AAssociate => {
    result: aAssociateRjPdu.result,
    resultSource: aAssociateRjPdu.'source,
    diagnostic: aAssociateRjPdu.reason
};

isolated function aReleaseRpToPrimitive(AReleaseRpPdu aReleaseRpPdu) returns ARelease => {

};

isolated function createPresentationContextList(AAssociateAcPresentationContextItem[] items)
        returns PresentationContext[]|error {
    PresentationContext[] presentationContextDefinitionResultsList = [];
    foreach AAssociateAcPresentationContextItem item in items {
        PresentationContext presentationContext = {
            contextId: item.presentationContextId,
            transferSyntax: [item.transferSyntaxSubItem.transferSyntaxName],
            result: item.result
        };
        presentationContextDefinitionResultsList.push(presentationContext);
    }
    return presentationContextDefinitionResultsList;
}

isolated function createApplicationContextItem(string? applicationContextName) returns ApplicationContextItem|error {
    if applicationContextName == () {
        return error("Application context name can't be nil");
    }
    return {applicationContextName};
}

isolated function createPresentationContextItem(PresentationContext presentationContext)
        returns AAssociateRqPresentationContextItem|error {
    UID? abstractSyntax = presentationContext.abstractSyntax;
    if abstractSyntax == () {
        return error("Must have an abstract context");
    }

    // Abstract syntax sub item
    AbstractSyntaxSubItem abstractSyntaxSubItem = {
        abstractSyntaxName: abstractSyntax
    };

    // Transfer syntax sub item
    TransferSyntaxSubItem[] transferSyntaxSubItems = [];
    foreach string transferSyntax in presentationContext.transferSyntax {
        TransferSyntaxSubItem transferSyntaxSubItem = {transferSyntaxName: transferSyntax};
        transferSyntaxSubItems.push(transferSyntaxSubItem);
    }

    return {
        presentationContextId: presentationContext.contextId,
        abstractTransferSyntaxSubItems: {abstractSyntaxSubItem, transferSyntaxSubItems}
    };
}

isolated function createAssociationRqUserInformationItem(UserInformation? userInformation)
        returns UserInformationItem|error {
    if userInformation == () {
        return error("User information can't be nil");
    }

    // Maximum length sub item
    MaximumLengthSubItem maximumLengthReceivedSubItem = {maximumLengthReceived: userInformation.maximumLength};

    // User data sub-items
    UserDataSubItems userDataSubItems = {
        maximumLengthSubItem: maximumLengthReceivedSubItem
    };

    // TODO: Implementation class UID

    return {userData: userDataSubItems};
}
