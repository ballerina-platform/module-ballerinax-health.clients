# C-FIND primitive
public type CFind record {|
    int messageId;
    int? messageIdBeingRespondedTo = ();
    UID affectedSopClassUid;
    int priority;
    byte[]? identifier = ();
    int? status = ();
|};
