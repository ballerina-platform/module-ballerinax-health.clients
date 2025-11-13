// Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com).

// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at

// http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.
//
// AUTO-GENERATED FILE.

import ballerinax/health.clients.fhir as fhirClient;
import ballerinax/health.fhir.r4.international401 as resourceInternational;
import ballerinax/health.fhir.r4.uscore610 as healthFhirR4Uscore610;


# This connector allows you to connect and interact with any FHIR server
@display {label: "FHIR Client Connector"}
public client class FHIRClientConnector {

    final fhirClient:FHIRConnector fhirConnectorObj;

    public function init(fhirClient:FHIRConnectorConfig fhirConnectorConfig) returns error? {
        self.fhirConnectorObj = check new (fhirConnectorConfig);
    }

    # -------------------------
    # Auto-generated operations
    # -------------------------

    # + id - The logical ID of the Account resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Account by the logical ID"}
    remote function getAccountById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Account", id);
    }

    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Account resources"}
    remote isolated function searchAccount(
            string? _count = (),
            string? _id = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);

        return self.fhirConnectorObj->search("Account", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the AdverseEvent resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get AdverseEvent by the logical ID"}
    remote function getAdverseEventById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("AdverseEvent", id);
    }

    # + research_subject - Search parameter for research-subject (reference) - Search for AdverseEvent resources for a specified research study participant
    # + seriousness - Search parameter for seriousness (token) - Refine a search for AdverseEvent resources by seriousness of the event
    # + study - Search parameter for study (reference) - Search for AdverseEvent resources for a specified study ID
    # + subject - Search parameter for subject (reference) - Search for AdverseEvent resources for a specified patient ID
    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + actuality - Search parameter for actuality (token) - 
    # + category - Search parameter for category (token) - 
    # + date - Search parameter for date (date) - 
    # + event - Search parameter for event (token) - 
    # + location - Search parameter for location (reference) - 
    # + recorder - Search parameter for recorder (reference) - 
    # + resultingcondition - Search parameter for resultingcondition (reference) - 
    # + severity - Search parameter for severity (token) - 
    # + substance - Search parameter for substance (reference) - 
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search AdverseEvent resources"}
    remote isolated function searchAdverseEvent(
            string? research_subject = (),
            string? seriousness = (),
            string? study = (),
            string? subject = (),
            string? _count = (),
            string? _id = (),
            string? actuality = (),
            string? category = (),
            string? date = (),
            string? event = (),
            string? location = (),
            string? recorder = (),
            string? resultingcondition = (),
            string? severity = (),
            string? substance = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "research-subject", research_subject);
        addIfPresent(params, "seriousness", seriousness);
        addIfPresent(params, "study", study);
        addIfPresent(params, "subject", subject);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "actuality", actuality);
        addIfPresent(params, "category", category);
        addIfPresent(params, "date", date);
        addIfPresent(params, "event", event);
        addIfPresent(params, "location", location);
        addIfPresent(params, "recorder", recorder);
        addIfPresent(params, "resultingcondition", resultingcondition);
        addIfPresent(params, "severity", severity);
        addIfPresent(params, "substance", substance);

        return self.fhirConnectorObj->search("AdverseEvent", mode = fhirClient:POST, searchParameters = params);
    }

        # + newAllergyIntolerance - A new instance of the AllergyIntolerance resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Create AllergyIntolerance resource"}
    remote function createAllergyIntolerance(healthFhirR4Uscore610:USCoreAllergyIntolerance newAllergyIntolerance)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->create(newAllergyIntolerance.toJson());
    }

# + id - The logical ID of the AllergyIntolerance resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get AllergyIntolerance by the logical ID"}
    remote function getAllergyIntoleranceById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("AllergyIntolerance", id);
    }

    # + clinical_status - Search parameter for clinical-status (token) - Refine a search for AllergyIntolerance resources by clinicalStatus
    # + patient - Search parameter for patient (reference) - Search for AllergyIntolerance resources for a specified patient ID
    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + asserter - Search parameter for asserter (reference) - 
    # + category - Search parameter for category (token) - 
    # + code - Search parameter for code (token) - 
    # + criticality - Search parameter for criticality (token) - 
    # + date - Search parameter for date (date) - 
    # + identifier - Search parameter for identifier (token) - 
    # + last_date - Search parameter for last-date (date) - 
    # + manifestation - Search parameter for manifestation (token) - 
    # + onset - Search parameter for onset (date) - 
    # + recorder - Search parameter for recorder (reference) - 
    # + route - Search parameter for route (token) - 
    # + severity - Search parameter for severity (token) - 
    # + 'type - Search parameter for type (token) - 
    # + verification_status - Search parameter for verification-status (token) - 
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search AllergyIntolerance resources"}
    remote isolated function searchAllergyIntolerance(
            string? clinical_status = (),
            string? patient = (),
            string? _count = (),
            string? _id = (),
            string? asserter = (),
            string? category = (),
            string? code = (),
            string? criticality = (),
            string? date = (),
            string? identifier = (),
            string? last_date = (),
            string? manifestation = (),
            string? onset = (),
            string? recorder = (),
            string? route = (),
            string? severity = (),
            string? 'type = (),
            string? verification_status = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "clinical-status", clinical_status);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "asserter", asserter);
        addIfPresent(params, "category", category);
        addIfPresent(params, "code", code);
        addIfPresent(params, "criticality", criticality);
        addIfPresent(params, "date", date);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "last-date", last_date);
        addIfPresent(params, "manifestation", manifestation);
        addIfPresent(params, "onset", onset);
        addIfPresent(params, "recorder", recorder);
        addIfPresent(params, "route", route);
        addIfPresent(params, "severity", severity);
        addIfPresent(params, "type", 'type);
        addIfPresent(params, "verification-status", verification_status);

        return self.fhirConnectorObj->search("AllergyIntolerance", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the Appointment resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Appointment by the logical ID"}
    remote function getAppointmentById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Appointment", id);
    }

    # + date - Search parameter for date (date) - 
    # + identifier - Search parameter for identifier (token) - 
    # + onlyscannable - Search parameter for onlyscannable (token) - Refine a search for Appointment resources to scannable appointments only
    # + patient - Search parameter for patient (reference) - Search for Appointment resources for a specified patient ID
    # + service_category - Search parameter for service-category (token) - Search on the type of appointment
    # + status - Search parameter for status (token) - 
    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + actor - Search parameter for actor (reference) - 
    # + appointment_type - Search parameter for appointment-type (token) - 
    # + based_on - Search parameter for based-on (reference) - 
    # + location - Search parameter for location (reference) - 
    # + part_status - Search parameter for part-status (token) - 
    # + practitioner - Search parameter for practitioner (reference) - 
    # + reason_code - Search parameter for reason-code (token) - 
    # + reason_reference - Search parameter for reason-reference (reference) - 
    # + service_type - Search parameter for service-type (token) - 
    # + slot - Search parameter for slot (reference) - 
    # + specialty - Search parameter for specialty (token) - 
    # + supporting_info - Search parameter for supporting-info (reference) - 
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Appointment resources"}
    remote isolated function searchAppointment(
            string? date = (),
            string? identifier = (),
            string? onlyscannable = (),
            string? patient = (),
            string? service_category = (),
            string? status = (),
            string? _count = (),
            string? _id = (),
            string? actor = (),
            string? appointment_type = (),
            string? based_on = (),
            string? location = (),
            string? part_status = (),
            string? practitioner = (),
            string? reason_code = (),
            string? reason_reference = (),
            string? service_type = (),
            string? slot = (),
            string? specialty = (),
            string? supporting_info = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "date", date);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "onlyscannable", onlyscannable);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "service-category", service_category);
        addIfPresent(params, "status", status);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "actor", actor);
        addIfPresent(params, "appointment-type", appointment_type);
        addIfPresent(params, "based-on", based_on);
        addIfPresent(params, "location", location);
        addIfPresent(params, "part-status", part_status);
        addIfPresent(params, "practitioner", practitioner);
        addIfPresent(params, "reason-code", reason_code);
        addIfPresent(params, "reason-reference", reason_reference);
        addIfPresent(params, "service-type", service_type);
        addIfPresent(params, "slot", slot);
        addIfPresent(params, "specialty", specialty);
        addIfPresent(params, "supporting-info", supporting_info);

        return self.fhirConnectorObj->search("Appointment", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the Binary resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Binary by the logical ID"}
    remote function getBinaryById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Binary", id);
    }

    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Binary resources"}
    remote isolated function searchBinary(
            string? _count = (),
            string? _id = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);

        return self.fhirConnectorObj->search("Binary", mode = fhirClient:POST, searchParameters = params);
    }

        # + newBodyStructure - A new instance of the BodyStructure resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Create BodyStructure resource"}
    remote function createBodyStructure(resourceInternational:BodyStructure newBodyStructure)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->create(newBodyStructure.toJson());
    }

# + id - The logical ID of the BodyStructure resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get BodyStructure by the logical ID"}
    remote function getBodyStructureById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("BodyStructure", id);
    }

    # + identifier - Search parameter for identifier (token) - Refine a search for BodyStructure resources by identifier
    # + location - Search parameter for location (token) - Refine a search for BodyStructure resources by location
    # + morphology - Search parameter for morphology (token) - Refine a search for BodyStructure resources by morphology
    # + patient - Search parameter for patient (reference) - Search for BodyStructure resources for a specified patient ID
    # + subject - Search parameter for subject (reference) - Search for BodyStructure resources for a specified patient ID
    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search BodyStructure resources"}
    remote isolated function searchBodyStructure(
            string? identifier = (),
            string? location = (),
            string? morphology = (),
            string? patient = (),
            string? subject = (),
            string? _count = (),
            string? _id = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "location", location);
        addIfPresent(params, "morphology", morphology);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "subject", subject);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);

        return self.fhirConnectorObj->search("BodyStructure", mode = fhirClient:POST, searchParameters = params);
    }

    # + updatedBodyStructure - A new or updated instance of the BodyStructure resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Update BodyStructure resource"}
    remote function updateBodyStructure(resourceInternational:BodyStructure updatedBodyStructure)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->update(updatedBodyStructure.toJson());
    }

    # + id - The logical ID of the CarePlan resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get CarePlan by the logical ID"}
    remote function getCarePlanById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("CarePlan", id);
    }

    # + activity_date - Search parameter for activity-date (date) - 
    # + category - Search parameter for category (token) - Search for CarePlans of the given type
    # + encounter - Search parameter for encounter (reference) - 
    # + part_of - Search parameter for part-of (reference) - 
    # + patient - Search parameter for patient (reference) - Search for CarePlan resources using a specified patient ID
    # + status - Search parameter for status (token) - 
    # + subject - Search parameter for subject (reference) - Search for CarePlan resources using a specified patient ID
    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + activity_code - Search parameter for activity-code (token) - 
    # + activity_reference - Search parameter for activity-reference (reference) - 
    # + based_on - Search parameter for based-on (reference) - 
    # + care_team - Search parameter for care-team (reference) - 
    # + condition - Search parameter for condition (reference) - 
    # + date - Search parameter for date (date) - 
    # + goal - Search parameter for goal (reference) - 
    # + identifier - Search parameter for identifier (token) - 
    # + instantiates_canonical - Search parameter for instantiates-canonical (reference) - 
    # + intent - Search parameter for intent (token) - 
    # + performer - Search parameter for performer (reference) - 
    # + replaces - Search parameter for replaces (reference) - 
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search CarePlan resources"}
    remote isolated function searchCarePlan(
            string? activity_date = (),
            string? category = (),
            string? encounter = (),
            string? part_of = (),
            string? patient = (),
            string? status = (),
            string? subject = (),
            string? _count = (),
            string? _id = (),
            string? activity_code = (),
            string? activity_reference = (),
            string? based_on = (),
            string? care_team = (),
            string? condition = (),
            string? date = (),
            string? goal = (),
            string? identifier = (),
            string? instantiates_canonical = (),
            string? intent = (),
            string? performer = (),
            string? replaces = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "activity-date", activity_date);
        addIfPresent(params, "category", category);
        addIfPresent(params, "encounter", encounter);
        addIfPresent(params, "part-of", part_of);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "status", status);
        addIfPresent(params, "subject", subject);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "activity-code", activity_code);
        addIfPresent(params, "activity-reference", activity_reference);
        addIfPresent(params, "based-on", based_on);
        addIfPresent(params, "care-team", care_team);
        addIfPresent(params, "condition", condition);
        addIfPresent(params, "date", date);
        addIfPresent(params, "goal", goal);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "instantiates-canonical", instantiates_canonical);
        addIfPresent(params, "intent", intent);
        addIfPresent(params, "performer", performer);
        addIfPresent(params, "replaces", replaces);

        return self.fhirConnectorObj->search("CarePlan", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the CareTeam resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get CareTeam by the logical ID"}
    remote function getCareTeamById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("CareTeam", id);
    }

    # + patient - Search parameter for patient (reference) - Search for CareTeam resources using a specified patient ID
    # + status - Search parameter for status (token) - Refine a search based on the CareTeam's status
    # + subject - Search parameter for subject (reference) - Search for CareTeam resources using a specified patient ID
    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + category - Search parameter for category (token) - 
    # + date - Search parameter for date (date) - 
    # + encounter - Search parameter for encounter (reference) - 
    # + identifier - Search parameter for identifier (token) - 
    # + participant - Search parameter for participant (reference) - 
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search CareTeam resources"}
    remote isolated function searchCareTeam(
            string? patient = (),
            string? status = (),
            string? subject = (),
            string? _count = (),
            string? _id = (),
            string? category = (),
            string? date = (),
            string? encounter = (),
            string? identifier = (),
            string? participant = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "status", status);
        addIfPresent(params, "subject", subject);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "category", category);
        addIfPresent(params, "date", date);
        addIfPresent(params, "encounter", encounter);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "participant", participant);

        return self.fhirConnectorObj->search("CareTeam", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the Claim resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Claim by the logical ID"}
    remote function getClaimById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Claim", id);
    }

    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Claim resources"}
    remote isolated function searchClaim(
            string? _count = (),
            string? _id = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);

        return self.fhirConnectorObj->search("Claim", mode = fhirClient:POST, searchParameters = params);
    }

        # + newCommunication - A new instance of the Communication resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Create Communication resource"}
    remote function createCommunication(resourceInternational:Communication newCommunication)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->create(newCommunication.toJson());
    }

# + id - The logical ID of the Communication resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Communication by the logical ID"}
    remote function getCommunicationById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Communication", id);
    }

    # + based_on - Search parameter for based-on (reference) - 
    # + category - Search parameter for category (token) - Refine a search to include only Communication resources with the given categories
    # + encounter - Search parameter for encounter (reference) - Refine a search to include Communication resources from only the encounters provided
    # + part_of - Search parameter for part-of (reference) - 
    # + patient - Search parameter for patient (reference) - Search for Communication resources for a specified patient ID
    # + subject - Search parameter for subject (reference) - Search for Communication resources for a specified patient ID
    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + identifier - Search parameter for identifier (token) - 
    # + instantiates_canonical - Search parameter for instantiates-canonical (reference) - 
    # + medium - Search parameter for medium (token) - 
    # + received - Search parameter for received (date) - 
    # + recipient - Search parameter for recipient (reference) - 
    # + sender - Search parameter for sender (reference) - 
    # + sent - Search parameter for sent (date) - 
    # + status - Search parameter for status (token) - 
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Communication resources"}
    remote isolated function searchCommunication(
            string? based_on = (),
            string? category = (),
            string? encounter = (),
            string? part_of = (),
            string? patient = (),
            string? subject = (),
            string? _count = (),
            string? _id = (),
            string? identifier = (),
            string? instantiates_canonical = (),
            string? medium = (),
            string? received = (),
            string? recipient = (),
            string? sender = (),
            string? sent = (),
            string? status = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "based-on", based_on);
        addIfPresent(params, "category", category);
        addIfPresent(params, "encounter", encounter);
        addIfPresent(params, "part-of", part_of);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "subject", subject);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "instantiates-canonical", instantiates_canonical);
        addIfPresent(params, "medium", medium);
        addIfPresent(params, "received", received);
        addIfPresent(params, "recipient", recipient);
        addIfPresent(params, "sender", sender);
        addIfPresent(params, "sent", sent);
        addIfPresent(params, "status", status);

        return self.fhirConnectorObj->search("Communication", mode = fhirClient:POST, searchParameters = params);
    }

        # + newConceptMap - A new instance of the ConceptMap resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Create ConceptMap resource"}
    remote function createConceptMap(resourceInternational:ConceptMap newConceptMap)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->create(newConceptMap.toJson());
    }

# + id - The logical ID of the ConceptMap resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get ConceptMap by the logical ID"}
    remote function getConceptMapById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("ConceptMap", id);
    }

        # + newCondition - A new instance of the Condition resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Create Condition resource"}
    remote function createCondition(healthFhirR4Uscore610:USCoreConditionEncounterDiagnosisProfile|healthFhirR4Uscore610:USCoreConditionProblemsHealthConcernsProfile newCondition)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->create(newCondition.toJson());
    }

# + id - The logical ID of the Condition resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Condition by the logical ID"}
    remote function getConditionById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Condition", id);
    }

    # + abatement_date - Search parameter for abatement-date (date) - Search for Conditions with a specified abatement date
    # + category - Search parameter for category (token) - Search for Condition resources by category
    # + clinical_status - Search parameter for clinical-status (token) - Refine a search for Condition resources by clinicalStatus
    # + code - Search parameter for code (token) - Search for Conditions with a specified code
    # + encounter - Search parameter for encounter (reference) - Search for Condition resources for specific encounters
    # + onset_date - Search parameter for onset-date (date) - Search for Conditions with a specified onset date
    # + patient - Search parameter for patient (reference) - Search for Condition resources for a specified patient ID
    # + recorded_date - Search parameter for recorded-date (date) - Search for Conditions with a specified recorded date
    # + subject - Search parameter for subject (reference) - Search for Condition resources for a specified patient ID
    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + abatement_string - Search parameter for abatement-string (string) - 
    # + asserter - Search parameter for asserter (reference) - 
    # + body_site - Search parameter for body-site (token) - 
    # + evidence - Search parameter for evidence (token) - 
    # + evidence_detail - Search parameter for evidence-detail (reference) - 
    # + identifier - Search parameter for identifier (token) - 
    # + onset_info - Search parameter for onset-info (string) - 
    # + severity - Search parameter for severity (token) - 
    # + stage - Search parameter for stage (token) - 
    # + verification_status - Search parameter for verification-status (token) - 
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Condition resources"}
    remote isolated function searchCondition(
            string? abatement_date = (),
            string? category = (),
            string? clinical_status = (),
            string? code = (),
            string? encounter = (),
            string? onset_date = (),
            string? patient = (),
            string? recorded_date = (),
            string? subject = (),
            string? _count = (),
            string? _id = (),
            string? abatement_string = (),
            string? asserter = (),
            string? body_site = (),
            string? evidence = (),
            string? evidence_detail = (),
            string? identifier = (),
            string? onset_info = (),
            string? severity = (),
            string? stage = (),
            string? verification_status = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "abatement-date", abatement_date);
        addIfPresent(params, "category", category);
        addIfPresent(params, "clinical-status", clinical_status);
        addIfPresent(params, "code", code);
        addIfPresent(params, "encounter", encounter);
        addIfPresent(params, "onset-date", onset_date);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "recorded-date", recorded_date);
        addIfPresent(params, "subject", subject);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "abatement-string", abatement_string);
        addIfPresent(params, "asserter", asserter);
        addIfPresent(params, "body-site", body_site);
        addIfPresent(params, "evidence", evidence);
        addIfPresent(params, "evidence-detail", evidence_detail);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "onset-info", onset_info);
        addIfPresent(params, "severity", severity);
        addIfPresent(params, "stage", stage);
        addIfPresent(params, "verification-status", verification_status);

        return self.fhirConnectorObj->search("Condition", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the Consent resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Consent by the logical ID"}
    remote function getConsentById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Consent", id);
    }

    # + category - Search parameter for category (token) - Search for Consent resources by category
    # + patient - Search parameter for patient (reference) - Search for Consent resources for a specified patient ID
    # + status - Search parameter for status (token) - Search for Consent resources by status
    # + subject - Search parameter for subject (reference) - Search for Consent resources for a specified patient ID
    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + action - Search parameter for action (token) - 
    # + actor - Search parameter for actor (reference) - 
    # + consentor - Search parameter for consentor (reference) - 
    # + data - Search parameter for data (reference) - 
    # + date - Search parameter for date (date) - 
    # + identifier - Search parameter for identifier (token) - 
    # + organization - Search parameter for organization (reference) - 
    # + period - Search parameter for period (date) - 
    # + purpose - Search parameter for purpose (token) - 
    # + scope - Search parameter for scope (token) - 
    # + security_label - Search parameter for security-label (token) - 
    # + source_reference - Search parameter for source-reference (reference) - 
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Consent resources"}
    remote isolated function searchConsent(
            string? category = (),
            string? patient = (),
            string? status = (),
            string? subject = (),
            string? _count = (),
            string? _id = (),
            string? action = (),
            string? actor = (),
            string? consentor = (),
            string? data = (),
            string? date = (),
            string? identifier = (),
            string? organization = (),
            string? period = (),
            string? purpose = (),
            string? scope = (),
            string? security_label = (),
            string? source_reference = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "category", category);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "status", status);
        addIfPresent(params, "subject", subject);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "action", action);
        addIfPresent(params, "actor", actor);
        addIfPresent(params, "consentor", consentor);
        addIfPresent(params, "data", data);
        addIfPresent(params, "date", date);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "organization", organization);
        addIfPresent(params, "period", period);
        addIfPresent(params, "purpose", purpose);
        addIfPresent(params, "scope", scope);
        addIfPresent(params, "security-label", security_label);
        addIfPresent(params, "source-reference", source_reference);

        return self.fhirConnectorObj->search("Consent", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the Contract resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Contract by the logical ID"}
    remote function getContractById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Contract", id);
    }

    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Contract resources"}
    remote isolated function searchContract(
            string? _count = (),
            string? _id = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);

        return self.fhirConnectorObj->search("Contract", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the Coverage resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Coverage by the logical ID"}
    remote function getCoverageById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Coverage", id);
    }

    # + beneficiary - Search parameter for beneficiary (reference) - Search for Coverage resource for a specific patient ID
    # + patient - Search parameter for patient (reference) - Search for Coverage resource for a specific patient ID
    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + class_type - Search parameter for class-type (token) - 
    # + class_value - Search parameter for class-value (string) - 
    # + dependent - Search parameter for dependent (string) - 
    # + identifier - Search parameter for identifier (token) - 
    # + payor - Search parameter for payor (reference) - 
    # + policy_holder - Search parameter for policy-holder (reference) - 
    # + status - Search parameter for status (token) - 
    # + subscriber - Search parameter for subscriber (reference) - 
    # + 'type - Search parameter for type (token) - 
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Coverage resources"}
    remote isolated function searchCoverage(
            string? beneficiary = (),
            string? patient = (),
            string? _count = (),
            string? _id = (),
            string? class_type = (),
            string? class_value = (),
            string? dependent = (),
            string? identifier = (),
            string? payor = (),
            string? policy_holder = (),
            string? status = (),
            string? subscriber = (),
            string? 'type = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "beneficiary", beneficiary);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "class-type", class_type);
        addIfPresent(params, "class-value", class_value);
        addIfPresent(params, "dependent", dependent);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "payor", payor);
        addIfPresent(params, "policy-holder", policy_holder);
        addIfPresent(params, "status", status);
        addIfPresent(params, "subscriber", subscriber);
        addIfPresent(params, "type", 'type);

        return self.fhirConnectorObj->search("Coverage", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the Device resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Device by the logical ID"}
    remote function getDeviceById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Device", id);
    }

    # + device_name - Search parameter for device-name (string) - A string that will match the Device
    # + manufacturer - Search parameter for manufacturer (string) - Manufacturer of the device
    # + model - Search parameter for model (string) - Model number of the device
    # + patient - Search parameter for patient (reference) - The patient in whom this device is implanted
    # + udi_carrier - Search parameter for udi-carrier (string) - The UDI barcode string - matches static UDI
    # + udi_di - Search parameter for udi-di (string) - The UDI device identifier (DI)
    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + identifier - Search parameter for identifier (token) - 
    # + location - Search parameter for location (reference) - 
    # + organization - Search parameter for organization (reference) - 
    # + status - Search parameter for status (token) - 
    # + 'type - Search parameter for type (token) - 
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Device resources"}
    remote isolated function searchDevice(
            string? device_name = (),
            string? manufacturer = (),
            string? model = (),
            string? patient = (),
            string? udi_carrier = (),
            string? udi_di = (),
            string? _count = (),
            string? _id = (),
            string? identifier = (),
            string? location = (),
            string? organization = (),
            string? status = (),
            string? 'type = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "device-name", device_name);
        addIfPresent(params, "manufacturer", manufacturer);
        addIfPresent(params, "model", model);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "udi-carrier", udi_carrier);
        addIfPresent(params, "udi-di", udi_di);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "location", location);
        addIfPresent(params, "organization", organization);
        addIfPresent(params, "status", status);
        addIfPresent(params, "type", 'type);

        return self.fhirConnectorObj->search("Device", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the DeviceRequest resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get DeviceRequest by the logical ID"}
    remote function getDeviceRequestById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("DeviceRequest", id);
    }

    # + patient - Search parameter for patient (reference) - Search for DeviceRequest resource for a specified patient ID
    # + status - Search parameter for status (token) - Search for a DeviceRequest based on a device request status
    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + authored_on - Search parameter for authored-on (date) - 
    # + based_on - Search parameter for based-on (reference) - 
    # + code - Search parameter for code (token) - 
    # + device - Search parameter for device (reference) - 
    # + encounter - Search parameter for encounter (reference) - 
    # + event_date - Search parameter for event-date (date) - 
    # + group_identifier - Search parameter for group-identifier (token) - 
    # + identifier - Search parameter for identifier (token) - 
    # + instantiates_canonical - Search parameter for instantiates-canonical (reference) - 
    # + insurance - Search parameter for insurance (reference) - 
    # + intent - Search parameter for intent (token) - 
    # + performer - Search parameter for performer (reference) - 
    # + prior_request - Search parameter for prior-request (reference) - 
    # + requester - Search parameter for requester (reference) - 
    # + subject - Search parameter for subject (reference) - 
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search DeviceRequest resources"}
    remote isolated function searchDeviceRequest(
            string? patient = (),
            string? status = (),
            string? _count = (),
            string? _id = (),
            string? authored_on = (),
            string? based_on = (),
            string? code = (),
            string? device = (),
            string? encounter = (),
            string? event_date = (),
            string? group_identifier = (),
            string? identifier = (),
            string? instantiates_canonical = (),
            string? insurance = (),
            string? intent = (),
            string? performer = (),
            string? prior_request = (),
            string? requester = (),
            string? subject = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "status", status);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "authored-on", authored_on);
        addIfPresent(params, "based-on", based_on);
        addIfPresent(params, "code", code);
        addIfPresent(params, "device", device);
        addIfPresent(params, "encounter", encounter);
        addIfPresent(params, "event-date", event_date);
        addIfPresent(params, "group-identifier", group_identifier);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "instantiates-canonical", instantiates_canonical);
        addIfPresent(params, "insurance", insurance);
        addIfPresent(params, "intent", intent);
        addIfPresent(params, "performer", performer);
        addIfPresent(params, "prior-request", prior_request);
        addIfPresent(params, "requester", requester);
        addIfPresent(params, "subject", subject);

        return self.fhirConnectorObj->search("DeviceRequest", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the DeviceUseStatement resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get DeviceUseStatement by the logical ID"}
    remote function getDeviceUseStatementById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("DeviceUseStatement", id);
    }

    # + patient - Search parameter for patient (reference) - Search for DeviceUseStatement resources for a specified patient ID
    # + subject - Search parameter for subject (reference) - Search for DeviceUseStatement resources for a specified patient ID
    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + device - Search parameter for device (reference) - 
    # + identifier - Search parameter for identifier (token) - 
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search DeviceUseStatement resources"}
    remote isolated function searchDeviceUseStatement(
            string? patient = (),
            string? subject = (),
            string? _count = (),
            string? _id = (),
            string? device = (),
            string? identifier = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "subject", subject);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "device", device);
        addIfPresent(params, "identifier", identifier);

        return self.fhirConnectorObj->search("DeviceUseStatement", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the DiagnosticReport resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get DiagnosticReport by the logical ID"}
    remote function getDiagnosticReportById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("DiagnosticReport", id);
    }

    # + category - Search parameter for category (token) - Refine a search for DiagnosticReport resources by category
    # + code - Search parameter for code (token) - Refine a search for DiagnosticReport resources by code
    # + date - Search parameter for date (date) - Refine a search for DiagnosticReport resources by specifying a date or date range that a DiagnosticReport was resulted or recorded
    # + identifier - Search parameter for identifier (token) - Refine search by specifying an identifier, such as the internal order ID or the accession number
    # + patient - Search parameter for patient (reference) - Search for DiagnosticReport resources for a specified patient ID
    # + subject - Search parameter for subject (reference) - Search for DiagnosticReport resources for a specified patient ID
    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + based_on - Search parameter for based-on (reference) - 
    # + conclusion - Search parameter for conclusion (token) - 
    # + encounter - Search parameter for encounter (reference) - 
    # + issued - Search parameter for issued (date) - 
    # + media - Search parameter for media (reference) - 
    # + performer - Search parameter for performer (reference) - 
    # + result - Search parameter for result (reference) - 
    # + results_interpreter - Search parameter for results-interpreter (reference) - 
    # + specimen - Search parameter for specimen (reference) - 
    # + status - Search parameter for status (token) - 
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search DiagnosticReport resources"}
    remote isolated function searchDiagnosticReport(
            string? category = (),
            string? code = (),
            string? date = (),
            string? identifier = (),
            string? patient = (),
            string? subject = (),
            string? _count = (),
            string? _id = (),
            string? based_on = (),
            string? conclusion = (),
            string? encounter = (),
            string? issued = (),
            string? media = (),
            string? performer = (),
            string? result = (),
            string? results_interpreter = (),
            string? specimen = (),
            string? status = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "category", category);
        addIfPresent(params, "code", code);
        addIfPresent(params, "date", date);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "subject", subject);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "based-on", based_on);
        addIfPresent(params, "conclusion", conclusion);
        addIfPresent(params, "encounter", encounter);
        addIfPresent(params, "issued", issued);
        addIfPresent(params, "media", media);
        addIfPresent(params, "performer", performer);
        addIfPresent(params, "result", result);
        addIfPresent(params, "results-interpreter", results_interpreter);
        addIfPresent(params, "specimen", specimen);
        addIfPresent(params, "status", status);

        return self.fhirConnectorObj->search("DiagnosticReport", mode = fhirClient:POST, searchParameters = params);
    }

    # + updatedDiagnosticReport - A new or updated instance of the DiagnosticReport resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Update DiagnosticReport resource"}
    remote function updateDiagnosticReport(healthFhirR4Uscore610:USCoreDiagnosticReportProfileLaboratoryReporting|healthFhirR4Uscore610:USCoreDiagnosticReportProfileNoteExchange updatedDiagnosticReport)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->update(updatedDiagnosticReport.toJson());
    }

        # + newDocumentReference - A new instance of the DocumentReference resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Create DocumentReference resource"}
    remote function createDocumentReference(healthFhirR4Uscore610:USCoreDocumentReferenceProfile newDocumentReference)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->create(newDocumentReference.toJson());
    }

# + id - The logical ID of the DocumentReference resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get DocumentReference by the logical ID"}
    remote function getDocumentReferenceById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("DocumentReference", id);
    }

    # + author - Search parameter for author (reference) - Further refine a search for a given set of DocumentReferences on a patient by specifying a Reference that corresponds to the author of the document
    # + category - Search parameter for category (token) - Refine a search for DocumentReference resources by category
    # + date - Search parameter for date (date) - Further refine a search for a given set of DocumentReferences on a patient by specifying a date or date range in ISO format (YYYY[-MM[-DD[THH:MM[:SS][TZ]]]]]) that corresponds to the document creation time
    # + docstatus - Search parameter for docstatus (token) - Further refine a search for a given set of DocumentReferences on a patient by specifying a docStatus
    # + encounter - Search parameter for encounter (reference) - Search for DocumentReference resources for a specific internal or external encounter
    # + patient - Search parameter for patient (reference) - Search for DocumentReference resources for a specified patient ID
    # + period - Search parameter for period (date) - Further refine a search for a given set of DocumentReferences on a patient by specifying a date or date range in ISO format (YYYY[-MM[-DD]]) that corresponds to the time of the service that is being documented
    # + status - Search parameter for status (token) - Further refine a search for a given set of DocumentReferences on a patient by specifying a status of the document
    # + subject - Search parameter for subject (reference) - Search for DocumentReference resources for a specified patient ID
    # + 'type - Search parameter for type (token) - Further refine a search for a given set of DocumentReferences on a patient by specifying a type code to return only documents of that type
    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + _lastupdated - Search parameter for _lastupdated (date) - Further refine a search by the date list in meta
    # + authenticator - Search parameter for authenticator (reference) - 
    # + contenttype - Search parameter for contenttype (token) - 
    # + custodian - Search parameter for custodian (reference) - 
    # + description - Search parameter for description (string) - 
    # + event - Search parameter for event (token) - 
    # + facility - Search parameter for facility (token) - 
    # + format - Search parameter for format (token) - 
    # + identifier - Search parameter for identifier (token) - 
    # + language - Search parameter for language (token) - 
    # + related - Search parameter for related (reference) - 
    # + relatesto - Search parameter for relatesto (reference) - 
    # + relation - Search parameter for relation (token) - 
    # + security_label - Search parameter for security-label (token) - 
    # + setting - Search parameter for setting (token) - 
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search DocumentReference resources"}
    remote isolated function searchDocumentReference(
            string? author = (),
            string? category = (),
            string? date = (),
            string? docstatus = (),
            string? encounter = (),
            string? patient = (),
            string? period = (),
            string? status = (),
            string? subject = (),
            string? 'type = (),
            string? _count = (),
            string? _id = (),
            string? _lastupdated = (),
            string? authenticator = (),
            string? contenttype = (),
            string? custodian = (),
            string? description = (),
            string? event = (),
            string? facility = (),
            string? format = (),
            string? identifier = (),
            string? language = (),
            string? related = (),
            string? relatesto = (),
            string? relation = (),
            string? security_label = (),
            string? setting = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "author", author);
        addIfPresent(params, "category", category);
        addIfPresent(params, "date", date);
        addIfPresent(params, "docstatus", docstatus);
        addIfPresent(params, "encounter", encounter);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "period", period);
        addIfPresent(params, "status", status);
        addIfPresent(params, "subject", subject);
        addIfPresent(params, "type", 'type);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "_lastupdated", _lastupdated);
        addIfPresent(params, "authenticator", authenticator);
        addIfPresent(params, "contenttype", contenttype);
        addIfPresent(params, "custodian", custodian);
        addIfPresent(params, "description", description);
        addIfPresent(params, "event", event);
        addIfPresent(params, "facility", facility);
        addIfPresent(params, "format", format);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "language", language);
        addIfPresent(params, "related", related);
        addIfPresent(params, "relatesto", relatesto);
        addIfPresent(params, "relation", relation);
        addIfPresent(params, "security-label", security_label);
        addIfPresent(params, "setting", setting);

        return self.fhirConnectorObj->search("DocumentReference", mode = fhirClient:POST, searchParameters = params);
    }

    # + updatedDocumentReference - A new or updated instance of the DocumentReference resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Update DocumentReference resource"}
    remote function updateDocumentReference(healthFhirR4Uscore610:USCoreDocumentReferenceProfile updatedDocumentReference)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->update(updatedDocumentReference.toJson());
    }

    # + id - The logical ID of the Encounter resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Encounter by the logical ID"}
    remote function getEncounterById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Encounter", id);
    }

    # + 'class - Search parameter for class (token) - Refine a search for Encounter resources by class
    # + date - Search parameter for date (date) - Refine a search for Encounter resources by date
    # + identifier - Search parameter for identifier (token) - Search for Encounter resources by encounter identifier in the format <code system>|<code>
    # + onlyscannable - Search parameter for onlyscannable (token) - Refine a search for Encounter resources to scannable encounters only
    # + patient - Search parameter for patient (reference) - Search for Encounter resources for a specified patient ID
    # + subject - Search parameter for subject (reference) - Search for Encounter resources for a specified patient ID
    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + account - Search parameter for account (reference) - 
    # + appointment - Search parameter for appointment (reference) - 
    # + based_on - Search parameter for based-on (reference) - 
    # + diagnosis - Search parameter for diagnosis (reference) - 
    # + episode_of_care - Search parameter for episode-of-care (reference) - 
    # + location - Search parameter for location (reference) - 
    # + location_period - Search parameter for location-period (date) - 
    # + part_of - Search parameter for part-of (reference) - 
    # + participant - Search parameter for participant (reference) - 
    # + participant_type - Search parameter for participant-type (token) - 
    # + practitioner - Search parameter for practitioner (reference) - 
    # + reason_code - Search parameter for reason-code (token) - 
    # + reason_reference - Search parameter for reason-reference (reference) - 
    # + service_provider - Search parameter for service-provider (reference) - 
    # + special_arrangement - Search parameter for special-arrangement (token) - 
    # + status - Search parameter for status (token) - 
    # + 'type - Search parameter for type (token) - 
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Encounter resources"}
    remote isolated function searchEncounter(
            string? 'class = (),
            string? date = (),
            string? identifier = (),
            string? onlyscannable = (),
            string? patient = (),
            string? subject = (),
            string? _count = (),
            string? _id = (),
            string? account = (),
            string? appointment = (),
            string? based_on = (),
            string? diagnosis = (),
            string? episode_of_care = (),
            string? location = (),
            string? location_period = (),
            string? part_of = (),
            string? participant = (),
            string? participant_type = (),
            string? practitioner = (),
            string? reason_code = (),
            string? reason_reference = (),
            string? service_provider = (),
            string? special_arrangement = (),
            string? status = (),
            string? 'type = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "class", 'class);
        addIfPresent(params, "date", date);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "onlyscannable", onlyscannable);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "subject", subject);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "account", account);
        addIfPresent(params, "appointment", appointment);
        addIfPresent(params, "based-on", based_on);
        addIfPresent(params, "diagnosis", diagnosis);
        addIfPresent(params, "episode-of-care", episode_of_care);
        addIfPresent(params, "location", location);
        addIfPresent(params, "location-period", location_period);
        addIfPresent(params, "part-of", part_of);
        addIfPresent(params, "participant", participant);
        addIfPresent(params, "participant-type", participant_type);
        addIfPresent(params, "practitioner", practitioner);
        addIfPresent(params, "reason-code", reason_code);
        addIfPresent(params, "reason-reference", reason_reference);
        addIfPresent(params, "service-provider", service_provider);
        addIfPresent(params, "special-arrangement", special_arrangement);
        addIfPresent(params, "status", status);
        addIfPresent(params, "type", 'type);

        return self.fhirConnectorObj->search("Encounter", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the Endpoint resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Endpoint by the logical ID"}
    remote function getEndpointById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Endpoint", id);
    }

    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Endpoint resources"}
    remote isolated function searchEndpoint(
            string? _count = (),
            string? _id = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);

        return self.fhirConnectorObj->search("Endpoint", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the EpisodeOfCare resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get EpisodeOfCare by the logical ID"}
    remote function getEpisodeOfCareById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("EpisodeOfCare", id);
    }

    # + patient - Search parameter for patient (reference) - Search for EpisodeOfCare resources for a specified patient ID
    # + status - Search parameter for status (token) - Refine a search for EpisodeOfCare resources by status
    # + 'type - Search parameter for type (token) - Refine a search for EpisodeOfCare resources by type
    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + care_manager - Search parameter for care-manager (reference) - 
    # + condition - Search parameter for condition (reference) - 
    # + date - Search parameter for date (date) - 
    # + identifier - Search parameter for identifier (token) - 
    # + incoming_referral - Search parameter for incoming-referral (reference) - 
    # + organization - Search parameter for organization (reference) - 
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search EpisodeOfCare resources"}
    remote isolated function searchEpisodeOfCare(
            string? patient = (),
            string? status = (),
            string? 'type = (),
            string? _count = (),
            string? _id = (),
            string? care_manager = (),
            string? condition = (),
            string? date = (),
            string? identifier = (),
            string? incoming_referral = (),
            string? organization = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "status", status);
        addIfPresent(params, "type", 'type);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "care-manager", care_manager);
        addIfPresent(params, "condition", condition);
        addIfPresent(params, "date", date);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "incoming-referral", incoming_referral);
        addIfPresent(params, "organization", organization);

        return self.fhirConnectorObj->search("EpisodeOfCare", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the ExplanationOfBenefit resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get ExplanationOfBenefit by the logical ID"}
    remote function getExplanationOfBenefitById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("ExplanationOfBenefit", id);
    }

    # + created - Search parameter for created (date) - Refine a search for ExplanationOfBenefit resources by creation date for the claim
    # + patient - Search parameter for patient (reference) - Search for ExplanationOfBenefit resources for a specified patient ID
    # + use - Search parameter for use (token) - Refine a search for ExplanationOfBenefit by use
    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + care_team - Search parameter for care-team (reference) - 
    # + claim - Search parameter for claim (reference) - 
    # + coverage - Search parameter for coverage (reference) - 
    # + detail_udi - Search parameter for detail-udi (reference) - 
    # + disposition - Search parameter for disposition (string) - 
    # + encounter - Search parameter for encounter (reference) - 
    # + enterer - Search parameter for enterer (reference) - 
    # + facility - Search parameter for facility (reference) - 
    # + identifier - Search parameter for identifier (token) - 
    # + item_udi - Search parameter for item-udi (reference) - 
    # + payee - Search parameter for payee (reference) - 
    # + procedure_udi - Search parameter for procedure-udi (reference) - 
    # + provider - Search parameter for provider (reference) - 
    # + status - Search parameter for status (token) - 
    # + subdetail_udi - Search parameter for subdetail-udi (reference) - 
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search ExplanationOfBenefit resources"}
    remote isolated function searchExplanationOfBenefit(
            string? created = (),
            string? patient = (),
            string? use = (),
            string? _count = (),
            string? _id = (),
            string? care_team = (),
            string? claim = (),
            string? coverage = (),
            string? detail_udi = (),
            string? disposition = (),
            string? encounter = (),
            string? enterer = (),
            string? facility = (),
            string? identifier = (),
            string? item_udi = (),
            string? payee = (),
            string? procedure_udi = (),
            string? provider = (),
            string? status = (),
            string? subdetail_udi = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "created", created);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "use", use);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "care-team", care_team);
        addIfPresent(params, "claim", claim);
        addIfPresent(params, "coverage", coverage);
        addIfPresent(params, "detail-udi", detail_udi);
        addIfPresent(params, "disposition", disposition);
        addIfPresent(params, "encounter", encounter);
        addIfPresent(params, "enterer", enterer);
        addIfPresent(params, "facility", facility);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "item-udi", item_udi);
        addIfPresent(params, "payee", payee);
        addIfPresent(params, "procedure-udi", procedure_udi);
        addIfPresent(params, "provider", provider);
        addIfPresent(params, "status", status);
        addIfPresent(params, "subdetail-udi", subdetail_udi);

        return self.fhirConnectorObj->search("ExplanationOfBenefit", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the FamilyMemberHistory resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get FamilyMemberHistory by the logical ID"}
    remote function getFamilyMemberHistoryById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("FamilyMemberHistory", id);
    }

    # + patient - Search parameter for patient (reference) - Required: the patient whose family history you'd like to search
    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + code - Search parameter for code (token) - 
    # + date - Search parameter for date (date) - 
    # + identifier - Search parameter for identifier (token) - 
    # + instantiates_canonical - Search parameter for instantiates-canonical (reference) - 
    # + relationship - Search parameter for relationship (token) - 
    # + sex - Search parameter for sex (token) - 
    # + status - Search parameter for status (token) - 
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search FamilyMemberHistory resources"}
    remote isolated function searchFamilyMemberHistory(
            string? patient = (),
            string? _count = (),
            string? _id = (),
            string? code = (),
            string? date = (),
            string? identifier = (),
            string? instantiates_canonical = (),
            string? relationship = (),
            string? sex = (),
            string? status = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "code", code);
        addIfPresent(params, "date", date);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "instantiates-canonical", instantiates_canonical);
        addIfPresent(params, "relationship", relationship);
        addIfPresent(params, "sex", sex);
        addIfPresent(params, "status", status);

        return self.fhirConnectorObj->search("FamilyMemberHistory", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the Flag resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Flag by the logical ID"}
    remote function getFlagById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Flag", id);
    }

    # + category - Search parameter for category (token) - Refine a search for Flag resources by category
    # + encounter - Search parameter for encounter (reference) - Refine a search for Flag resources by encounter
    # + patient - Search parameter for patient (reference) - Search for Flag resources for a specified patient ID
    # + status - Search parameter for status (token) - Refine a search for Flag resources by status
    # + subject - Search parameter for subject (reference) - Search for Flag resources for a specified patient ID
    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + author - Search parameter for author (reference) - 
    # + date - Search parameter for date (date) - 
    # + identifier - Search parameter for identifier (token) - 
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Flag resources"}
    remote isolated function searchFlag(
            string? category = (),
            string? encounter = (),
            string? patient = (),
            string? status = (),
            string? subject = (),
            string? _count = (),
            string? _id = (),
            string? author = (),
            string? date = (),
            string? identifier = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "category", category);
        addIfPresent(params, "encounter", encounter);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "status", status);
        addIfPresent(params, "subject", subject);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "author", author);
        addIfPresent(params, "date", date);
        addIfPresent(params, "identifier", identifier);

        return self.fhirConnectorObj->search("Flag", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the Goal resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Goal by the logical ID"}
    remote function getGoalById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Goal", id);
    }

    # + category - Search parameter for category (token) - Refines a search by Goal category
    # + lifecycle_status - Search parameter for lifecycle-status (token) - Refines a search based on Goal lifecycle status
    # + patient - Search parameter for patient (reference) - Search for Patient resources for a specific patient ID
    # + start_date - Search parameter for start-date (date) - Refines a search based on Goal start date
    # + subject - Search parameter for subject (reference) - Search for Patient resources for a specific patient ID
    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + achievement_status - Search parameter for achievement-status (token) - 
    # + identifier - Search parameter for identifier (token) - 
    # + target_date - Search parameter for target-date (date) - 
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Goal resources"}
    remote isolated function searchGoal(
            string? category = (),
            string? lifecycle_status = (),
            string? patient = (),
            string? start_date = (),
            string? subject = (),
            string? _count = (),
            string? _id = (),
            string? achievement_status = (),
            string? identifier = (),
            string? target_date = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "category", category);
        addIfPresent(params, "lifecycle-status", lifecycle_status);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "start-date", start_date);
        addIfPresent(params, "subject", subject);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "achievement-status", achievement_status);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "target-date", target_date);

        return self.fhirConnectorObj->search("Goal", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the Group resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Group by the logical ID"}
    remote function getGroupById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Group", id);
    }

    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Group resources"}
    remote isolated function searchGroup(
            string? _count = (),
            string? _id = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);

        return self.fhirConnectorObj->search("Group", mode = fhirClient:POST, searchParameters = params);
    }

remote function groupExportGroupOperation(@display {label: "Request Mode"} fhirClient:RequestMode mode = fhirClient:POST,
                                                                             @display {label: "Logical ID"} string? id = (),
                                                                             @display {label: "Query Parameters"} map<string[]>? queryParameters = (),
                                                                             @display {label: "Resource data"} json|xml? data = ())
        returns fhirClient:FHIRResponse|fhirClient:FHIRError {
    return check self.fhirConnectorObj->callOperation("Group", "$group-export", mode, id, queryParameters, data);
}

    # + id - The logical ID of the ImagingStudy resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get ImagingStudy by the logical ID"}
    remote function getImagingStudyById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("ImagingStudy", id);
    }

    # + identifier - Search parameter for identifier (token) - Search for ImagingStudy resources by a study's identifier
    # + patient - Search parameter for patient (reference) - Search for ImagingStudy resources for a specified patient ID
    # + subject - Search parameter for subject (reference) - Search for ImagingStudy resources for a specified patient ID
    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + basedon - Search parameter for basedon (reference) - 
    # + bodysite - Search parameter for bodysite (token) - 
    # + dicom_class - Search parameter for dicom-class (token) - 
    # + encounter - Search parameter for encounter (reference) - 
    # + endpoint - Search parameter for endpoint (reference) - 
    # + instance - Search parameter for instance (token) - 
    # + interpreter - Search parameter for interpreter (reference) - 
    # + modality - Search parameter for modality (token) - 
    # + performer - Search parameter for performer (reference) - 
    # + reason - Search parameter for reason (token) - 
    # + referrer - Search parameter for referrer (reference) - 
    # + series - Search parameter for series (token) - 
    # + started - Search parameter for started (date) - 
    # + status - Search parameter for status (token) - 
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search ImagingStudy resources"}
    remote isolated function searchImagingStudy(
            string? identifier = (),
            string? patient = (),
            string? subject = (),
            string? _count = (),
            string? _id = (),
            string? basedon = (),
            string? bodysite = (),
            string? dicom_class = (),
            string? encounter = (),
            string? endpoint = (),
            string? instance = (),
            string? interpreter = (),
            string? modality = (),
            string? performer = (),
            string? reason = (),
            string? referrer = (),
            string? series = (),
            string? started = (),
            string? status = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "subject", subject);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "basedon", basedon);
        addIfPresent(params, "bodysite", bodysite);
        addIfPresent(params, "dicom-class", dicom_class);
        addIfPresent(params, "encounter", encounter);
        addIfPresent(params, "endpoint", endpoint);
        addIfPresent(params, "instance", instance);
        addIfPresent(params, "interpreter", interpreter);
        addIfPresent(params, "modality", modality);
        addIfPresent(params, "performer", performer);
        addIfPresent(params, "reason", reason);
        addIfPresent(params, "referrer", referrer);
        addIfPresent(params, "series", series);
        addIfPresent(params, "started", started);
        addIfPresent(params, "status", status);

        return self.fhirConnectorObj->search("ImagingStudy", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the Immunization resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Immunization by the logical ID"}
    remote function getImmunizationById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Immunization", id);
    }

    # + date - Search parameter for date (date) - Refine a search for Immunization resources by vaccine administration date
    # + patient - Search parameter for patient (reference) - Search for Immunization resources for a specified patient ID
    # + status - Search parameter for status (token) - Refine a search for Immunization resources by status
    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + identifier - Search parameter for identifier (token) - 
    # + location - Search parameter for location (reference) - 
    # + lot_number - Search parameter for lot-number (string) - 
    # + manufacturer - Search parameter for manufacturer (reference) - 
    # + performer - Search parameter for performer (reference) - 
    # + reaction - Search parameter for reaction (reference) - 
    # + reaction_date - Search parameter for reaction-date (date) - 
    # + reason_code - Search parameter for reason-code (token) - 
    # + reason_reference - Search parameter for reason-reference (reference) - 
    # + series - Search parameter for series (string) - 
    # + status_reason - Search parameter for status-reason (token) - 
    # + target_disease - Search parameter for target-disease (token) - 
    # + vaccine_code - Search parameter for vaccine-code (token) - 
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Immunization resources"}
    remote isolated function searchImmunization(
            string? date = (),
            string? patient = (),
            string? status = (),
            string? _count = (),
            string? _id = (),
            string? identifier = (),
            string? location = (),
            string? lot_number = (),
            string? manufacturer = (),
            string? performer = (),
            string? reaction = (),
            string? reaction_date = (),
            string? reason_code = (),
            string? reason_reference = (),
            string? series = (),
            string? status_reason = (),
            string? target_disease = (),
            string? vaccine_code = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "date", date);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "status", status);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "location", location);
        addIfPresent(params, "lot-number", lot_number);
        addIfPresent(params, "manufacturer", manufacturer);
        addIfPresent(params, "performer", performer);
        addIfPresent(params, "reaction", reaction);
        addIfPresent(params, "reaction-date", reaction_date);
        addIfPresent(params, "reason-code", reason_code);
        addIfPresent(params, "reason-reference", reason_reference);
        addIfPresent(params, "series", series);
        addIfPresent(params, "status-reason", status_reason);
        addIfPresent(params, "target-disease", target_disease);
        addIfPresent(params, "vaccine-code", vaccine_code);

        return self.fhirConnectorObj->search("Immunization", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the ImmunizationRecommendation resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get ImmunizationRecommendation by the logical ID"}
    remote function getImmunizationRecommendationById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("ImmunizationRecommendation", id);
    }

    # + patient - Search parameter for patient (reference) - The FHIR id of a patient whose immunization recommendations you'd like to obtain
    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + date - Search parameter for date (date) - 
    # + identifier - Search parameter for identifier (token) - 
    # + information - Search parameter for information (reference) - 
    # + status - Search parameter for status (token) - 
    # + support - Search parameter for support (reference) - 
    # + target_disease - Search parameter for target-disease (token) - 
    # + vaccine_type - Search parameter for vaccine-type (token) - 
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search ImmunizationRecommendation resources"}
    remote isolated function searchImmunizationRecommendation(
            string? patient = (),
            string? _count = (),
            string? _id = (),
            string? date = (),
            string? identifier = (),
            string? information = (),
            string? status = (),
            string? support = (),
            string? target_disease = (),
            string? vaccine_type = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "date", date);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "information", information);
        addIfPresent(params, "status", status);
        addIfPresent(params, "support", support);
        addIfPresent(params, "target-disease", target_disease);
        addIfPresent(params, "vaccine-type", vaccine_type);

        return self.fhirConnectorObj->search("ImmunizationRecommendation", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the List resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get List by the logical ID"}
    remote function getListById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("List", id);
    }

    # + code - Search parameter for code (token) - Refine a search for List resources by list type
    # + encounter - Search parameter for encounter (reference) - Refine a search for List resources by encounter
    # + identifier - Search parameter for identifier (token) - Refine a search for List resource by internal identifier
    # + patient - Search parameter for patient (reference) - Refine a search for List resources by patient
    # + subject - Search parameter for subject (reference) - Refine a search for List resources by patient
    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + date - Search parameter for date (date) - 
    # + empty_reason - Search parameter for empty-reason (token) - 
    # + item - Search parameter for item (reference) - 
    # + notes - Search parameter for notes (string) - 
    # + 'source - Search parameter for source (reference) - 
    # + status - Search parameter for status (token) - 
    # + title - Search parameter for title (string) - 
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search List resources"}
    remote isolated function searchList(
            string? code = (),
            string? encounter = (),
            string? identifier = (),
            string? patient = (),
            string? subject = (),
            string? _count = (),
            string? _id = (),
            string? date = (),
            string? empty_reason = (),
            string? item = (),
            string? notes = (),
            string? 'source = (),
            string? status = (),
            string? title = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "code", code);
        addIfPresent(params, "encounter", encounter);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "subject", subject);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "date", date);
        addIfPresent(params, "empty-reason", empty_reason);
        addIfPresent(params, "item", item);
        addIfPresent(params, "notes", notes);
        addIfPresent(params, "source", 'source);
        addIfPresent(params, "status", status);
        addIfPresent(params, "title", title);

        return self.fhirConnectorObj->search("List", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the Location resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Location by the logical ID"}
    remote function getLocationById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Location", id);
    }

    # + 'type - Search parameter for type (token) - Search for Location resources with a specified location type
    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + address - Search parameter for address (string) - 
    # + address_city - Search parameter for address-city (string) - 
    # + address_country - Search parameter for address-country (string) - 
    # + address_postalcode - Search parameter for address-postalcode (string) - 
    # + address_state - Search parameter for address-state (string) - 
    # + address_use - Search parameter for address-use (token) - 
    # + endpoint - Search parameter for endpoint (reference) - 
    # + identifier - Search parameter for identifier (token) - 
    # + name - Search parameter for name (string) - 
    # + operational_status - Search parameter for operational-status (token) - 
    # + organization - Search parameter for organization (reference) - 
    # + partof - Search parameter for partof (reference) - 
    # + status - Search parameter for status (token) - 
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Location resources"}
    remote isolated function searchLocation(
            string? 'type = (),
            string? _count = (),
            string? _id = (),
            string? address = (),
            string? address_city = (),
            string? address_country = (),
            string? address_postalcode = (),
            string? address_state = (),
            string? address_use = (),
            string? endpoint = (),
            string? identifier = (),
            string? name = (),
            string? operational_status = (),
            string? organization = (),
            string? partof = (),
            string? status = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "type", 'type);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "address", address);
        addIfPresent(params, "address-city", address_city);
        addIfPresent(params, "address-country", address_country);
        addIfPresent(params, "address-postalcode", address_postalcode);
        addIfPresent(params, "address-state", address_state);
        addIfPresent(params, "address-use", address_use);
        addIfPresent(params, "endpoint", endpoint);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "name", name);
        addIfPresent(params, "operational-status", operational_status);
        addIfPresent(params, "organization", organization);
        addIfPresent(params, "partof", partof);
        addIfPresent(params, "status", status);

        return self.fhirConnectorObj->search("Location", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the Measure resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Measure by the logical ID"}
    remote function getMeasureById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Measure", id);
    }

    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Measure resources"}
    remote isolated function searchMeasure(
            string? _count = (),
            string? _id = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);

        return self.fhirConnectorObj->search("Measure", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the MeasureReport resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get MeasureReport by the logical ID"}
    remote function getMeasureReportById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("MeasureReport", id);
    }

    # + epic_group_id - Search parameter for epic-group-id (string) - 
    # + patient - Search parameter for patient (reference) - 
    # + subject - Search parameter for subject (reference) - 
    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + _lastupdated - Search parameter for _lastupdated (date) - 
    # + date - Search parameter for date (date) - 
    # + evaluated_resource - Search parameter for evaluated-resource (reference) - 
    # + identifier - Search parameter for identifier (token) - 
    # + measure - Search parameter for measure (reference) - 
    # + period - Search parameter for period (date) - 
    # + reporter - Search parameter for reporter (reference) - 
    # + status - Search parameter for status (token) - 
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search MeasureReport resources"}
    remote isolated function searchMeasureReport(
            string? epic_group_id = (),
            string? patient = (),
            string? subject = (),
            string? _count = (),
            string? _id = (),
            string? _lastupdated = (),
            string? date = (),
            string? evaluated_resource = (),
            string? identifier = (),
            string? measure = (),
            string? period = (),
            string? reporter = (),
            string? status = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "epic-group-id", epic_group_id);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "subject", subject);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "_lastupdated", _lastupdated);
        addIfPresent(params, "date", date);
        addIfPresent(params, "evaluated-resource", evaluated_resource);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "measure", measure);
        addIfPresent(params, "period", period);
        addIfPresent(params, "reporter", reporter);
        addIfPresent(params, "status", status);

        return self.fhirConnectorObj->search("MeasureReport", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the Media resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Media by the logical ID"}
    remote function getMediaById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Media", id);
    }

    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Media resources"}
    remote isolated function searchMedia(
            string? _count = (),
            string? _id = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);

        return self.fhirConnectorObj->search("Media", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the Medication resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Medication by the logical ID"}
    remote function getMedicationById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Medication", id);
    }

    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Medication resources"}
    remote isolated function searchMedication(
            string? _count = (),
            string? _id = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);

        return self.fhirConnectorObj->search("Medication", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the MedicationAdministration resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get MedicationAdministration by the logical ID"}
    remote function getMedicationAdministrationById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("MedicationAdministration", id);
    }

    # + context - Search parameter for context (reference) - Refine a search for MedicationAdministration resources with one or more linked reference
    # + effective_time - Search parameter for effective-time (date) - Refine a search for MedicationAdministration resources for a given patient by specifying a date or a range of dates for the administration
    # + patient - Search parameter for patient (reference) - Search for MedicationAdministration resources for a specified patient ID
    # + performer - Search parameter for performer (reference) - Refine a search for MedicationAdministration resources by one or more associated reference
    # + request - Search parameter for request (reference) - Refine a search for MedicationAdministration resources by associated reference
    # + status - Search parameter for status (token) - Refine a search for MedicationAdministration resources with one or more statuses
    # + subject - Search parameter for subject (reference) - Search for MedicationAdministration resources for a specified patient ID
    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + code - Search parameter for code (token) - 
    # + device - Search parameter for device (reference) - 
    # + identifier - Search parameter for identifier (token) - 
    # + medication - Search parameter for medication (reference) - 
    # + reason_given - Search parameter for reason-given (token) - 
    # + reason_not_given - Search parameter for reason-not-given (token) - 
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search MedicationAdministration resources"}
    remote isolated function searchMedicationAdministration(
            string? context = (),
            string? effective_time = (),
            string? patient = (),
            string? performer = (),
            string? request = (),
            string? status = (),
            string? subject = (),
            string? _count = (),
            string? _id = (),
            string? code = (),
            string? device = (),
            string? identifier = (),
            string? medication = (),
            string? reason_given = (),
            string? reason_not_given = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "context", context);
        addIfPresent(params, "effective-time", effective_time);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "performer", performer);
        addIfPresent(params, "request", request);
        addIfPresent(params, "status", status);
        addIfPresent(params, "subject", subject);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "code", code);
        addIfPresent(params, "device", device);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "medication", medication);
        addIfPresent(params, "reason-given", reason_given);
        addIfPresent(params, "reason-not-given", reason_not_given);

        return self.fhirConnectorObj->search("MedicationAdministration", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the MedicationDispense resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get MedicationDispense by the logical ID"}
    remote function getMedicationDispenseById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("MedicationDispense", id);
    }

    # + category - Search parameter for category (token) - Refine a search for MedicationDispense resources by category
    # + patient - Search parameter for patient (reference) - Search for MedicationDispense resources for a specified patient ID
    # + subject - Search parameter for subject (reference) - Search for MedicationDispense resources for a specified patient ID
    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + code - Search parameter for code (token) - 
    # + context - Search parameter for context (reference) - 
    # + destination - Search parameter for destination (reference) - 
    # + identifier - Search parameter for identifier (token) - 
    # + medication - Search parameter for medication (reference) - 
    # + performer - Search parameter for performer (reference) - 
    # + prescription - Search parameter for prescription (reference) - 
    # + receiver - Search parameter for receiver (reference) - 
    # + responsibleparty - Search parameter for responsibleparty (reference) - 
    # + status - Search parameter for status (token) - 
    # + 'type - Search parameter for type (token) - 
    # + whenhandedover - Search parameter for whenhandedover (date) - 
    # + whenprepared - Search parameter for whenprepared (date) - 
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search MedicationDispense resources"}
    remote isolated function searchMedicationDispense(
            string? category = (),
            string? patient = (),
            string? subject = (),
            string? _count = (),
            string? _id = (),
            string? code = (),
            string? context = (),
            string? destination = (),
            string? identifier = (),
            string? medication = (),
            string? performer = (),
            string? prescription = (),
            string? receiver = (),
            string? responsibleparty = (),
            string? status = (),
            string? 'type = (),
            string? whenhandedover = (),
            string? whenprepared = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "category", category);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "subject", subject);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "code", code);
        addIfPresent(params, "context", context);
        addIfPresent(params, "destination", destination);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "medication", medication);
        addIfPresent(params, "performer", performer);
        addIfPresent(params, "prescription", prescription);
        addIfPresent(params, "receiver", receiver);
        addIfPresent(params, "responsibleparty", responsibleparty);
        addIfPresent(params, "status", status);
        addIfPresent(params, "type", 'type);
        addIfPresent(params, "whenhandedover", whenhandedover);
        addIfPresent(params, "whenprepared", whenprepared);

        return self.fhirConnectorObj->search("MedicationDispense", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the MedicationRequest resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get MedicationRequest by the logical ID"}
    remote function getMedicationRequestById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("MedicationRequest", id);
    }

    # + category - Search parameter for category (token) - Refine a search for MedicationRequest resources by category
    # + date - Search parameter for date (date) - Refine a search for MedicationRequest resources for a given patient by specifying a date or a range of dates for when the medication was activated
    # + intent - Search parameter for intent (token) - Refine a search for MedicationRequest resources by one or more intents
    # + patient - Search parameter for patient (reference) - Search for MedicationRequest resources for a specified patient ID
    # + status - Search parameter for status (token) - Refine a search for MedicationRequest resources by one or more statuses
    # + subject - Search parameter for subject (reference) - Search for MedicationRequest resources for a specified patient ID
    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + authoredon - Search parameter for authoredon (date) - 
    # + code - Search parameter for code (token) - 
    # + encounter - Search parameter for encounter (reference) - 
    # + identifier - Search parameter for identifier (token) - 
    # + intended_dispenser - Search parameter for intended-dispenser (reference) - 
    # + intended_performer - Search parameter for intended-performer (reference) - 
    # + intended_performertype - Search parameter for intended-performertype (token) - 
    # + medication - Search parameter for medication (reference) - 
    # + priority - Search parameter for priority (token) - 
    # + requester - Search parameter for requester (reference) - 
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search MedicationRequest resources"}
    remote isolated function searchMedicationRequest(
            string? category = (),
            string? date = (),
            string? intent = (),
            string? patient = (),
            string? status = (),
            string? subject = (),
            string? _count = (),
            string? _id = (),
            string? authoredon = (),
            string? code = (),
            string? encounter = (),
            string? identifier = (),
            string? intended_dispenser = (),
            string? intended_performer = (),
            string? intended_performertype = (),
            string? medication = (),
            string? priority = (),
            string? requester = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "category", category);
        addIfPresent(params, "date", date);
        addIfPresent(params, "intent", intent);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "status", status);
        addIfPresent(params, "subject", subject);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "authoredon", authoredon);
        addIfPresent(params, "code", code);
        addIfPresent(params, "encounter", encounter);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "intended-dispenser", intended_dispenser);
        addIfPresent(params, "intended-performer", intended_performer);
        addIfPresent(params, "intended-performertype", intended_performertype);
        addIfPresent(params, "medication", medication);
        addIfPresent(params, "priority", priority);
        addIfPresent(params, "requester", requester);

        return self.fhirConnectorObj->search("MedicationRequest", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the NutritionOrder resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get NutritionOrder by the logical ID"}
    remote function getNutritionOrderById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("NutritionOrder", id);
    }

    # + patient - Search parameter for patient (reference) - Search for NutritionOrder resources for the specified patient ID
    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + additive - Search parameter for additive (token) - 
    # + datetime - Search parameter for datetime (date) - 
    # + encounter - Search parameter for encounter (reference) - 
    # + formula - Search parameter for formula (token) - 
    # + identifier - Search parameter for identifier (token) - 
    # + instantiates_canonical - Search parameter for instantiates-canonical (reference) - 
    # + oraldiet - Search parameter for oraldiet (token) - 
    # + provider - Search parameter for provider (reference) - 
    # + status - Search parameter for status (token) - 
    # + supplement - Search parameter for supplement (token) - 
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search NutritionOrder resources"}
    remote isolated function searchNutritionOrder(
            string? patient = (),
            string? _count = (),
            string? _id = (),
            string? additive = (),
            string? datetime = (),
            string? encounter = (),
            string? formula = (),
            string? identifier = (),
            string? instantiates_canonical = (),
            string? oraldiet = (),
            string? provider = (),
            string? status = (),
            string? supplement = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "additive", additive);
        addIfPresent(params, "datetime", datetime);
        addIfPresent(params, "encounter", encounter);
        addIfPresent(params, "formula", formula);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "instantiates-canonical", instantiates_canonical);
        addIfPresent(params, "oraldiet", oraldiet);
        addIfPresent(params, "provider", provider);
        addIfPresent(params, "status", status);
        addIfPresent(params, "supplement", supplement);

        return self.fhirConnectorObj->search("NutritionOrder", mode = fhirClient:POST, searchParameters = params);
    }

        # + newObservation - A new instance of the Observation resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Create Observation resource"}
    remote function createObservation(healthFhirR4Uscore610:USCorePediatricHeadOccipitalFrontalCircumferencePercentileProfile|healthFhirR4Uscore610:USCorePediatricBMIforAgeObservationProfile|healthFhirR4Uscore610:USCorePediatricWeightForHeightObservationProfile|healthFhirR4Uscore610:USCoreBloodPressureProfile|healthFhirR4Uscore610:USCoreBMIProfile|healthFhirR4Uscore610:USCoreBodyHeightProfile|healthFhirR4Uscore610:USCoreBodyTemperatureProfile|healthFhirR4Uscore610:USCoreBodyWeightProfile|healthFhirR4Uscore610:USCoreHeadCircumferenceProfile|healthFhirR4Uscore610:USCoreHeartRateProfile|healthFhirR4Uscore610:USCoreObservationClinicalResultProfile|healthFhirR4Uscore610:USCoreLaboratoryResultObservationProfile|healthFhirR4Uscore610:USCoreObservationOccupationProfile|healthFhirR4Uscore610:USCoreObservationPregnancyIntentProfile|healthFhirR4Uscore610:USCoreObservationPregnancyStatusProfile|healthFhirR4Uscore610:USCoreObservationScreeningAssessmentProfile|healthFhirR4Uscore610:USCoreObservationSexualOrientationProfile|healthFhirR4Uscore610:USCorePulseOximetryProfile|healthFhirR4Uscore610:USCoreRespiratoryRateProfile|healthFhirR4Uscore610:USCoreSimpleObservationProfile|healthFhirR4Uscore610:USCoreSmokingStatusProfile|healthFhirR4Uscore610:USCoreVitalSignsProfile newObservation)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->create(newObservation.toJson());
    }

# + id - The logical ID of the Observation resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Observation by the logical ID"}
    remote function getObservationById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Observation", id);
    }

    # + based_on - Search parameter for based-on (reference) - Refine a search for Observation resources by specifying a Reference associated with the Observation
    # + category - Search parameter for category (token) - Refine a search for Observation resources by category or SNOMED code
    # + code - Search parameter for code (token) - Refine a search for Observation resources by LOINC code, SNOMED code, flowsheet row IDs, or SmartData Identifiers
    # + date - Search parameter for date (date) - Refine a search for Observation resources by specifying a date or date range that an Observation was resulted or recorded
    # + focus - Search parameter for focus (reference) - Refine a search for Observation resources by specifying a Reference associated with the Observation
    # + issued - Search parameter for issued (date) - Refine a search for Observation resources by specifying a date or date range that an Observation was made available
    # + patient - Search parameter for patient (reference) - Search for Observation resources for a specified patient ID
    # + subject - Search parameter for subject (reference) - Search for Observation resources for a specified patient ID
    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + combo_code - Search parameter for combo-code (token) - 
    # + combo_data_absent_reason - Search parameter for combo-data-absent-reason (token) - 
    # + combo_value_concept - Search parameter for combo-value-concept (token) - 
    # + component_code - Search parameter for component-code (token) - 
    # + component_data_absent_reason - Search parameter for component-data-absent-reason (token) - 
    # + component_value_concept - Search parameter for component-value-concept (token) - 
    # + data_absent_reason - Search parameter for data-absent-reason (token) - 
    # + derived_from - Search parameter for derived-from (reference) - 
    # + device - Search parameter for device (reference) - 
    # + encounter - Search parameter for encounter (reference) - 
    # + has_member - Search parameter for has-member (reference) - 
    # + identifier - Search parameter for identifier (token) - 
    # + method - Search parameter for method (token) - 
    # + part_of - Search parameter for part-of (reference) - 
    # + performer - Search parameter for performer (reference) - 
    # + specimen - Search parameter for specimen (reference) - 
    # + status - Search parameter for status (token) - 
    # + value_concept - Search parameter for value-concept (token) - 
    # + value_date - Search parameter for value-date (date) - 
    # + value_string - Search parameter for value-string (string) - 
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Observation resources"}
    remote isolated function searchObservation(
            string? based_on = (),
            string? category = (),
            string? code = (),
            string? date = (),
            string? focus = (),
            string? issued = (),
            string? patient = (),
            string? subject = (),
            string? _count = (),
            string? _id = (),
            string? combo_code = (),
            string? combo_data_absent_reason = (),
            string? combo_value_concept = (),
            string? component_code = (),
            string? component_data_absent_reason = (),
            string? component_value_concept = (),
            string? data_absent_reason = (),
            string? derived_from = (),
            string? device = (),
            string? encounter = (),
            string? has_member = (),
            string? identifier = (),
            string? method = (),
            string? part_of = (),
            string? performer = (),
            string? specimen = (),
            string? status = (),
            string? value_concept = (),
            string? value_date = (),
            string? value_string = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "based-on", based_on);
        addIfPresent(params, "category", category);
        addIfPresent(params, "code", code);
        addIfPresent(params, "date", date);
        addIfPresent(params, "focus", focus);
        addIfPresent(params, "issued", issued);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "subject", subject);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "combo-code", combo_code);
        addIfPresent(params, "combo-data-absent-reason", combo_data_absent_reason);
        addIfPresent(params, "combo-value-concept", combo_value_concept);
        addIfPresent(params, "component-code", component_code);
        addIfPresent(params, "component-data-absent-reason", component_data_absent_reason);
        addIfPresent(params, "component-value-concept", component_value_concept);
        addIfPresent(params, "data-absent-reason", data_absent_reason);
        addIfPresent(params, "derived-from", derived_from);
        addIfPresent(params, "device", device);
        addIfPresent(params, "encounter", encounter);
        addIfPresent(params, "has-member", has_member);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "method", method);
        addIfPresent(params, "part-of", part_of);
        addIfPresent(params, "performer", performer);
        addIfPresent(params, "specimen", specimen);
        addIfPresent(params, "status", status);
        addIfPresent(params, "value-concept", value_concept);
        addIfPresent(params, "value-date", value_date);
        addIfPresent(params, "value-string", value_string);

        return self.fhirConnectorObj->search("Observation", mode = fhirClient:POST, searchParameters = params);
    }

    # + updatedObservation - A new or updated instance of the Observation resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Update Observation resource"}
    remote function updateObservation(healthFhirR4Uscore610:USCorePediatricHeadOccipitalFrontalCircumferencePercentileProfile|healthFhirR4Uscore610:USCorePediatricBMIforAgeObservationProfile|healthFhirR4Uscore610:USCorePediatricWeightForHeightObservationProfile|healthFhirR4Uscore610:USCoreBloodPressureProfile|healthFhirR4Uscore610:USCoreBMIProfile|healthFhirR4Uscore610:USCoreBodyHeightProfile|healthFhirR4Uscore610:USCoreBodyTemperatureProfile|healthFhirR4Uscore610:USCoreBodyWeightProfile|healthFhirR4Uscore610:USCoreHeadCircumferenceProfile|healthFhirR4Uscore610:USCoreHeartRateProfile|healthFhirR4Uscore610:USCoreObservationClinicalResultProfile|healthFhirR4Uscore610:USCoreLaboratoryResultObservationProfile|healthFhirR4Uscore610:USCoreObservationOccupationProfile|healthFhirR4Uscore610:USCoreObservationPregnancyIntentProfile|healthFhirR4Uscore610:USCoreObservationPregnancyStatusProfile|healthFhirR4Uscore610:USCoreObservationScreeningAssessmentProfile|healthFhirR4Uscore610:USCoreObservationSexualOrientationProfile|healthFhirR4Uscore610:USCorePulseOximetryProfile|healthFhirR4Uscore610:USCoreRespiratoryRateProfile|healthFhirR4Uscore610:USCoreSimpleObservationProfile|healthFhirR4Uscore610:USCoreSmokingStatusProfile|healthFhirR4Uscore610:USCoreVitalSignsProfile updatedObservation)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->update(updatedObservation.toJson());
    }

    # + id - The logical ID of the Organization resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Organization by the logical ID"}
    remote function getOrganizationById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Organization", id);
    }

    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Organization resources"}
    remote isolated function searchOrganization(
            string? _count = (),
            string? _id = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);

        return self.fhirConnectorObj->search("Organization", mode = fhirClient:POST, searchParameters = params);
    }

        # + newPatient - A new instance of the Patient resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Create Patient resource"}
    remote function createPatient(healthFhirR4Uscore610:USCorePatientProfile newPatient)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->create(newPatient.toJson());
    }

# + id - The logical ID of the Patient resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Patient by the logical ID"}
    remote function getPatientById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Patient", id);
    }

    # + address - Search parameter for address (string) - Search for Patient resources using an address string
    # + address_city - Search parameter for address-city (string) - Search for Patient resources using the city for a patient's home address
    # + address_postalcode - Search parameter for address-postalcode (string) - Search for Patient resources using the postal code for a patient's home address
    # + address_state - Search parameter for address-state (string) - Search for Patient resources using the state for a patient's home address
    # + birthdate - Search parameter for birthdate (date) - Search for Patient resources using a date of birth in ISO format (YYYY-MM-DD)
    # + doc_type - Search parameter for doc-type (token) - Search for Patient resources using Singapore document type
    # + family - Search parameter for family (string) - Search for Patient resources by family (last) name
    # + gender - Search parameter for gender (token) - Search for Patient resources using the following gender codes: female, male, other, or unknown
    # + given - Search parameter for given (string) - Search for Patient resources by given (first) name
    # + identifier - Search parameter for identifier (token) - Search for Patient resources by a patient's identifier
    # + legal_sex - Search parameter for legal-sex (token) - Search for Patient resources using the following gender codes: female, male, nonbinary, x, other, or unknown
    # + name - Search parameter for name (string) - Search for Patient resources by a patient's name
    # + own_name - Search parameter for own-name (string) - Search for Patient resources by patient's own last name, usually used in non-US names
    # + own_prefix - Search parameter for own-prefix (string) - Search for Patient resources by patient's own last name prefix, usually used in non-US names
    # + partner_name - Search parameter for partner-name (string) - Search for Patient resources by patient's spouse's last name, usually used in non-US names
    # + partner_prefix - Search parameter for partner-prefix (string) - Search for Patient resources by patient's spouse's last name prefix, usually used in non-US names
    # + telecom - Search parameter for telecom (token) - Search for Patient resources using a patient's home phone number, cell phone number, or email address
    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + active - Search parameter for active (token) - 
    # + address_country - Search parameter for address-country (string) - 
    # + address_use - Search parameter for address-use (token) - 
    # + death_date - Search parameter for death-date (date) - 
    # + email - Search parameter for email (token) - 
    # + general_practitioner - Search parameter for general-practitioner (reference) - 
    # + language - Search parameter for language (token) - 
    # + link - Search parameter for link (reference) - 
    # + organization - Search parameter for organization (reference) - 
    # + phone - Search parameter for phone (token) - 
    # + phonetic - Search parameter for phonetic (string) - 
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Patient resources"}
    remote isolated function searchPatient(
            string? address = (),
            string? address_city = (),
            string? address_postalcode = (),
            string? address_state = (),
            string? birthdate = (),
            string? doc_type = (),
            string? family = (),
            string? gender = (),
            string? given = (),
            string? identifier = (),
            string? legal_sex = (),
            string? name = (),
            string? own_name = (),
            string? own_prefix = (),
            string? partner_name = (),
            string? partner_prefix = (),
            string? telecom = (),
            string? _count = (),
            string? _id = (),
            string? active = (),
            string? address_country = (),
            string? address_use = (),
            string? death_date = (),
            string? email = (),
            string? general_practitioner = (),
            string? language = (),
            string? link = (),
            string? organization = (),
            string? phone = (),
            string? phonetic = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "address", address);
        addIfPresent(params, "address-city", address_city);
        addIfPresent(params, "address-postalcode", address_postalcode);
        addIfPresent(params, "address-state", address_state);
        addIfPresent(params, "birthdate", birthdate);
        addIfPresent(params, "doc-type", doc_type);
        addIfPresent(params, "family", family);
        addIfPresent(params, "gender", gender);
        addIfPresent(params, "given", given);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "legal-sex", legal_sex);
        addIfPresent(params, "name", name);
        addIfPresent(params, "own-name", own_name);
        addIfPresent(params, "own-prefix", own_prefix);
        addIfPresent(params, "partner-name", partner_name);
        addIfPresent(params, "partner-prefix", partner_prefix);
        addIfPresent(params, "telecom", telecom);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "active", active);
        addIfPresent(params, "address-country", address_country);
        addIfPresent(params, "address-use", address_use);
        addIfPresent(params, "death-date", death_date);
        addIfPresent(params, "email", email);
        addIfPresent(params, "general-practitioner", general_practitioner);
        addIfPresent(params, "language", language);
        addIfPresent(params, "link", link);
        addIfPresent(params, "organization", organization);
        addIfPresent(params, "phone", phone);
        addIfPresent(params, "phonetic", phonetic);

        return self.fhirConnectorObj->search("Patient", mode = fhirClient:POST, searchParameters = params);
    }

remote function matchPatientOperation(@display {label: "Request Mode"} fhirClient:RequestMode mode = fhirClient:POST,
                                                                             @display {label: "Logical ID"} string? id = (),
                                                                             @display {label: "Query Parameters"} map<string[]>? queryParameters = (),
                                                                             @display {label: "Resource data"} json|xml? data = ())
        returns fhirClient:FHIRResponse|fhirClient:FHIRError {
    return check self.fhirConnectorObj->callOperation("Patient", "$match", mode, id, queryParameters, data);
}

remote function summaryPatientOperation(@display {label: "Request Mode"} fhirClient:RequestMode mode = fhirClient:POST,
                                                                             @display {label: "Logical ID"} string? id = (),
                                                                             @display {label: "Query Parameters"} map<string[]>? queryParameters = (),
                                                                             @display {label: "Resource data"} json|xml? data = ())
        returns fhirClient:FHIRResponse|fhirClient:FHIRError {
    return check self.fhirConnectorObj->callOperation("Patient", "$summary", mode, id, queryParameters, data);
}

    # + id - The logical ID of the Practitioner resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Practitioner by the logical ID"}
    remote function getPractitionerById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Practitioner", id);
    }

    # + address - Search parameter for address (string) - Any part of an address (street, city, etc
    # + address_city - Search parameter for address-city (string) - The city where a practitioner can be visited
    # + address_postalcode - Search parameter for address-postalcode (string) - The zip code where a practitioner can be found
    # + address_state - Search parameter for address-state (string) - The state where a practitioner can be found
    # + family - Search parameter for family (string) - A practitioner's family (last) name
    # + given - Search parameter for given (string) - A practitioner's given (first) name
    # + identifier - Search parameter for identifier (token) - A practitioner's identifier in the format <code system>|<code>
    # + name - Search parameter for name (string) - Any part of a practitioner's name
    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + active - Search parameter for active (token) - 
    # + address_country - Search parameter for address-country (string) - 
    # + address_use - Search parameter for address-use (token) - 
    # + communication - Search parameter for communication (token) - 
    # + email - Search parameter for email (token) - 
    # + gender - Search parameter for gender (token) - 
    # + phone - Search parameter for phone (token) - 
    # + phonetic - Search parameter for phonetic (string) - 
    # + telecom - Search parameter for telecom (token) - 
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Practitioner resources"}
    remote isolated function searchPractitioner(
            string? address = (),
            string? address_city = (),
            string? address_postalcode = (),
            string? address_state = (),
            string? family = (),
            string? given = (),
            string? identifier = (),
            string? name = (),
            string? _count = (),
            string? _id = (),
            string? active = (),
            string? address_country = (),
            string? address_use = (),
            string? communication = (),
            string? email = (),
            string? gender = (),
            string? phone = (),
            string? phonetic = (),
            string? telecom = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "address", address);
        addIfPresent(params, "address-city", address_city);
        addIfPresent(params, "address-postalcode", address_postalcode);
        addIfPresent(params, "address-state", address_state);
        addIfPresent(params, "family", family);
        addIfPresent(params, "given", given);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "name", name);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "active", active);
        addIfPresent(params, "address-country", address_country);
        addIfPresent(params, "address-use", address_use);
        addIfPresent(params, "communication", communication);
        addIfPresent(params, "email", email);
        addIfPresent(params, "gender", gender);
        addIfPresent(params, "phone", phone);
        addIfPresent(params, "phonetic", phonetic);
        addIfPresent(params, "telecom", telecom);

        return self.fhirConnectorObj->search("Practitioner", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the PractitionerRole resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get PractitionerRole by the logical ID"}
    remote function getPractitionerRoleById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("PractitionerRole", id);
    }

    # + email - Search parameter for email (token) - Refine a search for a PractitionerRole by entering a valid email address
    # + identifier - Search parameter for identifier (token) - Search for PractitionerRoles using identifiers
    # + location - Search parameter for location (reference) - Search for PractitionerRoles using a Location ID
    # + organization - Search parameter for organization (reference) - Search for PractitionerRoles using an Organization ID
    # + phone - Search parameter for phone (token) - Refine a search for a PractitionerRole by entering a valid phone number
    # + practitioner - Search parameter for practitioner (reference) - Search for PractitionerRoles for a specified Practitioner ID
    # + role - Search parameter for role (token) - Refine a search for a PractitionerRole by entering a valid role
    # + specialty - Search parameter for specialty (token) - Search for PractitionerRoles for a given specialty
    # + telecom - Search parameter for telecom (token) - Refine a search for a PractitionerRole for a specific telecom
    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + active - Search parameter for active (token) - 
    # + date - Search parameter for date (date) - 
    # + endpoint - Search parameter for endpoint (reference) - 
    # + 'service - Search parameter for service (reference) - 
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search PractitionerRole resources"}
    remote isolated function searchPractitionerRole(
            string? email = (),
            string? identifier = (),
            string? location = (),
            string? organization = (),
            string? phone = (),
            string? practitioner = (),
            string? role = (),
            string? specialty = (),
            string? telecom = (),
            string? _count = (),
            string? _id = (),
            string? active = (),
            string? date = (),
            string? endpoint = (),
            string? 'service = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "email", email);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "location", location);
        addIfPresent(params, "organization", organization);
        addIfPresent(params, "phone", phone);
        addIfPresent(params, "practitioner", practitioner);
        addIfPresent(params, "role", role);
        addIfPresent(params, "specialty", specialty);
        addIfPresent(params, "telecom", telecom);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "active", active);
        addIfPresent(params, "date", date);
        addIfPresent(params, "endpoint", endpoint);
        addIfPresent(params, "service", 'service);

        return self.fhirConnectorObj->search("PractitionerRole", mode = fhirClient:POST, searchParameters = params);
    }

        # + newProcedure - A new instance of the Procedure resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Create Procedure resource"}
    remote function createProcedure(healthFhirR4Uscore610:USCoreProcedureProfile newProcedure)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->create(newProcedure.toJson());
    }

# + id - The logical ID of the Procedure resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Procedure by the logical ID"}
    remote function getProcedureById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Procedure", id);
    }

    # + category - Search parameter for category (token) - Refine a search for Procedure resources by category
    # + code - Search parameter for code (token) - Refine a search for Procedure based on code
    # + date - Search parameter for date (date) - Refine a search for Procedure resources by specifying a date or date range that a Procedure was resulted
    # + identifier - Search parameter for identifier (token) - Refine a search for Procedure by identifier
    # + patient - Search parameter for patient (reference) - Search for Procedure resources for a specified patient ID
    # + subject - Search parameter for subject (reference) - Search for Procedure resources for a specified patient ID
    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + based_on - Search parameter for based-on (reference) - 
    # + encounter - Search parameter for encounter (reference) - 
    # + instantiates_canonical - Search parameter for instantiates-canonical (reference) - 
    # + location - Search parameter for location (reference) - 
    # + part_of - Search parameter for part-of (reference) - 
    # + performer - Search parameter for performer (reference) - 
    # + reason_code - Search parameter for reason-code (token) - 
    # + reason_reference - Search parameter for reason-reference (reference) - 
    # + status - Search parameter for status (token) - 
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Procedure resources"}
    remote isolated function searchProcedure(
            string? category = (),
            string? code = (),
            string? date = (),
            string? identifier = (),
            string? patient = (),
            string? subject = (),
            string? _count = (),
            string? _id = (),
            string? based_on = (),
            string? encounter = (),
            string? instantiates_canonical = (),
            string? location = (),
            string? part_of = (),
            string? performer = (),
            string? reason_code = (),
            string? reason_reference = (),
            string? status = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "category", category);
        addIfPresent(params, "code", code);
        addIfPresent(params, "date", date);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "subject", subject);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "based-on", based_on);
        addIfPresent(params, "encounter", encounter);
        addIfPresent(params, "instantiates-canonical", instantiates_canonical);
        addIfPresent(params, "location", location);
        addIfPresent(params, "part-of", part_of);
        addIfPresent(params, "performer", performer);
        addIfPresent(params, "reason-code", reason_code);
        addIfPresent(params, "reason-reference", reason_reference);
        addIfPresent(params, "status", status);

        return self.fhirConnectorObj->search("Procedure", mode = fhirClient:POST, searchParameters = params);
    }

    # + updatedProcedure - A new or updated instance of the Procedure resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Update Procedure resource"}
    remote function updateProcedure(healthFhirR4Uscore610:USCoreProcedureProfile updatedProcedure)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->update(updatedProcedure.toJson());
    }

    # + id - The logical ID of the Provenance resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Provenance by the logical ID"}
    remote function getProvenanceById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Provenance", id);
    }

    # + id - The logical ID of the Questionnaire resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Questionnaire by the logical ID"}
    remote function getQuestionnaireById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Questionnaire", id);
    }

    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Questionnaire resources"}
    remote isolated function searchQuestionnaire(
            string? _count = (),
            string? _id = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);

        return self.fhirConnectorObj->search("Questionnaire", mode = fhirClient:POST, searchParameters = params);
    }

        # + newQuestionnaireResponse - A new instance of the QuestionnaireResponse resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Create QuestionnaireResponse resource"}
    remote function createQuestionnaireResponse(resourceInternational:QuestionnaireResponse newQuestionnaireResponse)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->create(newQuestionnaireResponse.toJson());
    }

# + id - The logical ID of the QuestionnaireResponse resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get QuestionnaireResponse by the logical ID"}
    remote function getQuestionnaireResponseById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("QuestionnaireResponse", id);
    }

    # + encounter - Search parameter for encounter (reference) - Search for QuestionnaireResponses by encounter
    # + patient - Search parameter for patient (reference) - Search for QuestionnaireResponses for a specified patient
    # + subject - Search parameter for subject (reference) - Search for QuestionnaireResponses for a specified patient or research subject
    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + author - Search parameter for author (reference) - 
    # + authored - Search parameter for authored (date) - 
    # + based_on - Search parameter for based-on (reference) - 
    # + identifier - Search parameter for identifier (token) - 
    # + part_of - Search parameter for part-of (reference) - 
    # + questionnaire - Search parameter for questionnaire (reference) - 
    # + 'source - Search parameter for source (reference) - 
    # + status - Search parameter for status (token) - 
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search QuestionnaireResponse resources"}
    remote isolated function searchQuestionnaireResponse(
            string? encounter = (),
            string? patient = (),
            string? subject = (),
            string? _count = (),
            string? _id = (),
            string? author = (),
            string? authored = (),
            string? based_on = (),
            string? identifier = (),
            string? part_of = (),
            string? questionnaire = (),
            string? 'source = (),
            string? status = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "encounter", encounter);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "subject", subject);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "author", author);
        addIfPresent(params, "authored", authored);
        addIfPresent(params, "based-on", based_on);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "part-of", part_of);
        addIfPresent(params, "questionnaire", questionnaire);
        addIfPresent(params, "source", 'source);
        addIfPresent(params, "status", status);

        return self.fhirConnectorObj->search("QuestionnaireResponse", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the RelatedPerson resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get RelatedPerson by the logical ID"}
    remote function getRelatedPersonById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("RelatedPerson", id);
    }

    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search RelatedPerson resources"}
    remote isolated function searchRelatedPerson(
            string? _count = (),
            string? _id = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);

        return self.fhirConnectorObj->search("RelatedPerson", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the RequestGroup resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get RequestGroup by the logical ID"}
    remote function getRequestGroupById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("RequestGroup", id);
    }

    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search RequestGroup resources"}
    remote isolated function searchRequestGroup(
            string? _count = (),
            string? _id = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);

        return self.fhirConnectorObj->search("RequestGroup", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the ResearchStudy resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get ResearchStudy by the logical ID"}
    remote function getResearchStudyById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("ResearchStudy", id);
    }

    # + identifier - Search parameter for identifier (token) - Search for the ResearchStudy resource for a specified study code or NCT number
    # + status - Search parameter for status (token) - Search for the ResearchStudy resource for a specified status
    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + category - Search parameter for category (token) - 
    # + date - Search parameter for date (date) - 
    # + focus - Search parameter for focus (token) - 
    # + keyword - Search parameter for keyword (token) - 
    # + location - Search parameter for location (token) - 
    # + partof - Search parameter for partof (reference) - 
    # + principalinvestigator - Search parameter for principalinvestigator (reference) - 
    # + protocol - Search parameter for protocol (reference) - 
    # + site - Search parameter for site (reference) - 
    # + sponsor - Search parameter for sponsor (reference) - 
    # + title - Search parameter for title (string) - 
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search ResearchStudy resources"}
    remote isolated function searchResearchStudy(
            string? identifier = (),
            string? status = (),
            string? _count = (),
            string? _id = (),
            string? category = (),
            string? date = (),
            string? focus = (),
            string? keyword = (),
            string? location = (),
            string? partof = (),
            string? principalinvestigator = (),
            string? protocol = (),
            string? site = (),
            string? sponsor = (),
            string? title = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "status", status);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "category", category);
        addIfPresent(params, "date", date);
        addIfPresent(params, "focus", focus);
        addIfPresent(params, "keyword", keyword);
        addIfPresent(params, "location", location);
        addIfPresent(params, "partof", partof);
        addIfPresent(params, "principalinvestigator", principalinvestigator);
        addIfPresent(params, "protocol", protocol);
        addIfPresent(params, "site", site);
        addIfPresent(params, "sponsor", sponsor);
        addIfPresent(params, "title", title);

        return self.fhirConnectorObj->search("ResearchStudy", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the ResearchSubject resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get ResearchSubject by the logical ID"}
    remote function getResearchSubjectById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("ResearchSubject", id);
    }

    # + patient - Search parameter for patient (reference) - Search for the ResearchSubject resources related to a specified patient
    # + status - Search parameter for status (token) - Search for the ResearchSubject resources for a specified status
    # + study - Search parameter for study (reference) - Search for the ResearchSubject resources related to a specified study
    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + date - Search parameter for date (date) - 
    # + identifier - Search parameter for identifier (token) - 
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search ResearchSubject resources"}
    remote isolated function searchResearchSubject(
            string? patient = (),
            string? status = (),
            string? study = (),
            string? _count = (),
            string? _id = (),
            string? date = (),
            string? identifier = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "status", status);
        addIfPresent(params, "study", study);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "date", date);
        addIfPresent(params, "identifier", identifier);

        return self.fhirConnectorObj->search("ResearchSubject", mode = fhirClient:POST, searchParameters = params);
    }

        # + newServiceRequest - A new instance of the ServiceRequest resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Create ServiceRequest resource"}
    remote function createServiceRequest(healthFhirR4Uscore610:USCoreServiceRequestProfile newServiceRequest)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->create(newServiceRequest.toJson());
    }

# + id - The logical ID of the ServiceRequest resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get ServiceRequest by the logical ID"}
    remote function getServiceRequestById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("ServiceRequest", id);
    }

    # + authored - Search parameter for authored (date) - Refine a search for ServiceRequests for a particular date and time
    # + category - Search parameter for category (token) - Refine a search for ServiceRequests of a particular category
    # + code - Search parameter for code (token) - Refine a search for ServiceRequest based on code
    # + encounter - Search parameter for encounter (reference) - Search for ServiceRequest resources for specific encounters
    # + identifier - Search parameter for identifier (token) - Refine a search for ServiceRequest by identifier
    # + onlyscannable - Search parameter for onlyscannable (token) - Refine a search for ServiceRequest resources to scannable only
    # + patient - Search parameter for patient (reference) - Search ServiceRequest resources for a specified patient ID
    # + requester - Search parameter for requester (reference) - Refine a search for ServiceRequest resources by individual making the request
    # + status - Search parameter for status (token) - Refine a search for ServiceRequest resources by status
    # + subject - Search parameter for subject (reference) - Search ServiceRequest resources for a specified patient ID
    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + based_on - Search parameter for based-on (reference) - 
    # + body_site - Search parameter for body-site (token) - 
    # + instantiates_canonical - Search parameter for instantiates-canonical (reference) - 
    # + intent - Search parameter for intent (token) - 
    # + occurrence - Search parameter for occurrence (date) - 
    # + performer - Search parameter for performer (reference) - 
    # + performer_type - Search parameter for performer-type (token) - 
    # + priority - Search parameter for priority (token) - 
    # + replaces - Search parameter for replaces (reference) - 
    # + requisition - Search parameter for requisition (token) - 
    # + specimen - Search parameter for specimen (reference) - 
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search ServiceRequest resources"}
    remote isolated function searchServiceRequest(
            string? authored = (),
            string? category = (),
            string? code = (),
            string? encounter = (),
            string? identifier = (),
            string? onlyscannable = (),
            string? patient = (),
            string? requester = (),
            string? status = (),
            string? subject = (),
            string? _count = (),
            string? _id = (),
            string? based_on = (),
            string? body_site = (),
            string? instantiates_canonical = (),
            string? intent = (),
            string? occurrence = (),
            string? performer = (),
            string? performer_type = (),
            string? priority = (),
            string? replaces = (),
            string? requisition = (),
            string? specimen = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "authored", authored);
        addIfPresent(params, "category", category);
        addIfPresent(params, "code", code);
        addIfPresent(params, "encounter", encounter);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "onlyscannable", onlyscannable);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "requester", requester);
        addIfPresent(params, "status", status);
        addIfPresent(params, "subject", subject);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "based-on", based_on);
        addIfPresent(params, "body-site", body_site);
        addIfPresent(params, "instantiates-canonical", instantiates_canonical);
        addIfPresent(params, "intent", intent);
        addIfPresent(params, "occurrence", occurrence);
        addIfPresent(params, "performer", performer);
        addIfPresent(params, "performer-type", performer_type);
        addIfPresent(params, "priority", priority);
        addIfPresent(params, "replaces", replaces);
        addIfPresent(params, "requisition", requisition);
        addIfPresent(params, "specimen", specimen);

        return self.fhirConnectorObj->search("ServiceRequest", mode = fhirClient:POST, searchParameters = params);
    }

    # + updatedServiceRequest - A new or updated instance of the ServiceRequest resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Update ServiceRequest resource"}
    remote function updateServiceRequest(healthFhirR4Uscore610:USCoreServiceRequestProfile updatedServiceRequest)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->update(updatedServiceRequest.toJson());
    }

    # + id - The logical ID of the Specimen resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Specimen by the logical ID"}
    remote function getSpecimenById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Specimen", id);
    }

    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Specimen resources"}
    remote isolated function searchSpecimen(
            string? _count = (),
            string? _id = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);

        return self.fhirConnectorObj->search("Specimen", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the Substance resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Substance by the logical ID"}
    remote function getSubstanceById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Substance", id);
    }

    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Substance resources"}
    remote isolated function searchSubstance(
            string? _count = (),
            string? _id = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);

        return self.fhirConnectorObj->search("Substance", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the Task resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Task by the logical ID"}
    remote function getTaskById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Task", id);
    }

    # + code - Search parameter for code (token) - Specify community-resource for CRRN tasks, episode-checklist for Episode Checklist tasks
    # + encounter - Search parameter for encounter (reference) - Further refine the search for a task by specifying the encounter associated with the task
    # + focus - Search parameter for focus (reference) - 
    # + patient - Search parameter for patient (reference) - Search for Task resources for a specified patient ID
    # + status - Search parameter for status (token) - Restrict the search for tasks based on task status
    # + subject - Search parameter for subject (reference) - Search for Task resources for a specified patient ID
    # + _count - Search parameter for _count (number) - Number of results per page
    # + _id - Search parameter for _id (token) - FHIR resource IDs for the desired resources
    # + authored_on - Search parameter for authored-on (date) - 
    # + based_on - Search parameter for based-on (reference) - 
    # + business_status - Search parameter for business-status (token) - 
    # + group_identifier - Search parameter for group-identifier (token) - 
    # + identifier - Search parameter for identifier (token) - 
    # + intent - Search parameter for intent (token) - 
    # + modified - Search parameter for modified (date) - 
    # + owner - Search parameter for owner (reference) - 
    # + part_of - Search parameter for part-of (reference) - 
    # + performer - Search parameter for performer (token) - 
    # + period - Search parameter for period (date) - 
    # + priority - Search parameter for priority (token) - 
    # + requester - Search parameter for requester (reference) - 
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Task resources"}
    remote isolated function searchTask(
            string? code = (),
            string? encounter = (),
            string? focus = (),
            string? patient = (),
            string? status = (),
            string? subject = (),
            string? _count = (),
            string? _id = (),
            string? authored_on = (),
            string? based_on = (),
            string? business_status = (),
            string? group_identifier = (),
            string? identifier = (),
            string? intent = (),
            string? modified = (),
            string? owner = (),
            string? part_of = (),
            string? performer = (),
            string? period = (),
            string? priority = (),
            string? requester = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "code", code);
        addIfPresent(params, "encounter", encounter);
        addIfPresent(params, "focus", focus);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "status", status);
        addIfPresent(params, "subject", subject);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "authored-on", authored_on);
        addIfPresent(params, "based-on", based_on);
        addIfPresent(params, "business-status", business_status);
        addIfPresent(params, "group-identifier", group_identifier);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "intent", intent);
        addIfPresent(params, "modified", modified);
        addIfPresent(params, "owner", owner);
        addIfPresent(params, "part-of", part_of);
        addIfPresent(params, "performer", performer);
        addIfPresent(params, "period", period);
        addIfPresent(params, "priority", priority);
        addIfPresent(params, "requester", requester);

        return self.fhirConnectorObj->search("Task", mode = fhirClient:POST, searchParameters = params);
    }

    # + updatedTask - A new or updated instance of the Task resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Update Task resource"}
    remote function updateTask(resourceInternational:Task updatedTask)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->update(updatedTask.toJson());
    }

}
