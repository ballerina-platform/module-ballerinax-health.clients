# ACSE Service Provider
isolated class ACSEServiceProvider {
    
    private final Association association;
    private final DULServiceProvider dul;

    function init(Association association, DULServiceProvider dul) {
        self.association = association;
        self.dul = dul;
    }

    function sendRequest() returns error? {
        // Construct A-ASSOCIATE request primitive
        AAssociate associateRequestPrimitive = check self.constructAAssociatePrimitive(self.association);

        // Send using DUL
        check self.dul.sendPdu(associateRequestPrimitive);

        // Get confirmation primitive from DUL
        Primitive primitive = (check self.dul.receivePdu())[0];

        if primitive is AAssociate {
            self.association.getAcceptor().setPrimitive(primitive);

            // A-ASSOCIATE-AC?
            if primitive.result == 0x00 {
                // Update negotiated contexts
                check self.updateNegotiatedContexts(primitive);

                // // TODO: Check if this is necessary for a client
                // if self.association.getAcceptedContexts().length() == 0 { // No accepted contexts
                //     self.association.setState(ABORTED);
                //     check self.sendAbort();
                //     return error("No accepted presentation contexts");
                // }

                self.association.setState(ESTABLISHED);
            } else if primitive.result == 0x01 { // Rejected permanent
                self.association.setState(REJECTED);
            } else if primitive.result == 0x02 { // Rejected transient
                self.association.setState(REJECTED);
            } else { // Invalid A-ASSOCIATE response from the peer
                self.association.setState(ABORTED);
                // 2 - DICOM UL service-provider initiated abort
                check self.sendAbort(2);
                return error("Invalid A-ASSOCIATE response from the peer");
            }
        }
        // TODO: Check for other primitive types
    }

    function sendAbort(int 'source) returns error? {
        if 'source != 0 && 'source != 2 {
            return error(string `Invalid source: ${'source}`);
        }
        // Construct A-ABORT request primitive
        AAbort aAbortRequestPrimitive = {'source: 'source};
        // Send using dul
        check self.dul.sendPdu(aAbortRequestPrimitive);
        // Update association state
        self.association.setState(ABORTED);
    }

    function sendRelease() returns error? {
        // Construct A-RELEASE request primitive
        // "reason" parameter shall always use the value "normal" when used on the request primitive
        ARelease aReleaseRequestPrimitive = {reason: "normal"};
        // Send using dul
        check self.dul.sendPdu(aReleaseRequestPrimitive);
        // Update association state
        self.association.setState(RELEASED);
    }

    private function constructAAssociatePrimitive(Association association) returns AAssociate|error {
        do {
            PresentationContext[] contexts = association.getRequestor().getContexts();
            if contexts.length() == 0 {
                fail error("No presentation contexts for the requestor");
            }
            UserInformation? userInformation = association.getRequestor().getUserInformation();
            if userInformation == () {
                fail error("No user information for the requestor");
            }

            return {
                applicationContextName: DICOM_APPLICATION_CONTEXT_NAME,
                callingAeTitle: association.getRequestor().getAet(),
                calledAeTitle: association.getAcceptor().getAet(),
                presentationContextDefinitionList: contexts,
                userInformation: userInformation
            };
        } on fail error e {
            return error("Error constructing AAssociate primitive", e);
        }
    }

    private function updateNegotiatedContexts(AAssociate aAssociatePrimitive) returns error? {
        PresentationContext[] requestedContexts = self.association.getRequestor().getContexts();

        PresentationContext[] acceptedContexts = [];
        PresentationContext[] rejectedContexts = [];

        foreach PresentationContext context in aAssociatePrimitive.presentationContextDefinitionResultsList {
            PresentationContext? matchingRequestedContext = self.getContext(requestedContexts, context.contextId);
            if matchingRequestedContext == () {
                return error(string `Non-requested presentation context present in the response: ${context.contextId}`);
            }
            if context.result == 0x00 {
                acceptedContexts.push(matchingRequestedContext);
            } else {
                rejectedContexts.push(matchingRequestedContext);
            }
        }

        self.association.setAcceptedContexts(acceptedContexts);
        self.association.setRejectedContexts(rejectedContexts);
    }

    isolated function getContext(PresentationContext[] contexts, int contextId) returns PresentationContext? {
        return contexts.filter(context => context.contextId == contextId)[0];
    }
    
}
