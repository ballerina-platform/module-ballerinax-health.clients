import ballerina/tcp;
import ballerinax/health.dicom;

public TransferSyntaxUid[] & readonly TRANSFER_SYNTAX_UIDS = [
    {uid: "1.2.840.10008.1.2", syntax: dicom:IMPLICIT_VR_LITTLE_ENDIAN},
    {uid: "1.2.840.10008.1.2.1", syntax: dicom:EXPLICIT_VR_LITTLE_ENDIAN},
    {uid: "1.2.840.10008.1.2.2", syntax: dicom:EXPLICIT_VR_BIG_ENDIAN}
];

// Represents association states
public enum AssociationState {
    NOT_SENT,
    ESTABLISHED,
    REJECTED,
    ABORTED,
    RELEASED
}

// Represents DICOM UL PDU types
// TODO: Add missing PDU types
public enum PduType {
    A_ASSOCIATE_RQ,
    A_ASSOCIATE_AC,
    A_ASSOCIATE_RJ,
    P_DATA_TF,
    A_RELEASE_RQ,
    A_RELEASE_RP,
    A_ABORT
}

// DICOM SOP class types
// From Section C.6.1.3 in Part 4
// TODO: Add missing SOP classes
public enum SopClass {
    PATIENT_ROOT_QUERY_RETRIEVE_INFORMATION_MODEL_FIND = "1.2.840.10008.5.1.4.1.2.1.1",
    PATIENT_ROOT_QUERY_RETRIEVE_INFORMATION_MODEL_MOVE = "1.2.840.10008.5.1.4.1.2.1.2",
    PATIENT_ROOT_QUERY_RETRIEVE_INFORMATION_MODEL_GET = "1.2.840.10008.5.1.4.1.2.1.3"
}

// DICOM upper layer (UL) PDU types
// From Table 9-11, Table 9-24 and Table 9-26 in Part 8
// TODO: Check this with getPdu() function
public final map<byte> & readonly UL_PDU_TYPES = {
    A_ASSOCIATE_RQ: 0x01,
    A_ASSOCIATE_AC: 0x02,
    A_ASSOCIATE_RJ: 0x03,
    A_RELEASE: 0x05,
    A_ABORT: 0x07,
    P_DATA_TF: 0x04
};

// DICOM UL protocol version
const UL_PROTOCOL_VERSION = 1;

// From Table 9-12 in Part 8
const APPLICATION_CONTEXT_ITEM_TYPE = 0x10;

// The number of bytes from the first byte to the last byte of the Application-context-name field
// This will always be [0x00, 0x15] for the DICOM application context name
// Table 9-12 in Part 8
const APPLICATION_CONTEXT_ITEM_LENGTH_BYTES = [0x00, 0x15];

// DICOM Application Context Name
// Section A.2.1 in Part 7
const DICOM_APPLICATION_CONTEXT_NAME = "1.2.840.10008.3.1.1.1";

// From Table 9-13 in Part 8
const AASSOCIATE_RQ_PRESENTATION_CONTEXT_ITEM_TYPE = 0x20;

// From Table 9-18 in Part 8
const AASSOCIATE_AC_PRESENTATION_CONTEXT_ITEM_TYPE = 0x21;

// From Table 9-14 in Part 8
const ABSTRACT_SYNTAX_SUB_ITEM_TYPE = 0x30;

// From Table 9-15 in Part 8
const TRANSFER_SYNTAX_SUB_ITEM_TYPE = 0x40;

// From Table 9-20
const USER_INFORMATION_ITEM_TYPE = 0x50;

// From Table D.1-1
const MAXIMUM_LENGTH_ITEM_TYPE = 0x51;

// Client's max PDU length
const MAX_PDU_LENGTH = 16382;

// Default titles
const DEFAULT_CALLING_AE_TITLE = "BALDICOM";
const DEFAULT_CALLED_AE_TITLE = "ANY-SCP";

// Default socket config to be used
final tcp:ClientConfiguration & readonly DEFAULT_SOCKET_CONFIGURATION = {
    timeout: 60,
    writeTimeout: 60
};

