import ballerinax/health.dicom;

# DIMSE Service Provider
isolated class DIMSEServiceProvider {
    private final Association association;
    private final DULServiceProvider dul;

    function init(Association association, DULServiceProvider dul) {
        self.association = association;
        self.dul = dul;
    }

    function sendMessage(DimsePrimitive primitive, int contextId) returns error? {
        // Convert DIMSE primitive to DIMSE message
        DimseMessage message = check primitiveToMessage(primitive, contextId);

        // Create P-DATA primitive
        PData pDataPrimitive = check self.constructPDataPrimitive(message, contextId);

        // Send using DUL
        check self.dul.sendPdu(pDataPrimitive);
    }

    function receiveMessage() returns DimsePrimitive? {
        // Get P-DATA primitive from DUL
        // Primitive[] receivePdu = check self.dul.receivePdu();

        // Convert to DIMSE message

        // convert to DIMSE primitive
    }

    private function constructPDataPrimitive(DimseMessage message, int contextId) returns PData|error {
        PresentationDataValue[] presentationDataValueList = [];

        // Encode command set
        byte[] commandSetBytes = check self.encodeCommandSet(message.commandSet);

        // Dataset
        byte[]? datasetBytes = message.dataset;

        // Create command set PDV (with proper message header)
        PresentationDataValue commandSetPdv = self.createPdv(contextId, commandSetBytes, true, true);
        presentationDataValueList.push(commandSetPdv);

        // Create dataset PDV if a dataset exists in the message (with proper message header)
        // TODO: Implement message data fragmentation, and set the last indicator accordingly
        if datasetBytes is byte[] {
            PresentationDataValue datasetPdv = self.createPdv(contextId, datasetBytes, true, false);
            presentationDataValueList.push(datasetPdv);
        }

        return {presentationDataValueList};
    }

    private function encodeCommandSet(dicom:Dataset commandGroup) returns byte[]|error {
        // Command set must be always encoded in Implicit VR Little Endian
        dicom:TransferSyntax transferSyntax = dicom:IMPLICIT_VR_LITTLE_ENDIAN;

        byte[] commandGroupBytes = check dicom:toBytes(commandGroup, transferSyntax, true, false);

        // Command group length element
        dicom:DataElement commandGroupLength = {
            tag: {group: 0x0000, element: 0x0000},
            vr: dicom:UL,
            value: commandGroupBytes.length()
        };

        // Encode CommandGroupLength data element
        byte[] commandGroupLengthBytes = check dicom:toBytes(commandGroupLength, transferSyntax,
                validateBeforeEncoding = false);

        // Complete encoded command set
        return [...commandGroupLengthBytes, ...commandGroupBytes];
    }

    private function createPdv(int contextId, byte[] userData, boolean last,
            boolean command) returns PresentationDataValue {
        byte messageControlHeader = self.getMessageControlHeader(last, command);
        byte[] userDataWithMessageHeader = [messageControlHeader, ...userData];
        return {
            presentationContextId: contextId,
            userData: userDataWithMessageHeader
        };
    }

    private function getMessageControlHeader(boolean last, boolean command) returns byte {
        // Message control header construction logic is based off of Section E.2 in Part 8
        // If 'last' is true, return 0x03 for a command set and 0x02 for a data set
        // If 'last' is false, return 0x01 for a command set and 0x00 for a data set
        return last ? (command ? 0x03 : 0x02) : (command ? 0x01 : 0x00);
    }
}
