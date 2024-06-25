import ballerinax/health.dicom;

isolated class Association {

    private AssociationState state;

    private final ClientConfig & readonly clientConfig;

    // Service users
    private final ServiceUser requestor; // Local AE (Client)
    private final ServiceUser acceptor; // Remote AE (Server)

    // Accepted and rejected presentation contexts
    private PresentationContext[] acceptedContexts;
    private PresentationContext[] rejectedContexts;

    // Service providers
    private final DULServiceProvider dul;
    private final ACSEServiceProvider acse;
    private final DIMSEServiceProvider dimse;

    function init(ClientConfig & readonly clientConfig) returns error? {
        self.state = NOT_SENT;
        self.clientConfig = clientConfig.cloneReadOnly();

        self.requestor = new (self, REQUESTOR, clientConfig.calledAeTitle ?: DEFAULT_CALLING_AE_TITLE);
        self.acceptor = new (self, ACCEPTOR, clientConfig.callingAeTitle ?: DEFAULT_CALLED_AE_TITLE,
            clientConfig.peer, clientConfig.port
        );

        self.acceptedContexts = [];
        self.rejectedContexts = [];

        self.dul = check new (self);
        self.acse = new (self, self.dul);
        self.dimse = new (self, self.dul);

        // Requestor's presentation contexts
        PresentationContext[] contexts = check self.createPresentationContexts(
            [PATIENT_ROOT_QUERY_RETRIEVE_INFORMATION_MODEL_FIND, PATIENT_ROOT_QUERY_RETRIEVE_INFORMATION_MODEL_GET],
            [dicom:EXPLICIT_VR_LITTLE_ENDIAN]
        );
        // Requestor's user information
        UserInformation userInformation = {
            maximumLength: MAX_PDU_LENGTH
        };
        self.requestor.setContexts(contexts);
        self.requestor.setUserInformation(userInformation);

        // Request association
        check self.request();
    }

    function request() returns error? {
        check self.acse.sendRequest();
    }

    function release() returns error? {
        check self.acse.sendRelease();
    }

    function abort() returns error? {
        // 0 - DICOM UL service-user initiated abort
        check self.acse.sendAbort(0);
    }

    function sendCFind(dicom:Dataset identifier, int messageId = 1, int priority = 2) returns dicom:Dataset[]|error {
        // Check association state
        if !self.isEstablished() {
            return error(string `An association has not been established with the peer.` +
                    string `Current state: ${self.getState()}`);
        }

        // SOP class for C-FIND operation
        SopClass affectedSopClassUid = PATIENT_ROOT_QUERY_RETRIEVE_INFORMATION_MODEL_FIND;

        // Get accepted presentation context for the Patient Root Query/Retrieve Information Model - FIND SOP class
        PresentationContext? presentationContext =
                                            self.getValidContext(affectedSopClassUid);

        // No accepted presentation contexts found for the query model
        if presentationContext == () {
            return error(string `No accepted presentation context(s) found for the SOP class: ${affectedSopClassUid}`);
        }

        // C-FIND primitive
        CFind cFindPrimitive = {messageId, affectedSopClassUid, priority};

        // Transfer syntax of the accepted presentation context
        dicom:TransferSyntax transferSyntax = check uidToTransferSyntax(presentationContext.transferSyntax[0]);

        // Encode identifier dataset
        byte[] identifierBytes = check dicom:toBytes(identifier, transferSyntax, true, false);
        cFindPrimitive.identifier = identifierBytes;

        // Send using DIMSE
        check self.dimse.sendMessage(cFindPrimitive, presentationContext.contextId);

        // TODO: Use a loop here and keep receiving messages from dimse until a non-Pending status. 
        // These messages could be command or data set fractions (refer 'association.py' -> '_wrap_find_responses').

        // Receive response
        DimsePrimitive? confirmationPrimitive = self.dimse.receiveMessage();

        // Check primitive type

        return [];
    }

    private function getValidContext(SopClass sopClass) returns PresentationContext? {
        PresentationContext[] contexts =
                                    self.getAcceptedContexts().filter(context => context.abstractSyntax == sopClass);
        return contexts.length() > 0 ? contexts[0] : ();
    }

    isolated function getClientConfig() returns ClientConfig & readonly {
        lock {
            return self.clientConfig;
        }
    }

    isolated function getState() returns AssociationState {
        lock {
            return self.state;
        }
    }

    isolated function setState(AssociationState newState) {
        lock {
            self.state = newState;
        }
    }

    isolated function isEstablished() returns boolean {
        lock {
            return self.state == ESTABLISHED;
        }
    }

    isolated function isAborted() returns boolean {
        lock {
            return self.state == ABORTED;
        }
    }

    isolated function isRejected() returns boolean {
        lock {
            return self.state == REJECTED;
        }
    }

    isolated function isReleased() returns boolean {
        lock {
            return self.state == RELEASED;
        }
    }

    isolated function getAcse() returns ACSEServiceProvider {
        lock {
            return self.acse;
        }
    }

    isolated function getDul() returns DULServiceProvider {
        lock {
            return self.dul;
        }
    }

    isolated function getRequestor() returns ServiceUser {
        lock {
            return self.requestor;
        }
    }

    isolated function getAcceptor() returns ServiceUser {
        lock {
            return self.acceptor;
        }
    }

    isolated function getAcceptedContexts() returns PresentationContext[] {
        lock {
            return self.acceptedContexts.clone();
        }
    }

    isolated function setAcceptedContexts(PresentationContext[] contexts) {
        lock {
            self.acceptedContexts = contexts.clone();
        }
    }

    isolated function getRejectedContexts() returns PresentationContext[] {
        lock {
            return self.rejectedContexts.clone();
        }
    }

    isolated function setRejectedContexts(PresentationContext[] contexts) {
        lock {
            self.rejectedContexts = contexts.clone();
        }
    }

    private function createPresentationContexts(SopClass[] abstractSyntaxes, dicom:TransferSyntax[] transferSyntaxes)
        returns PresentationContext[]|error {
        UID[] transferSyntaxUids = [];

        // Convert each TransferSyntax to a UID and add it to the transferSyntaxUids array
        foreach dicom:TransferSyntax transferSyntax in transferSyntaxes {
            UID uid = check TransferSyntaxToUid(transferSyntax);
            transferSyntaxUids.push(uid);
        }

        PresentationContext[] contexts = [];
        int contextId = 1;

        // Create a presentation context for each abstract syntax and add it to the contexts array
        foreach SopClass abstractSyntax in abstractSyntaxes {
            PresentationContext context = {
                contextId: contextId,
                abstractSyntax: abstractSyntax,
                transferSyntax: transferSyntaxUids
            };
            contexts.push(context);
            contextId += 2; // Presentation-context-ID values should be odd integers
        }

        return contexts;
    }
    
}
