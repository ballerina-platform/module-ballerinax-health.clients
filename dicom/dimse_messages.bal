import ballerinax/health.dicom;

public type DimseMessage record {|
    int? contextId = (); // Context id of the presentation context the message belongs to
    dicom:Dataset commandSet;
    byte[]? dataset = ();
|};

public type CFindRq record {|
    *DimseMessage;
|};
