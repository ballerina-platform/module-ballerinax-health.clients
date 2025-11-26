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
import ballerinax/health.fhir.r4.uscore700 as healthFhirR4Uscore700;


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

    # + id - The logical ID of the CapabilityStatement resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get CapabilityStatement by the logical ID"}
    remote function getCapabilityStatementById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("CapabilityStatement", id);
    }

    # + id - The logical ID of the Account resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Account by the logical ID"}
    remote function getAccountById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Account", id);
    }

    # + _id - Search parameter for _id (token) - A single or comma separated list of Account ids
    # + patient - Search parameter for patient (reference) - The entity that caused the expenses
    # + _encounter - Search parameter for -encounter (reference) - The encounter associated with the resource
    # + _guarantor - Search parameter for -guarantor (reference) - The entity that responsible for payment
    # + 'type - Search parameter for type (token) - The identifier for the account
    # + identifier - Search parameter for identifier (token) - Statement Account number
    # + _count - Search parameter for _count (number) - The maximum number of results to return in a page
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Account resources"}
    remote function searchAccount(
            string? _id = (),
            string? patient = (),
            string? _encounter = (),
            string? _guarantor = (),
            string? 'type = (),
            string? identifier = (),
            string? _count = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "-encounter", _encounter);
        addIfPresent(params, "-guarantor", _guarantor);
        addIfPresent(params, "type", 'type);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "_count", _count);

        return self.fhirConnectorObj->search("Account", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the AllergyIntolerance resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get AllergyIntolerance by the logical ID"}
    remote function getAllergyIntoleranceById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("AllergyIntolerance", id);
    }

    # + _id - Search parameter for _id (token) - A single or comma separated list of AllergyIntolerance ids
    # + patient - Search parameter for patient (reference) - Who the sensitivity is for
    # + clinical_status - Search parameter for clinical-status (token) - Certainty of the allergy or intolerance
    # + _lastUpdated - Search parameter for _lastUpdated (date) - A date or date range used to search for AllergyIntolerance records which were last updated in that period
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search AllergyIntolerance resources"}
    remote function searchAllergyIntolerance(
            string? _id = (),
            string? patient = (),
            string? clinical_status = (),
            string[]? _lastUpdated = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "clinical-status", clinical_status);
        addIfPresent(params, "_lastUpdated", _lastUpdated);

        return self.fhirConnectorObj->search("AllergyIntolerance", mode = fhirClient:POST, searchParameters = params);
    }

    # + newAllergyIntolerance - A new instance of the AllergyIntolerance resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Create AllergyIntolerance resource"}
    remote function createAllergyIntolerance(healthFhirR4Uscore700:USCoreAllergyIntolerance newAllergyIntolerance)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->create(newAllergyIntolerance.toJson());
    }

    # + updatedAllergyIntolerance - A new or updated instance of the AllergyIntolerance resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Update AllergyIntolerance resource"}
    remote function updateAllergyIntolerance(healthFhirR4Uscore700:USCoreAllergyIntolerance updatedAllergyIntolerance)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->update(updatedAllergyIntolerance.toJson());
    }

    # + id - The logical ID of the Appointment resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Appointment by the logical ID"}
    remote function getAppointmentById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Appointment", id);
    }

    # + _id - Search parameter for _id (token) - A single or comma separated list of Appointment ids
    # + _count - Search parameter for _count (number) - The maximum number of results to return in a page
    # + date - Search parameter for date (date) - A date or date range from which to find appointments
    # + _date_or_req_period - Search parameter for -date-or-req-period (date) - A start date or requested period from which to find appointments
    # + patient - Search parameter for patient (reference) - One of the individuals of the appointment is this patient
    # + practitioner - Search parameter for practitioner (reference) - One of the individuals of the appointment is this practitioner
    # + location - Search parameter for location (reference) - This location is listed in the participants of the appointment
    # + status - Search parameter for status (token) - The overall status of the appointment
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Appointment resources"}
    remote function searchAppointment(
            string? _id = (),
            string? _count = (),
            string? date = (),
            string? _date_or_req_period = (),
            string? patient = (),
            string? practitioner = (),
            string? location = (),
            string? status = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "date", date);
        addIfPresent(params, "-date-or-req-period", _date_or_req_period);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "practitioner", practitioner);
        addIfPresent(params, "location", location);
        addIfPresent(params, "status", status);

        return self.fhirConnectorObj->search("Appointment", mode = fhirClient:POST, searchParameters = params);
    }

    # + newAppointment - A new instance of the Appointment resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Create Appointment resource"}
    remote function createAppointment(resourceInternational:Appointment newAppointment)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->create(newAppointment.toJson());
    }

    # + id - The logical ID of the Appointment resource
    # + patchAppointment - An updated instance of the Appointment resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Patch Appointment resource"}
    remote function patchAppointment(string id, resourceInternational:Appointment patchAppointment)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->patch("Appointment", patchAppointment.toJson(), id);
    }

        # + newBasic - A new instance of the Basic resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Create Basic resource"}
    remote function createBasic(resourceInternational:Basic newBasic)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->create(newBasic.toJson());
    }

    # + id - The logical ID of the Binary resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Binary by the logical ID"}
    remote function getBinaryById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Binary", id);
    }

remote function autogenCcdIfBinaryOperation(@display {label: "Request Mode"} fhirClient:RequestMode mode = fhirClient:POST,
                                                                             @display {label: "Logical ID"} string? id = (),
                                                                             @display {label: "Query Parameters"} map<string[]>? queryParameters = (),
                                                                             @display {label: "Resource data"} json|xml? data = ())
        returns fhirClient:FHIRResponse|fhirClient:FHIRError {
    return check self.fhirConnectorObj->callOperation("Binary", "$autogen-ccd-if", mode, id, queryParameters, data);
}

    # + id - The logical ID of the CarePlan resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get CarePlan by the logical ID"}
    remote function getCarePlanById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("CarePlan", id);
    }

    # + _id - Search parameter for _id (token) - A single or comma separated list of CarePlan ids
    # + date - Search parameter for date (date) - A date range with which to find CarePlans
    # + patient - Search parameter for patient (reference) - Who the careplan is for
    # + category - Search parameter for category (token) - The category of the careplan
    # + _count - Search parameter for _count (number) - The maximum number of results to return
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search CarePlan resources"}
    remote function searchCarePlan(
            string? _id = (),
            string? date = (),
            string? patient = (),
            string? category = (),
            string? _count = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "date", date);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "category", category);
        addIfPresent(params, "_count", _count);

        return self.fhirConnectorObj->search("CarePlan", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the CareTeam resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get CareTeam by the logical ID"}
    remote function getCareTeamById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("CareTeam", id);
    }

    # + _id - Search parameter for _id (token) - CareTeam id supports only the single id
    # + category - Search parameter for category (token) - The category of the careteam
    # + encounter - Search parameter for encounter (reference) - The Encounter level CareTeam are displayed
    # + patient - Search parameter for patient (reference) - Who the careteam is for
    # + status - Search parameter for status (token) - The status of the CareTeam
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search CareTeam resources"}
    remote function searchCareTeam(
            string? _id = (),
            string? category = (),
            string? encounter = (),
            string? patient = (),
            string? status = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "category", category);
        addIfPresent(params, "encounter", encounter);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "status", status);

        return self.fhirConnectorObj->search("CareTeam", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the ChargeItem resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get ChargeItem by the logical ID"}
    remote function getChargeItemById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("ChargeItem", id);
    }

    # + _id - Search parameter for _id (token) - ChargeItem id supports only the single id
    # + context - Search parameter for context (reference) - Encounter associated with the ChargeItem
    # + account - Search parameter for account (reference) - Account associated with the ChargeItem
    # + _status - Search parameter for -status (token) - The status of the ChargeItem
    # + _count - Search parameter for _count (number) - The maximum number of results to return in a page
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search ChargeItem resources"}
    remote function searchChargeItem(
            string? _id = (),
            string? context = (),
            string? account = (),
            string? _status = (),
            string? _count = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "context", context);
        addIfPresent(params, "account", account);
        addIfPresent(params, "-status", _status);
        addIfPresent(params, "_count", _count);

        return self.fhirConnectorObj->search("ChargeItem", mode = fhirClient:POST, searchParameters = params);
    }

remote function modifyChargeItemOperation(@display {label: "Request Mode"} fhirClient:RequestMode mode = fhirClient:POST,
                                                                             @display {label: "Logical ID"} string? id = (),
                                                                             @display {label: "Query Parameters"} map<string[]>? queryParameters = (),
                                                                             @display {label: "Resource data"} json|xml? data = ())
        returns fhirClient:FHIRResponse|fhirClient:FHIRError {
    return check self.fhirConnectorObj->callOperation("ChargeItem", "$modify", mode, id, queryParameters, data);
}

remote function createChargeItemOperation(@display {label: "Request Mode"} fhirClient:RequestMode mode = fhirClient:POST,
                                                                             @display {label: "Logical ID"} string? id = (),
                                                                             @display {label: "Query Parameters"} map<string[]>? queryParameters = (),
                                                                             @display {label: "Resource data"} json|xml? data = ())
        returns fhirClient:FHIRResponse|fhirClient:FHIRError {
    return check self.fhirConnectorObj->callOperation("ChargeItem", "$create", mode, id, queryParameters, data);
}

remote function creditChargeItemOperation(@display {label: "Request Mode"} fhirClient:RequestMode mode = fhirClient:POST,
                                                                             @display {label: "Logical ID"} string? id = (),
                                                                             @display {label: "Query Parameters"} map<string[]>? queryParameters = (),
                                                                             @display {label: "Resource data"} json|xml? data = ())
        returns fhirClient:FHIRResponse|fhirClient:FHIRError {
    return check self.fhirConnectorObj->callOperation("ChargeItem", "$credit", mode, id, queryParameters, data);
}

    # + id - The logical ID of the Communication resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Communication by the logical ID"}
    remote function getCommunicationById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Communication", id);
    }

    # + _id - Search parameter for _id (token) - A single or comma separated list of Communication ids
    # + category - Search parameter for category (token) - The message category
    # + received - Search parameter for received (date) - When the message is received
    # + recipient - Search parameter for recipient (reference) - The recipient of the message
    # + _email_status - Search parameter for -email-status (token) - The email status of the message
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Communication resources"}
    remote function searchCommunication(
            string? _id = (),
            string? category = (),
            string? received = (),
            string? recipient = (),
            string? _email_status = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "category", category);
        addIfPresent(params, "received", received);
        addIfPresent(params, "recipient", recipient);
        addIfPresent(params, "-email-status", _email_status);

        return self.fhirConnectorObj->search("Communication", mode = fhirClient:POST, searchParameters = params);
    }

    # + newCommunication - A new instance of the Communication resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Create Communication resource"}
    remote function createCommunication(resourceInternational:Communication newCommunication)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->create(newCommunication.toJson());
    }

    # + id - The logical ID of the Communication resource
    # + patchCommunication - An updated instance of the Communication resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Patch Communication resource"}
    remote function patchCommunication(string id, resourceInternational:Communication patchCommunication)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->patch("Communication", patchCommunication.toJson(), id);
    }

    # + id - The logical ID of the Condition resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Condition by the logical ID"}
    remote function getConditionById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Condition", id);
    }

    # + _id - Search parameter for _id (token) - A single or comma separated list of Condition ids
    # + patient - Search parameter for patient (reference) - Who has the condition
    # + encounter - Search parameter for encounter (reference) - The encounter of the patient
    # + subject - Search parameter for subject (reference) - Who has the condition
    # + clinical_status - Search parameter for clinical-status (token) - The clinical status of the condition
    # + category - Search parameter for category (token) - The category of the condition
    # + _lastUpdated - Search parameter for _lastUpdated (date) - A date or date range used to search for conditions which were last updated in that period
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Condition resources"}
    remote function searchCondition(
            string? _id = (),
            string? patient = (),
            string? encounter = (),
            string? subject = (),
            string? clinical_status = (),
            string? category = (),
            string[]? _lastUpdated = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "encounter", encounter);
        addIfPresent(params, "subject", subject);
        addIfPresent(params, "clinical-status", clinical_status);
        addIfPresent(params, "category", category);
        addIfPresent(params, "_lastUpdated", _lastUpdated);

        return self.fhirConnectorObj->search("Condition", mode = fhirClient:POST, searchParameters = params);
    }

    # + newCondition - A new instance of the Condition resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Create Condition resource"}
    remote function createCondition(resourceInternational:Condition|healthFhirR4Uscore700:USCoreConditionEncounterDiagnosisProfile|healthFhirR4Uscore700:USCoreConditionProblemsHealthConcernsProfile newCondition)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->create(newCondition.toJson());
    }

    # + updatedCondition - A new or updated instance of the Condition resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Update Condition resource"}
    remote function updateCondition(resourceInternational:Condition|healthFhirR4Uscore700:USCoreConditionEncounterDiagnosisProfile|healthFhirR4Uscore700:USCoreConditionProblemsHealthConcernsProfile updatedCondition)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->update(updatedCondition.toJson());
    }

    # + id - The logical ID of the Consent resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Consent by the logical ID"}
    remote function getConsentById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Consent", id);
    }

    # + _id - Search parameter for _id (token) - A single or comma separated list of Consent ids
    # + patient - Search parameter for patient (reference) - Who the consent applies to
    # + actor - Search parameter for actor (reference) - Resource for the actor (or group, by role)
    # + patient_identifier - Search parameter for patient.identifier (token) - The patient
    # + actor_identifier - Search parameter for actor.identifier (token) - The actor
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Consent resources"}
    remote function searchConsent(
            string? _id = (),
            string? patient = (),
            string? actor = (),
            string? patient_identifier = (),
            string? actor_identifier = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "actor", actor);
        addIfPresent(params, "patient.identifier", patient_identifier);
        addIfPresent(params, "actor.identifier", actor_identifier);

        return self.fhirConnectorObj->search("Consent", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the Coverage resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Coverage by the logical ID"}
    remote function getCoverageById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Coverage", id);
    }

    # + _id - Search parameter for _id (token) - 
    # + patient - Search parameter for patient (reference) - Retrieve coverages for a patient
    # + _encounter - Search parameter for -encounter (reference) - Retrieve coverages for an encounter
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Coverage resources"}
    remote function searchCoverage(
            string? _id = (),
            string? patient = (),
            string? _encounter = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "-encounter", _encounter);

        return self.fhirConnectorObj->search("Coverage", mode = fhirClient:POST, searchParameters = params);
    }

    # + newCoverage - A new instance of the Coverage resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Create Coverage resource"}
    remote function createCoverage(healthFhirR4Uscore700:USCoreCoverageProfile newCoverage)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->create(newCoverage.toJson());
    }

    # + id - The logical ID of the Coverage resource
    # + patchCoverage - An updated instance of the Coverage resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Patch Coverage resource"}
    remote function patchCoverage(string id, healthFhirR4Uscore700:USCoreCoverageProfile patchCoverage)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->patch("Coverage", patchCoverage.toJson(), id);
    }

    # + id - The logical ID of the Coverage resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Delete Coverage resource"}
    remote function deleteCoverage(string id) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->delete("Coverage", id);
    }

    # + id - The logical ID of the Device resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Device by the logical ID"}
    remote function getDeviceById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Device", id);
    }

    # + _id - Search parameter for _id (token) - A single or comma separated list of Device ids
    # + patient - Search parameter for patient (reference) - The patient to whom Device is affixed
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Device resources"}
    remote function searchDevice(
            string? _id = (),
            string? patient = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "patient", patient);

        return self.fhirConnectorObj->search("Device", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the DiagnosticReport resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get DiagnosticReport by the logical ID"}
    remote function getDiagnosticReportById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("DiagnosticReport", id);
    }

    # + _id - Search parameter for _id (token) - A single or comma separated list of DiagnosticReport ids
    # + category - Search parameter for category (token) - Which diagnostic discipline/department created the report
    # + code - Search parameter for code (token) - The code for the report
    # + encounter - Search parameter for encounter (reference) - The Encounter when the report was made
    # + patient - Search parameter for patient (reference) - The subject of the report
    # + date - Search parameter for date (date) - A date range with which to find Documents
    # + _lastUpdated - Search parameter for _lastUpdated (date) - A date or date range used to search for Documents of diagnostic report which were last updated in that period
    # + _count - Search parameter for _count (number) - The maximum number of results to return in a page
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search DiagnosticReport resources"}
    remote function searchDiagnosticReport(
            string? _id = (),
            string? category = (),
            string? code = (),
            string? encounter = (),
            string? patient = (),
            string? date = (),
            string[]? _lastUpdated = (),
            string? _count = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "category", category);
        addIfPresent(params, "code", code);
        addIfPresent(params, "encounter", encounter);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "date", date);
        addIfPresent(params, "_lastUpdated", _lastUpdated);
        addIfPresent(params, "_count", _count);

        return self.fhirConnectorObj->search("DiagnosticReport", mode = fhirClient:POST, searchParameters = params);
    }

    # + newDiagnosticReport - A new instance of the DiagnosticReport resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Create DiagnosticReport resource"}
    remote function createDiagnosticReport(healthFhirR4Uscore700:USCoreDiagnosticReportProfileNoteExchange|healthFhirR4Uscore700:USCoreDiagnosticReportProfileLaboratoryReporting newDiagnosticReport)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->create(newDiagnosticReport.toJson());
    }

    # + id - The logical ID of the DocumentReference resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get DocumentReference by the logical ID"}
    remote function getDocumentReferenceById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("DocumentReference", id);
    }

    # + _id - Search parameter for _id (token) - A single or comma separated list of DocumentReference ids
    # + patient - Search parameter for patient (reference) - The patient the document is about
    # + encounter - Search parameter for encounter (reference) - The Encounter in which the document was created
    # + period - Search parameter for period (date) - A date range with which to find Documents
    # + _count - Search parameter for _count (number) - The maximum number of results to return in a page
    # + 'type - Search parameter for type (token) - The kind of document (LOINC if possible)
    # + category - Search parameter for category (token) - The categorization of document
    # + date - Search parameter for date (date) - It must be provided  once with a prefix to imply a date  range or without a prefix to search for document(s) at a specific date
    # + _lastUpdated - Search parameter for _lastUpdated (date) - A date or date range used to search for Documents which were last updated in that period
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search DocumentReference resources"}
    remote function searchDocumentReference(
            string? _id = (),
            string? patient = (),
            string? encounter = (),
            string? period = (),
            string? _count = (),
            string? 'type = (),
            string? category = (),
            string? date = (),
            string[]? _lastUpdated = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "encounter", encounter);
        addIfPresent(params, "period", period);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "type", 'type);
        addIfPresent(params, "category", category);
        addIfPresent(params, "date", date);
        addIfPresent(params, "_lastUpdated", _lastUpdated);

        return self.fhirConnectorObj->search("DocumentReference", mode = fhirClient:POST, searchParameters = params);
    }

    # + newDocumentReference - A new instance of the DocumentReference resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Create DocumentReference resource"}
    remote function createDocumentReference(healthFhirR4Uscore700:USCoreDocumentReferenceProfile newDocumentReference)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->create(newDocumentReference.toJson());
    }

    # + updatedDocumentReference - A new or updated instance of the DocumentReference resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Update DocumentReference resource"}
    remote function updateDocumentReference(healthFhirR4Uscore700:USCoreDocumentReferenceProfile updatedDocumentReference)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->update(updatedDocumentReference.toJson());
    }

remote function uscorefetchdocumentreferencesDocumentReferenceOperation(@display {label: "Request Mode"} fhirClient:RequestMode mode = fhirClient:POST,
                                                                             @display {label: "Logical ID"} string? id = (),
                                                                             @display {label: "Query Parameters"} map<string[]>? queryParameters = (),
                                                                             @display {label: "Resource data"} json|xml? data = ())
        returns fhirClient:FHIRResponse|fhirClient:FHIRError {
    return check self.fhirConnectorObj->callOperation("DocumentReference", "$USCoreFetchDocumentReferences", mode, id, queryParameters, data);
}

    # + id - The logical ID of the Encounter resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Encounter by the logical ID"}
    remote function getEncounterById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Encounter", id);
    }

    # + _id - Search parameter for _id (token) - A single or comma separated list of Encounter ids
    # + _count - Search parameter for _count (number) - The maximum number of results to return in a page
    # + patient - Search parameter for patient (reference) - The patient present at the encounter
    # + subject - Search parameter for subject (reference) - The patient present at the encounter
    # + status - Search parameter for status (token) - The status of the encounter
    # + date - Search parameter for date (date) - A date parameter may be provided once with a prefix and time component to imply a date range
    # + identifier - Search parameter for identifier (token) - An encounter's identifier
    # + account - Search parameter for account (reference) - The account associated with the encounters
    # + _lastUpdated - Search parameter for _lastUpdated (date) - A date or date range used to search for Encounter records which were last updated in that period
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Encounter resources"}
    remote function searchEncounter(
            string? _id = (),
            string? _count = (),
            string? patient = (),
            string? subject = (),
            string? status = (),
            string? date = (),
            string? identifier = (),
            string? account = (),
            string[]? _lastUpdated = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "subject", subject);
        addIfPresent(params, "status", status);
        addIfPresent(params, "date", date);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "account", account);
        addIfPresent(params, "_lastUpdated", _lastUpdated);

        return self.fhirConnectorObj->search("Encounter", mode = fhirClient:POST, searchParameters = params);
    }

    # + newEncounter - A new instance of the Encounter resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Create Encounter resource"}
    remote function createEncounter(healthFhirR4Uscore700:USCoreEncounterProfile newEncounter)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->create(newEncounter.toJson());
    }

    # + id - The logical ID of the Encounter resource
    # + patchEncounter - An updated instance of the Encounter resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Patch Encounter resource"}
    remote function patchEncounter(string id, healthFhirR4Uscore700:USCoreEncounterProfile patchEncounter)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->patch("Encounter", patchEncounter.toJson(), id);
    }

    # + id - The logical ID of the FamilyMemberHistory resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get FamilyMemberHistory by the logical ID"}
    remote function getFamilyMemberHistoryById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("FamilyMemberHistory", id);
    }

    # + _id - Search parameter for _id (token) - A single or comma separated list of FamilyMemberHistory ids
    # + patient - Search parameter for patient (reference) - Who the family member history is for
    # + status - Search parameter for status (token) - The status of the FamilyMemberHistory
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search FamilyMemberHistory resources"}
    remote function searchFamilyMemberHistory(
            string? _id = (),
            string? patient = (),
            string? status = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "status", status);

        return self.fhirConnectorObj->search("FamilyMemberHistory", mode = fhirClient:POST, searchParameters = params);
    }

    # + newFamilyMemberHistory - A new instance of the FamilyMemberHistory resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Create FamilyMemberHistory resource"}
    remote function createFamilyMemberHistory(resourceInternational:FamilyMemberHistory newFamilyMemberHistory)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->create(newFamilyMemberHistory.toJson());
    }

    # + updatedFamilyMemberHistory - A new or updated instance of the FamilyMemberHistory resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Update FamilyMemberHistory resource"}
    remote function updateFamilyMemberHistory(resourceInternational:FamilyMemberHistory updatedFamilyMemberHistory)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->update(updatedFamilyMemberHistory.toJson());
    }

    # + id - The logical ID of the Goal resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Goal by the logical ID"}
    remote function getGoalById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Goal", id);
    }

    # + _id - Search parameter for _id (token) - Goal id supports only the single id
    # + patient - Search parameter for patient (reference) - Who has the goal is for
    # + target_date - Search parameter for target-date (date) - A date or date range from which to find Goals
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Goal resources"}
    remote function searchGoal(
            string? _id = (),
            string? patient = (),
            string? target_date = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "target-date", target_date);

        return self.fhirConnectorObj->search("Goal", mode = fhirClient:POST, searchParameters = params);
    }

    remote function exportGroupOperation(@display {label: "Request Mode"} fhirClient:RequestMode mode = fhirClient:POST,
                                                                             @display {label: "Logical ID"} string? id = (),
                                                                             @display {label: "Query Parameters"} map<string[]>? queryParameters = (),
                                                                             @display {label: "Resource data"} json|xml? data = ())
        returns fhirClient:FHIRResponse|fhirClient:FHIRError {
    return check self.fhirConnectorObj->callOperation("Group", "$export", mode, id, queryParameters, data);
}

    # + id - The logical ID of the Immunization resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Immunization by the logical ID"}
    remote function getImmunizationById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Immunization", id);
    }

    # + _id - Search parameter for _id (token) - A single or comma separated list of Immunization ids
    # + patient - Search parameter for patient (reference) - The patient for the vaccination record
    # + _lastUpdated - Search parameter for _lastUpdated (date) - Vaccination LastUpdated Date
    # + date - Search parameter for date (date) - Vaccination (non)-Administration Date
    # + target_disease - Search parameter for target-disease (token) - A single or comma separated list of target diseases the dose is being administered against
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Immunization resources"}
    remote function searchImmunization(
            string? _id = (),
            string? patient = (),
            string[]? _lastUpdated = (),
            string? date = (),
            string? target_disease = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "_lastUpdated", _lastUpdated);
        addIfPresent(params, "date", date);
        addIfPresent(params, "target-disease", target_disease);

        return self.fhirConnectorObj->search("Immunization", mode = fhirClient:POST, searchParameters = params);
    }

    # + newImmunization - A new instance of the Immunization resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Create Immunization resource"}
    remote function createImmunization(healthFhirR4Uscore700:USCoreImmunizationProfile newImmunization)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->create(newImmunization.toJson());
    }

    # + updatedImmunization - A new or updated instance of the Immunization resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Update Immunization resource"}
    remote function updateImmunization(healthFhirR4Uscore700:USCoreImmunizationProfile updatedImmunization)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->update(updatedImmunization.toJson());
    }

    # + id - The logical ID of the InsurancePlan resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get InsurancePlan by the logical ID"}
    remote function getInsurancePlanById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("InsurancePlan", id);
    }

    # + _id - Search parameter for _id (token) - A single or comma separated list of InsurancePlan ids
    # + owned_by - Search parameter for owned-by (reference) - The organization that is providing the health insurance product
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search InsurancePlan resources"}
    remote function searchInsurancePlan(
            string? _id = (),
            string? owned_by = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "owned-by", owned_by);

        return self.fhirConnectorObj->search("InsurancePlan", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the Location resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Location by the logical ID"}
    remote function getLocationById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Location", id);
    }

    # + _id - Search parameter for _id (token) - A single or comma separated list of Location ids
    # + _physicalType - Search parameter for -physicalType (token) - The Location's physical type
    # + identifier - Search parameter for identifier (token) - A location's identifier
    # + address - Search parameter for address (string) - A (part of the) address of the location
    # + address_city - Search parameter for address-city (string) - A city specified in an address
    # + address_state - Search parameter for address-state (string) - A state specified in an address
    # + address_postalcode - Search parameter for address-postalcode (string) - A postal code specified in an address
    # + name - Search parameter for name (string) - A portion of the location's name or alias
    # + organization - Search parameter for organization (reference) - Searches for locations that are managed by the provided organization
    # + 'type - Search parameter for type (token) - The Location's type
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Location resources"}
    remote function searchLocation(
            string? _id = (),
            string? _physicalType = (),
            string? identifier = (),
            string? address = (),
            string? address_city = (),
            string? address_state = (),
            string? address_postalcode = (),
            string? name = (),
            string? organization = (),
            string? 'type = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "-physicalType", _physicalType);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "address", address);
        addIfPresent(params, "address-city", address_city);
        addIfPresent(params, "address-state", address_state);
        addIfPresent(params, "address-postalcode", address_postalcode);
        addIfPresent(params, "name", name);
        addIfPresent(params, "organization", organization);
        addIfPresent(params, "type", 'type);

        return self.fhirConnectorObj->search("Location", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the Media resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Media by the logical ID"}
    remote function getMediaById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Media", id);
    }

    # + id - The logical ID of the MedicationAdministration resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get MedicationAdministration by the logical ID"}
    remote function getMedicationAdministrationById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("MedicationAdministration", id);
    }

    # + _id - Search parameter for _id (token) - A single or comma separated list of MedicationAdministration ids
    # + patient - Search parameter for patient (reference) - The identity of a patient to list administrations for
    # + status - Search parameter for status (token) - MedicationAdministration event status
    # + performer - Search parameter for performer (reference) - The identity of the individual who administered the medication
    # + effective_time - Search parameter for effective-time (date) - A effective-time parameter may be provided once with 'le' or 'lt' or 'ge' or 'gt' prefix and time component to imply a date range
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search MedicationAdministration resources"}
    remote function searchMedicationAdministration(
            string? _id = (),
            string? patient = (),
            string? status = (),
            string? performer = (),
            string? effective_time = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "status", status);
        addIfPresent(params, "performer", performer);
        addIfPresent(params, "effective-time", effective_time);

        return self.fhirConnectorObj->search("MedicationAdministration", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the MedicationDispense resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get MedicationDispense by the logical ID"}
    remote function getMedicationDispenseById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("MedicationDispense", id);
    }

    # + _id - Search parameter for _id (token) - A single or comma separated list of MedicationDispense ids
    # + patient - Search parameter for patient (reference) - The identity of a patient to list dispenses for
    # + _count - Search parameter for _count (number) - The maximum number of results to return
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search MedicationDispense resources"}
    remote function searchMedicationDispense(
            string? _id = (),
            string? patient = (),
            string? _count = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "_count", _count);

        return self.fhirConnectorObj->search("MedicationDispense", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the MedicationRequest resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get MedicationRequest by the logical ID"}
    remote function getMedicationRequestById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("MedicationRequest", id);
    }

    # + _id - Search parameter for _id (token) - A single or comma separated list of MedicationRequest ids
    # + patient - Search parameter for patient (reference) - The patient to return MedicationRequests for
    # + intent - Search parameter for intent (token) - The intent of the MedicationRequest
    # + status - Search parameter for status (token) - The status of the MedicationRequest
    # + _lastUpdated - Search parameter for _lastUpdated (date) - When the resource version last changed
    # + _timing_boundsPeriod - Search parameter for -timing-boundsPeriod (date) - The date-time within the period the medication should be given to the patient
    # + _count - Search parameter for _count (number) - The maximum number of results to return in a page
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search MedicationRequest resources"}
    remote function searchMedicationRequest(
            string? _id = (),
            string? patient = (),
            string? intent = (),
            string? status = (),
            string[]? _lastUpdated = (),
            string? _timing_boundsPeriod = (),
            string? _count = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "intent", intent);
        addIfPresent(params, "status", status);
        addIfPresent(params, "_lastUpdated", _lastUpdated);
        addIfPresent(params, "-timing-boundsPeriod", _timing_boundsPeriod);
        addIfPresent(params, "_count", _count);

        return self.fhirConnectorObj->search("MedicationRequest", mode = fhirClient:POST, searchParameters = params);
    }

    # + newMedicationRequest - A new instance of the MedicationRequest resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Create MedicationRequest resource"}
    remote function createMedicationRequest(healthFhirR4Uscore700:USCoreMedicationRequestProfile newMedicationRequest)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->create(newMedicationRequest.toJson());
    }

    # + id - The logical ID of the MedicationRequest resource
    # + patchMedicationRequest - An updated instance of the MedicationRequest resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Patch MedicationRequest resource"}
    remote function patchMedicationRequest(string id, healthFhirR4Uscore700:USCoreMedicationRequestProfile patchMedicationRequest)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->patch("MedicationRequest", patchMedicationRequest.toJson(), id);
    }

    # + id - The logical ID of the NutritionOrder resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get NutritionOrder by the logical ID"}
    remote function getNutritionOrderById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("NutritionOrder", id);
    }

    # + _id - Search parameter for _id (token) - A single or comma separated list of NutritionOrder ids
    # + patient - Search parameter for patient (reference) - The patient to return NutritionOrders for
    # + status - Search parameter for status (token) - The status of the NutritionOrder
    # + _lastUpdated - Search parameter for _lastUpdated (date) - When the resource version last changed
    # + _count - Search parameter for _count (number) - The maximum number of results to return in a page
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search NutritionOrder resources"}
    remote function searchNutritionOrder(
            string? _id = (),
            string? patient = (),
            string? status = (),
            string[]? _lastUpdated = (),
            string? _count = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "status", status);
        addIfPresent(params, "_lastUpdated", _lastUpdated);
        addIfPresent(params, "_count", _count);

        return self.fhirConnectorObj->search("NutritionOrder", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the Observation resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Observation by the logical ID"}
    remote function getObservationById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Observation", id);
    }

    # + _id - Search parameter for _id (token) - A single or comma separated list of Observation ids
    # + patient - Search parameter for patient (reference) - The patient the observation is about
    # + subject - Search parameter for subject (reference) - The patient subject the observation is about
    # + category - Search parameter for category (token) - A single or comma separated list of classifications of the type of observation
    # + code - Search parameter for code (token) - A single or comma separated list of observation types
    # + date - Search parameter for date (date) - A date or date range from which to find observations
    # + _lastUpdated - Search parameter for _lastUpdated (date) - A date or date range used to search for observations which were last updated in that period
    # + _count - Search parameter for _count (number) - The maximum number of results to return in a page
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Observation resources"}
    remote function searchObservation(
            string? _id = (),
            string? patient = (),
            string? subject = (),
            string? category = (),
            string? code = (),
            string? date = (),
            string[]? _lastUpdated = (),
            string? _count = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "subject", subject);
        addIfPresent(params, "category", category);
        addIfPresent(params, "code", code);
        addIfPresent(params, "date", date);
        addIfPresent(params, "_lastUpdated", _lastUpdated);
        addIfPresent(params, "_count", _count);

        return self.fhirConnectorObj->search("Observation", mode = fhirClient:POST, searchParameters = params);
    }

    # + newObservation - A new instance of the Observation resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Create Observation resource"}
    remote function createObservation(healthFhirR4Uscore700:USCoreLaboratoryResultObservationProfile|healthFhirR4Uscore700:USCoreBMIProfile|healthFhirR4Uscore700:USCorePediatricWeightForHeightObservationProfile|healthFhirR4Uscore700:USCorePulseOximetryProfile|healthFhirR4Uscore700:USCoreSmokingStatusProfile|healthFhirR4Uscore700:USCoreBloodPressureProfile|healthFhirR4Uscore700:USCoreBodyHeightProfile|healthFhirR4Uscore700:USCoreBodyWeightProfile|healthFhirR4Uscore700:USCoreHeartRateProfile|healthFhirR4Uscore700:USCoreRespiratoryRateProfile|healthFhirR4Uscore700:USCoreBodyTemperatureProfile|healthFhirR4Uscore700:USCoreHeadCircumferenceProfile|healthFhirR4Uscore700:USCoreVitalSignsProfile|healthFhirR4Uscore700:USCorePediatricBMIforAgeObservationProfile|healthFhirR4Uscore700:USCorePediatricHeadOccipitalFrontalCircumferencePercentileProfile|healthFhirR4Uscore700:USCoreObservationOccupationProfile|healthFhirR4Uscore700:USCoreObservationPregnancyStatusProfile|healthFhirR4Uscore700:USCoreObservationPregnancyIntentProfile|resourceInternational:Observation|healthFhirR4Uscore700:USCoreObservationClinicalResultProfile|healthFhirR4Uscore700:USCoreObservationScreeningAssessmentProfile|healthFhirR4Uscore700:USCoreObservationSexualOrientationProfile newObservation)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->create(newObservation.toJson());
    }

    # + updatedObservation - A new or updated instance of the Observation resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Update Observation resource"}
    remote function updateObservation(healthFhirR4Uscore700:USCoreLaboratoryResultObservationProfile|healthFhirR4Uscore700:USCoreBMIProfile|healthFhirR4Uscore700:USCorePediatricWeightForHeightObservationProfile|healthFhirR4Uscore700:USCorePulseOximetryProfile|healthFhirR4Uscore700:USCoreSmokingStatusProfile|healthFhirR4Uscore700:USCoreBloodPressureProfile|healthFhirR4Uscore700:USCoreBodyHeightProfile|healthFhirR4Uscore700:USCoreBodyWeightProfile|healthFhirR4Uscore700:USCoreHeartRateProfile|healthFhirR4Uscore700:USCoreRespiratoryRateProfile|healthFhirR4Uscore700:USCoreBodyTemperatureProfile|healthFhirR4Uscore700:USCoreHeadCircumferenceProfile|healthFhirR4Uscore700:USCoreVitalSignsProfile|healthFhirR4Uscore700:USCorePediatricBMIforAgeObservationProfile|healthFhirR4Uscore700:USCorePediatricHeadOccipitalFrontalCircumferencePercentileProfile|healthFhirR4Uscore700:USCoreObservationOccupationProfile|healthFhirR4Uscore700:USCoreObservationPregnancyStatusProfile|healthFhirR4Uscore700:USCoreObservationPregnancyIntentProfile|resourceInternational:Observation|healthFhirR4Uscore700:USCoreObservationClinicalResultProfile|healthFhirR4Uscore700:USCoreObservationScreeningAssessmentProfile|healthFhirR4Uscore700:USCoreObservationSexualOrientationProfile updatedObservation)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->update(updatedObservation.toJson());
    }

    # + id - The logical ID of the OperationDefinition resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get OperationDefinition by the logical ID"}
    remote function getOperationDefinitionById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("OperationDefinition", id);
    }

    # + id - The logical ID of the Organization resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Organization by the logical ID"}
    remote function getOrganizationById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Organization", id);
    }

    # + _id - Search parameter for _id (token) - A single or comma separated list of Organization ids
    # + identifier - Search parameter for identifier (token) - The Organization's Identifier
    # + 'type - Search parameter for type (token) - The Organization's type
    # + _count - Search parameter for _count (number) - The maximum number of results to return in a page
    # + name - Search parameter for name (string) - The Organization's name
    # + address - Search parameter for address (string) - The Organization's address
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Organization resources"}
    remote function searchOrganization(
            string? _id = (),
            string? identifier = (),
            string? 'type = (),
            string? _count = (),
            string? name = (),
            string? address = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "type", 'type);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "name", name);
        addIfPresent(params, "address", address);

        return self.fhirConnectorObj->search("Organization", mode = fhirClient:POST, searchParameters = params);
    }

    # + newOrganization - A new instance of the Organization resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Create Organization resource"}
    remote function createOrganization(healthFhirR4Uscore700:USCoreOrganizationProfile newOrganization)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->create(newOrganization.toJson());
    }

remote function getCgForMrcuOrganizationOperation(@display {label: "Request Mode"} fhirClient:RequestMode mode = fhirClient:POST,
                                                                             @display {label: "Logical ID"} string? id = (),
                                                                             @display {label: "Query Parameters"} map<string[]>? queryParameters = (),
                                                                             @display {label: "Resource data"} json|xml? data = ())
        returns fhirClient:FHIRResponse|fhirClient:FHIRError {
    return check self.fhirConnectorObj->callOperation("Organization", "$get-cg-for-mrcu", mode, id, queryParameters, data);
}

    # + id - The logical ID of the Patient resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Patient by the logical ID"}
    remote function getPatientById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Patient", id);
    }

    # + _id - Search parameter for _id (token) - A single or comma separated list of Patient ids
    # + identifier - Search parameter for identifier (token) - A patient identifier
    # + name - Search parameter for name (string) - The beginning of any name of the patient
    # + given - Search parameter for given (string) - The beginning of the given name of the patient
    # + family - Search parameter for family (string) - The beginning of the family name of the patient
    # + address_postalcode - Search parameter for address-postalcode (string) - The postal code of the address of the patient
    # + birthdate - Search parameter for birthdate (date) - The date of birth of the patient
    # + phone - Search parameter for phone (token) - The value of the phone number of the patient
    # + email - Search parameter for email (token) - The value of the email address of the patient
    # + gender - Search parameter for gender (token) - The administrative gender of the patient
    # + _count - Search parameter for _count (number) - The maximum number of results to return in a page
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Patient resources"}
    remote function searchPatient(
            string? _id = (),
            string? identifier = (),
            string? name = (),
            string? given = (),
            string? family = (),
            string? address_postalcode = (),
            string? birthdate = (),
            string? phone = (),
            string? email = (),
            string? gender = (),
            string? _count = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "name", name);
        addIfPresent(params, "given", given);
        addIfPresent(params, "family", family);
        addIfPresent(params, "address-postalcode", address_postalcode);
        addIfPresent(params, "birthdate", birthdate);
        addIfPresent(params, "phone", phone);
        addIfPresent(params, "email", email);
        addIfPresent(params, "gender", gender);
        addIfPresent(params, "_count", _count);

        return self.fhirConnectorObj->search("Patient", mode = fhirClient:POST, searchParameters = params);
    }

    # + newPatient - A new instance of the Patient resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Create Patient resource"}
    remote function createPatient(healthFhirR4Uscore700:USCorePatientProfile newPatient)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->create(newPatient.toJson());
    }

    # + id - The logical ID of the Patient resource
    # + patchPatient - An updated instance of the Patient resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Patch Patient resource"}
    remote function patchPatient(string id, healthFhirR4Uscore700:USCorePatientProfile patchPatient)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->patch("Patient", patchPatient.toJson(), id);
    }

remote function healthCardsIssuePatientOperation(@display {label: "Request Mode"} fhirClient:RequestMode mode = fhirClient:POST,
                                                                             @display {label: "Logical ID"} string? id = (),
                                                                             @display {label: "Query Parameters"} map<string[]>? queryParameters = (),
                                                                             @display {label: "Resource data"} json|xml? data = ())
        returns fhirClient:FHIRResponse|fhirClient:FHIRError {
    return check self.fhirConnectorObj->callOperation("Patient", "$health-cards-issue", mode, id, queryParameters, data);
}

remote function exportPatientOperation(@display {label: "Request Mode"} fhirClient:RequestMode mode = fhirClient:POST,
                                                                             @display {label: "Logical ID"} string? id = (),
                                                                             @display {label: "Query Parameters"} map<string[]>? queryParameters = (),
                                                                             @display {label: "Resource data"} json|xml? data = ())
        returns fhirClient:FHIRResponse|fhirClient:FHIRError {
    return check self.fhirConnectorObj->callOperation("Patient", "$export", mode, id, queryParameters, data);
}

    # + id - The logical ID of the Person resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Person by the logical ID"}
    remote function getPersonById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Person", id);
    }

    # + _id - Search parameter for _id (token) - A single or comma separated list of Person ids
    # + identifier - Search parameter for identifier (token) - A person's Identifier
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Person resources"}
    remote function searchPerson(
            string? _id = (),
            string? identifier = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "identifier", identifier);

        return self.fhirConnectorObj->search("Person", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the Practitioner resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Practitioner by the logical ID"}
    remote function getPractitionerById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Practitioner", id);
    }

    # + _id - Search parameter for _id (token) - A single or comma separated list of Practitioner ids
    # + identifier - Search parameter for identifier (token) - A practitioner's Identifier
    # + given - Search parameter for given (string) - The beginning of the given name of the practitioner
    # + family - Search parameter for family (string) - The beginning of the family name of the practitioner
    # + name - Search parameter for name (string) - The beginning of the first, last or middle name of the practitioner
    # + active - Search parameter for active (token) - Whether the practitioner record is active
    # + _count - Search parameter for _count (number) - The maximum number of results to return in a page
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Practitioner resources"}
    remote function searchPractitioner(
            string? _id = (),
            string? identifier = (),
            string? given = (),
            string? family = (),
            string? name = (),
            string? active = (),
            string? _count = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "given", given);
        addIfPresent(params, "family", family);
        addIfPresent(params, "name", name);
        addIfPresent(params, "active", active);
        addIfPresent(params, "_count", _count);

        return self.fhirConnectorObj->search("Practitioner", mode = fhirClient:POST, searchParameters = params);
    }

    # + newPractitioner - A new instance of the Practitioner resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Create Practitioner resource"}
    remote function createPractitioner(healthFhirR4Uscore700:USCorePractitionerProfile newPractitioner)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->create(newPractitioner.toJson());
    }

    # + id - The logical ID of the Procedure resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Procedure by the logical ID"}
    remote function getProcedureById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Procedure", id);
    }

    # + _id - Search parameter for _id (token) - A single or comma separated list of Procedure ids
    # + patient - Search parameter for patient (reference) - Search by subject - a patient
    # + subject - Search parameter for subject (reference) - Search by subject
    # + date - Search parameter for date (date) - A date parameter may be provided once without a prefix or time component to imply a date range or once without a prefix and with a time component
    # + _lastUpdated - Search parameter for _lastUpdated (date) - A date or date range used to search for procedures which were last updated in that period
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Procedure resources"}
    remote function searchProcedure(
            string? _id = (),
            string? patient = (),
            string? subject = (),
            string? date = (),
            string[]? _lastUpdated = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "subject", subject);
        addIfPresent(params, "date", date);
        addIfPresent(params, "_lastUpdated", _lastUpdated);

        return self.fhirConnectorObj->search("Procedure", mode = fhirClient:POST, searchParameters = params);
    }

    # + newProcedure - A new instance of the Procedure resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Create Procedure resource"}
    remote function createProcedure(healthFhirR4Uscore700:USCoreProcedureProfile newProcedure)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->create(newProcedure.toJson());
    }

    # + id - The logical ID of the Provenance resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Provenance by the logical ID"}
    remote function getProvenanceById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Provenance", id);
    }

    # + _id - Search parameter for _id (token) - A single or comma separated list of Provenance ids
    # + target - Search parameter for target (reference) - The resource(s) the Provenance is associated with
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Provenance resources"}
    remote function searchProvenance(
            string? _id = (),
            string? target = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "target", target);

        return self.fhirConnectorObj->search("Provenance", mode = fhirClient:POST, searchParameters = params);
    }

    # + newProvenance - A new instance of the Provenance resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Create Provenance resource"}
    remote function createProvenance(healthFhirR4Uscore700:USCoreProvenance newProvenance)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->create(newProvenance.toJson());
    }

    # + id - The logical ID of the Questionnaire resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Questionnaire by the logical ID"}
    remote function getQuestionnaireById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Questionnaire", id);
    }

    # + _id - Search parameter for _id (token) - A single or comma separated list of Questionnaire ids
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Questionnaire resources"}
    remote function searchQuestionnaire(
            string? _id = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);

        return self.fhirConnectorObj->search("Questionnaire", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the QuestionnaireResponse resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get QuestionnaireResponse by the logical ID"}
    remote function getQuestionnaireResponseById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("QuestionnaireResponse", id);
    }

    # + _id - Search parameter for _id (token) - A single or comma separated list of QuestionnaireResponse ids
    # + patient - Search parameter for patient (reference) - The patient that is the subject of the questionnaire response
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search QuestionnaireResponse resources"}
    remote function searchQuestionnaireResponse(
            string? _id = (),
            string? patient = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "patient", patient);

        return self.fhirConnectorObj->search("QuestionnaireResponse", mode = fhirClient:POST, searchParameters = params);
    }

    # + updatedQuestionnaireResponse - A new or updated instance of the QuestionnaireResponse resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Update QuestionnaireResponse resource"}
    remote function updateQuestionnaireResponse(resourceInternational:QuestionnaireResponse updatedQuestionnaireResponse)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->update(updatedQuestionnaireResponse.toJson());
    }

    # + id - The logical ID of the RelatedPerson resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get RelatedPerson by the logical ID"}
    remote function getRelatedPersonById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("RelatedPerson", id);
    }

    # + _id - Search parameter for _id (token) - A single or comma separated list of RelatedPerson ids
    # + identifier - Search parameter for identifier (token) - An Identifier of the RelatedPerson
    # + patient - Search parameter for patient (reference) - The patient this related person is related to
    # + _encounter - Search parameter for -encounter (reference) - The encounter this related person is related to
    # + _relationship_level - Search parameter for -relationship-level (token) - The resource's relationship to either the patient or encounter level
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search RelatedPerson resources"}
    remote function searchRelatedPerson(
            string? _id = (),
            string? identifier = (),
            string? patient = (),
            string? _encounter = (),
            string? _relationship_level = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "-encounter", _encounter);
        addIfPresent(params, "-relationship-level", _relationship_level);

        return self.fhirConnectorObj->search("RelatedPerson", mode = fhirClient:POST, searchParameters = params);
    }

    # + newRelatedPerson - A new instance of the RelatedPerson resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Create RelatedPerson resource"}
    remote function createRelatedPerson(healthFhirR4Uscore700:USCoreRelatedPersonProfile newRelatedPerson)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->create(newRelatedPerson.toJson());
    }

    # + id - The logical ID of the RelatedPerson resource
    # + patchRelatedPerson - An updated instance of the RelatedPerson resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Patch RelatedPerson resource"}
    remote function patchRelatedPerson(string id, healthFhirR4Uscore700:USCoreRelatedPersonProfile patchRelatedPerson)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->patch("RelatedPerson", patchRelatedPerson.toJson(), id);
    }

    # + id - The logical ID of the Schedule resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Schedule by the logical ID"}
    remote function getScheduleById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Schedule", id);
    }

    # + _id - Search parameter for _id (token) - A single or comma separated list of Schedule ids
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Schedule resources"}
    remote function searchSchedule(
            string? _id = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);

        return self.fhirConnectorObj->search("Schedule", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the ServiceRequest resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get ServiceRequest by the logical ID"}
    remote function getServiceRequestById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("ServiceRequest", id);
    }

    # + _id - Search parameter for _id (token) - A single or comma separated list of ServiceRequest ids
    # + patient - Search parameter for patient (reference) - The patient to return ServiceRequests for
    # + subject - Search parameter for subject (reference) - Individual or Entity the service is ordered for
    # + code - Search parameter for code (token) - What is being requested/ordered
    # + _lastUpdated - Search parameter for _lastUpdated (date) - When the resource version last changed
    # + _count - Search parameter for _count (number) - The maximum number of results to return in a page
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search ServiceRequest resources"}
    remote function searchServiceRequest(
            string? _id = (),
            string? patient = (),
            string? subject = (),
            string? code = (),
            string[]? _lastUpdated = (),
            string? _count = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "subject", subject);
        addIfPresent(params, "code", code);
        addIfPresent(params, "_lastUpdated", _lastUpdated);
        addIfPresent(params, "_count", _count);

        return self.fhirConnectorObj->search("ServiceRequest", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the Slot resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Slot by the logical ID"}
    remote function getSlotById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Slot", id);
    }

    # + _id - Search parameter for _id (token) - A single or comma separated list of Slot ids
    # + 'start - Search parameter for start (date) - A date or date range from which the slots are to be retrieved
    # + service_type - Search parameter for service-type (token) - A single or comma separated list of appointment types that can be booked into the slot
    # + schedule_actor - Search parameter for schedule.actor (reference) - A single or comma separated list of schedule actors
    # + _location - Search parameter for -location (reference) - A single or comma separated list of Location references
    # + _count - Search parameter for _count (number) - The maximum number of results to return in a page
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Slot resources"}
    remote function searchSlot(
            string? _id = (),
            string? 'start = (),
            string? service_type = (),
            string? schedule_actor = (),
            string? _location = (),
            string? _count = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "start", 'start);
        addIfPresent(params, "service-type", service_type);
        addIfPresent(params, "schedule.actor", schedule_actor);
        addIfPresent(params, "-location", _location);
        addIfPresent(params, "_count", _count);

        return self.fhirConnectorObj->search("Slot", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the Slot resource
    # + patchSlot - An updated instance of the Slot resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Patch Slot resource"}
    remote function patchSlot(string id, resourceInternational:Slot patchSlot)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->patch("Slot", patchSlot.toJson(), id);
    }

    # + id - The logical ID of the Specimen resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Specimen by the logical ID"}
    remote function getSpecimenById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Specimen", id);
    }

    # + _id - Search parameter for _id (token) - A single or comma separated list of Specimen ids
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Specimen resources"}
    remote function searchSpecimen(
            string? _id = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);

        return self.fhirConnectorObj->search("Specimen", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the StructureDefinition resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get StructureDefinition by the logical ID"}
    remote function getStructureDefinitionById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("StructureDefinition", id);
    }

}
