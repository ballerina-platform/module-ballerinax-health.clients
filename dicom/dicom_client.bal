import ballerinax/health.dicom;

public isolated client class DicomClient {
    private final Association association;

    public function init(ClientConfig & readonly clientConfig) returns error? {
        do {
            self.association = check new (clientConfig);
        } on fail error e {
            return error("Client initialization failed", e);
        }
    }

    remote function aAssociate() returns error? {
        do {
            check self.association.request();
        } on fail error e {
            return error("Association establishment resulted in an error", e);
        }
    }

    remote function aRelease() returns error? {
        do {
            check self.association.release();
        } on fail error e {
            return error("Association release resulted in an error", e);
        }
    }

    remote function aAbort() returns error? {
        do {
            check self.association.abort();
        } on fail error e {
            return error("Association abortion resulted in an error", e);
        }
    }

    remote function cFind(Identifier|dicom:Dataset identifier,
            int messageId = 1, int priority = 2) returns dicom:Dataset[]|error {
        do {
            dicom:Dataset dataset;
            if identifier is Identifier {
                // TODO: Validate data elements when support is added to all VRs
                dataset = check dicom:recordToDataset(identifier,
                            dicom:EXPLICIT_VR_LITTLE_ENDIAN, validateDataElements = false);
            } else {
                dataset = identifier;
            }
            return check self.association.sendCFind(dataset, messageId, priority);
        } on fail error e {
            return error("C-FIND request resulted in an error", e);
        }
    }

}
