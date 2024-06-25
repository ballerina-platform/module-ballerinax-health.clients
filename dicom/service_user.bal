isolated class ServiceUser {
    private Association association;
    private ServiceUserMode mode;
    private string aet;
    private Primitive? primitive;
    private string? address;
    private int? port;
    private PresentationContext[] contexts;
    private UserInformation? userInformation;

    function init(Association association, ServiceUserMode mode, string aet,
            string? address = (), int? port = ()) {
        self.association = association;
        self.mode = mode;
        self.aet = aet;
        self.primitive = ();
        self.address = address;
        self.port = port;
        self.contexts = [];
        self.userInformation = ();
    }

    isolated function getAssociation() returns Association {
        lock {
            return self.association;
        }
    }

    isolated function setAssociation(Association association) {
        lock {
            self.association = association;
        }
    }

    isolated function getMode() returns ServiceUserMode {
        lock {
            return self.mode;
        }
    }

    isolated function setMode(ServiceUserMode mode) {
        lock {
            self.mode = mode;
        }
    }

    isolated function getAet() returns string {
        lock {
            return self.aet;
        }
    }

    isolated function setAet(string aet) {
        lock {
            self.aet = aet;
        }
    }

    isolated function getPrimitive() returns Primitive? {
        lock {
            return self.primitive.clone();
        }
    }

    isolated function setPrimitive(Primitive primitive) {
        lock {
            self.primitive = primitive.clone();
        }
    }

    isolated function getAddress() returns string? {
        lock {
            return self.address;
        }
    }

    isolated function setAddress(string? address) {
        lock {
            self.address = address;
        }
    }

    isolated function getPort() returns int? {
        lock {
            return self.port;
        }
    }

    isolated function setPort(int? port) {
        lock {
            self.port = port;
        }
    }

    isolated function getContexts() returns PresentationContext[] {
        lock {
            return self.contexts.clone();
        }
    }

    isolated function setContexts(PresentationContext[] contexts) {
        lock {
            self.contexts = contexts.clone();
        }
    }

    isolated function getUserInformation() returns UserInformation? {
        lock {
            return self.userInformation.clone();
        }
    }

    isolated function setUserInformation(UserInformation userInformation) {
        lock {
            self.userInformation = userInformation.clone();
        }
    }
}
