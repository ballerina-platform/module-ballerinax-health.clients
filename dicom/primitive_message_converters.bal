import ballerinax/health.dicom;

public isolated function primitiveToMessage(DimsePrimitive primitive, int contextId) returns DimseMessage|error {
    if primitive is CFind {
        // C-FIND must have an identifier
        if primitive.identifier == () {
            return error("C-FIND primitive must have an identifier");
        }
        dicom:Dataset commandSet = check constructCFindCommandSet(primitive.messageId, primitive.priority);
        return {
            contextId: contextId,
            commandSet: commandSet,
            dataset: primitive.identifier
        };
    }
    // return error("Unsupported primitive");
}

// public isolated function messageToPrimitive(DimseMessage message) returns DimsePrimitive|erorr {

// }

isolated function constructCFindCommandSet(int messageId, int priority) returns dicom:Dataset|error {
    // Note: CommandGroupLength data element will be added accordingly during the encoding of the command set later on
    return table [
        {tag: {group: 0x0000, element: 0x0002}, vr: dicom:UI, value: PATIENT_ROOT_QUERY_RETRIEVE_INFORMATION_MODEL_FIND}, // AffectedSOPClassUID
        {tag: {group: 0x0000, element: 0x0100}, vr: dicom:US, value: 0x0020}, // CommandField
        {tag: {group: 0x0000, element: 0x0110}, vr: dicom:US, value: messageId}, // MessageID
        {tag: {group: 0x0000, element: 0x0700}, vr: dicom:US, value: priority}, // Priority
        {tag: {group: 0x0000, element: 0x0800}, vr: dicom:US, value: 1} // CommandDataSetType
    ];
}
