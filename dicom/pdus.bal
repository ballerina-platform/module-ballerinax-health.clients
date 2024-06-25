# Represents an A-ASSOCIATE-RQ PDU
public type AAssociateRqPdu record {|
    int protocolVersion = 0x01;
    string calledAeTitle;
    string callingAeTitle;
    AAssociateRqVariableItems variableItems;
|};

public type AAssociateAcPdu record {|
    int protocolVersion;
    string calledAeTitleReserved;
    string callingAeTitleReserved;
    AAssociateAcVariableItems variableItems;
|};

public type AAssociateRjPdu record {|
    int result;
    int 'source;
    int reason;
|};

public type AAbortPdu record {|
    int 'source;
    int reason;
|};

public type AReleaseRqPdu record {|
|};

public type AReleaseRpPdu record {|
|};

public type PDataTfPdu record {|
    PresentationDataValueItem[] presentationDataValueItems;
|};

public type PresentationDataValueItem record {|
    int presentationContextId;
    byte[] presentationDataValue;
|};

// Association rq variable items
public type AAssociateRqVariableItems record {|
    ApplicationContextItem applicationContextItem;
    AAssociateRqPresentationContextItem[] presentationContextItems;
    UserInformationItem userInformationItem;
|};

// Association ac variable items
public type AAssociateAcVariableItems record {|
    ApplicationContextItem applicationContextItem;
    AAssociateAcPresentationContextItem[] presentationContextItems;
    UserInformationItem userInformationItem;
|};

public type ApplicationContextItem record {|
    string applicationContextName;
|};

// Association rq presentation context item
public type AAssociateRqPresentationContextItem record {|
    int presentationContextId;
    AbstractTransferSyntaxSubItems abstractTransferSyntaxSubItems;
|};

// Association ac presentation context item
public type AAssociateAcPresentationContextItem record {|
    int presentationContextId;
    int result;
    TransferSyntaxSubItem transferSyntaxSubItem;
|};

public type AbstractTransferSyntaxSubItems record {|
    AbstractSyntaxSubItem abstractSyntaxSubItem;
    TransferSyntaxSubItem[] transferSyntaxSubItems;
|};

public type AbstractSyntaxSubItem record {|
    UID abstractSyntaxName;
|};

public type TransferSyntaxSubItem record {|
    UID transferSyntaxName;
|};

public type UserInformationItem record {|
    UserDataSubItems userData;
|};

// TODO: Add other user-data sub-items
public type UserDataSubItems record {|
    MaximumLengthSubItem maximumLengthSubItem;
|};

public type MaximumLengthSubItem record {|
    int maximumLengthReceived;
|};

