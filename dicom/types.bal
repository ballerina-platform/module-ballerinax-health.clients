import ballerina/tcp;
import ballerina/constraint;
import ballerinax/health.dicom;

# Represents a DICOM UID.
@constraint:String {
    pattern: re `^[0-9.]+$`,
    minLength: 1,
    maxLength: 64
}
public type UID string;

public type TransferSyntaxUid record {
    UID uid;
    dicom:TransferSyntax syntax;
};

public type ClientConfig record {|
    string peer;
    int port;
    string callingAeTitle?;
    string calledAeTitle?;
    tcp:ClientConfiguration? socketConfig = ();
|};

public enum ServiceUserMode {
    REQUESTOR,
    ACCEPTOR
}

# Represents a DICOM message identifier.
public type Identifier record {};

// TODO: Add missing DIMSE primitives
public type DimsePrimitive CFind;

// TODO: Add missing primitives
public type Primitive AAssociate|AAbort|APAbort|ARelease|PData|DimsePrimitive;

// TODO: Add missing PDUs
public type Pdu AAssociateRqPdu|AAssociateAcPdu|AAssociateRjPdu|AAbortPdu|AReleaseRqPdu|PDataTfPdu;
