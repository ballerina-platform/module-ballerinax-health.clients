# A-ASSOCIATE primitive.
public type AAssociate record {|
    string? applicationContextName = ();
    string? callingAeTitle = ();
    string? calledAeTitle = ();
    UserInformation? userInformation = ();
    int? result = ();
    int? resultSource = ();
    int? diagnostic = ();
    [string, int]? callingPresentationAddress = ();
    [string, int]? calledPresentationAddress = ();
    PresentationContext[] presentationContextDefinitionList = [];
    PresentationContext[] presentationContextDefinitionResultsList = [];
|};

# Presentation context primitive.
public type PresentationContext record {|
    int contextId;
    UID? abstractSyntax = ();
    UID[] transferSyntax;
    int? result = ();
|};

# User information primitive.
public type UserInformation record {|
    int maximumLength;
    // TODO: Implementation class UID must be mandatory/
    string implementationClassUid?;
|};

# A-ABORT primitive.
public type AAbort record {|
    int 'source;
|};

# A-P-ABORT primitive.
public type APAbort record {|
    int reason;
|};

# A-RELEASE Primitive.
public type ARelease record {|
    string? reason = ();
    string? result = ();
|};

# P-DATA Primitive.
public type PData record {|
    PresentationDataValue[] presentationDataValueList;
|};

public type PresentationDataValue record {|
    int presentationContextId;
    byte[] userData;
|};
