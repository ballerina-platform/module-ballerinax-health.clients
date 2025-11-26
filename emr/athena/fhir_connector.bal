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

    # + id - The logical ID of the AllergyIntolerance resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get AllergyIntolerance by the logical ID"}
    remote function getAllergyIntoleranceById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("AllergyIntolerance", id);
    }

    # + patient - Search parameter for patient (reference) - AllergyIntolerance
    # + _count - Search parameter for _count (number) - The number of AllergyIntolerance resources to return per page for paged search results
    # + cursor - Search parameter for cursor (token) - An identifier for the first resource to return
    # + _revinclude - Search parameter for _revinclude (special) - AllergyIntolerance
    # + _include - Search parameter for _include (special) - AllergyIntolerance
    # + ah_chart_sharing_group - Search parameter for ah-chart-sharing-group (reference) - Search by Athena Chart Sharing Group for resources containing the 'Athena Chart Sharing Group' Extension
    # + _lastUpdated - Search parameter for _lastUpdated (date) - Last updated date associated with the AllergyIntolerance (format: YYYY-MM-DD)
    # + code - Search parameter for code (token) - Code to which this AllergyIntolerance is associated
    # + ah_practice - Search parameter for ah-practice (reference) - Search by Athena Practice for resources containing the 'Athena Practice' Extension
    # + _security - Search parameter for _security (token) - Search by a security label
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search AllergyIntolerance resources"}
    remote function searchAllergyIntolerance(
            string? patient = (),
            string? _count = (),
            string? cursor = (),
            string? _revinclude = (),
            string? _include = (),
            string? ah_chart_sharing_group = (),
            string[]? _lastUpdated = (),
            string? code = (),
            string? ah_practice = (),
            string? _security = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "cursor", cursor);
        addIfPresent(params, "_revinclude", _revinclude);
        addIfPresent(params, "_include", _include);
        addIfPresent(params, "ah-chart-sharing-group", ah_chart_sharing_group);
        addIfPresent(params, "_lastUpdated", _lastUpdated);
        addIfPresent(params, "code", code);
        addIfPresent(params, "ah-practice", ah_practice);
        addIfPresent(params, "_security", _security);

        return self.fhirConnectorObj->search("AllergyIntolerance", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the Appointment resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Appointment by the logical ID"}
    remote function getAppointmentById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Appointment", id);
    }

    # + _id - Search parameter for _id (token) - Appointment
    # + _query - Search parameter for _query (string) - Custom named query
    # + base_appointment_id - Search parameter for base-appointment-id (reference) - Search by Athena Appointment ID for resources containing the 'Athena Group Appointment' Extension
    # + group_appointment_id - Search parameter for group-appointment-id (reference) - Search by Athena Group Appointment ID for resources containing the same 'Athena Group Appointment' Extension
    # + ah_practice - Search parameter for ah-practice (reference) - Search by Athena Practice for resources containing the 'Athena Practice' Extension
    # + _security - Search parameter for _security (token) - Search by a security label
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Appointment resources"}
    remote function searchAppointment(
            string? _id = (),
            string? _query = (),
            string? base_appointment_id = (),
            string? group_appointment_id = (),
            string? ah_practice = (),
            string? _security = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "_query", _query);
        addIfPresent(params, "base-appointment-id", base_appointment_id);
        addIfPresent(params, "group-appointment-id", group_appointment_id);
        addIfPresent(params, "ah-practice", ah_practice);
        addIfPresent(params, "_security", _security);

        return self.fhirConnectorObj->search("Appointment", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the Binary resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Binary by the logical ID"}
    remote function getBinaryById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Binary", id);
    }

    # + id - The logical ID of the CarePlan resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get CarePlan by the logical ID"}
    remote function getCarePlanById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("CarePlan", id);
    }

    # + patient - Search parameter for patient (reference) - CarePlan
    # + category - Search parameter for category (token) - CarePlan
    # + _lastUpdated - Search parameter for _lastUpdated (date) - Last updated date associated with the CarePlan (format: YYYY-MM-DD)
    # + _count - Search parameter for _count (number) - The number of CarePlan resources to return per page for paged search results
    # + _id - Search parameter for _id (token) - CarePlan
    # + _revinclude - Search parameter for _revinclude (special) - CarePlan
    # + _include - Search parameter for _include (special) - CarePlan
    # + cursor - Search parameter for cursor (token) - An identifier for the first resource to return
    # + ah_practice - Search parameter for ah-practice (reference) - Search by Athena Practice for resources containing the 'Athena Practice' Extension
    # + ah_brand - Search parameter for ah-brand (reference) - Search by Athena Brand for resources containing the 'Athena Brand' Extension
    # + ah_chart_sharing_group - Search parameter for ah-chart-sharing-group (reference) - Search by Athena Chart Sharing Group for resources containing the 'Athena Chart Sharing Group' Extension
    # + ah_department - Search parameter for ah-department (reference) - Search by Athena Department for resources containing the 'Athena Department' Extension
    # + ah_provider_group - Search parameter for ah-provider-group (reference) - Search by Athena Provider Group for resources containing the 'Athena Provider Group' Extension
    # + _security - Search parameter for _security (token) - Search by a security label
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search CarePlan resources"}
    remote function searchCarePlan(
            string? patient = (),
            string? category = (),
            string[]? _lastUpdated = (),
            string? _count = (),
            string? _id = (),
            string? _revinclude = (),
            string? _include = (),
            string? cursor = (),
            string? ah_practice = (),
            string? ah_brand = (),
            string? ah_chart_sharing_group = (),
            string? ah_department = (),
            string? ah_provider_group = (),
            string? _security = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "category", category);
        addIfPresent(params, "_lastUpdated", _lastUpdated);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "_revinclude", _revinclude);
        addIfPresent(params, "_include", _include);
        addIfPresent(params, "cursor", cursor);
        addIfPresent(params, "ah-practice", ah_practice);
        addIfPresent(params, "ah-brand", ah_brand);
        addIfPresent(params, "ah-chart-sharing-group", ah_chart_sharing_group);
        addIfPresent(params, "ah-department", ah_department);
        addIfPresent(params, "ah-provider-group", ah_provider_group);
        addIfPresent(params, "_security", _security);

        return self.fhirConnectorObj->search("CarePlan", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the CareTeam resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get CareTeam by the logical ID"}
    remote function getCareTeamById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("CareTeam", id);
    }

    # + patient - Search parameter for patient (reference) - CareTeam
    # + status - Search parameter for status (token) - CareTeam
    # + _lastUpdated - Search parameter for _lastUpdated (date) - Last updated date associated with the CareTeam (format: YYYY-MM-DD)
    # + _count - Search parameter for _count (number) - The number of CareTeam resources to return per page for paged search results
    # + _id - Search parameter for _id (token) - CareTeam
    # + _revinclude - Search parameter for _revinclude (special) - CareTeam
    # + _include - Search parameter for _include (special) - CareTeam
    # + cursor - Search parameter for cursor (token) - An identifier for the first resource to return
    # + ah_brand - Search parameter for ah-brand (reference) - Search by Athena Brand for resources containing the 'Athena Brand' Extension
    # + ah_chart_sharing_group - Search parameter for ah-chart-sharing-group (reference) - Search by Athena Chart Sharing Group for resources containing the 'Athena Chart Sharing Group' Extension
    # + ah_practice - Search parameter for ah-practice (reference) - Search by Athena Practice for resources containing the 'Athena Practice' Extension
    # + ah_department - Search parameter for ah-department (reference) - Search by Athena Department for resources containing the 'Athena Department' Extension
    # + ah_provider_group - Search parameter for ah-provider-group (reference) - Search by Athena Provider Group for resources containing the 'Athena Provider Group' Extension
    # + _security - Search parameter for _security (token) - Search by a security label
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search CareTeam resources"}
    remote function searchCareTeam(
            string? patient = (),
            string? status = (),
            string[]? _lastUpdated = (),
            string? _count = (),
            string? _id = (),
            string? _revinclude = (),
            string? _include = (),
            string? cursor = (),
            string? ah_brand = (),
            string? ah_chart_sharing_group = (),
            string? ah_practice = (),
            string? ah_department = (),
            string? ah_provider_group = (),
            string? _security = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "status", status);
        addIfPresent(params, "_lastUpdated", _lastUpdated);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "_revinclude", _revinclude);
        addIfPresent(params, "_include", _include);
        addIfPresent(params, "cursor", cursor);
        addIfPresent(params, "ah-brand", ah_brand);
        addIfPresent(params, "ah-chart-sharing-group", ah_chart_sharing_group);
        addIfPresent(params, "ah-practice", ah_practice);
        addIfPresent(params, "ah-department", ah_department);
        addIfPresent(params, "ah-provider-group", ah_provider_group);
        addIfPresent(params, "_security", _security);

        return self.fhirConnectorObj->search("CareTeam", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the Condition resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Condition by the logical ID"}
    remote function getConditionById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Condition", id);
    }

    # + _id - Search parameter for _id (token) - Resource id (not a full URL)
    # + patient - Search parameter for patient (reference) - Who has the condition?
    # + encounter - Search parameter for encounter (reference) - Encounter to which this Condition is associated
    # + _revinclude - Search parameter for _revinclude (special) - Other resources to include in the search results when they refer to search matches
    # + _include - Search parameter for _include (special) - Other resources to include in the search results that search matches point to
    # + ah_chart_sharing_group - Search parameter for ah-chart-sharing-group (reference) - Search by Athena Chart Sharing Group for resources containing the 'Athena Chart Sharing Group' Extension
    # + ah_practice - Search parameter for ah-practice (reference) - Search by Athena Practice for resources containing the 'Athena Practice' Extension
    # + _count - Search parameter for _count (number) - The number of Condition resources to return per page for paged search results
    # + cursor - Search parameter for cursor (token) - An identifier for the first resource to return
    # + _lastUpdated - Search parameter for _lastUpdated (date) - Last updated date associated with the condition (format: YYYY-MM-DD)
    # + code - Search parameter for code (token) - Code to which this Condition is associated
    # + category - Search parameter for category (token) - Category of the condition in the format [parameter]=[system]|[code](e
    # + ah_redact_inline_security - Search parameter for ah-redact-inline-security (token) - Security label for redacting inline data separately from top-level resources
    # + _security - Search parameter for _security (token) - Search by a security label
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Condition resources"}
    remote function searchCondition(
            string? _id = (),
            string? patient = (),
            string? encounter = (),
            string? _revinclude = (),
            string? _include = (),
            string? ah_chart_sharing_group = (),
            string? ah_practice = (),
            string? _count = (),
            string? cursor = (),
            string[]? _lastUpdated = (),
            string? code = (),
            string? category = (),
            string? ah_redact_inline_security = (),
            string? _security = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "encounter", encounter);
        addIfPresent(params, "_revinclude", _revinclude);
        addIfPresent(params, "_include", _include);
        addIfPresent(params, "ah-chart-sharing-group", ah_chart_sharing_group);
        addIfPresent(params, "ah-practice", ah_practice);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "cursor", cursor);
        addIfPresent(params, "_lastUpdated", _lastUpdated);
        addIfPresent(params, "code", code);
        addIfPresent(params, "category", category);
        addIfPresent(params, "ah-redact-inline-security", ah_redact_inline_security);
        addIfPresent(params, "_security", _security);

        return self.fhirConnectorObj->search("Condition", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the Coverage resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Coverage by the logical ID"}
    remote function getCoverageById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Coverage", id);
    }

    # + _count - Search parameter for _count (number) - The number of Coverage resources to return per page for paged search results
    # + cursor - Search parameter for cursor (token) - An identifier for the first resource to return
    # + patient - Search parameter for patient (reference) - Coverage
    # + _revinclude - Search parameter for _revinclude (special) - Coverage
    # + _lastUpdated - Search parameter for _lastUpdated (date) - Last updated date of the coverage (_lastUpdated may only be used in conjunction with other supported search parameter combinations)
    # + ah_provider_group - Search parameter for ah-provider-group (reference) - Search by Athena Provider Group for resources containing the 'Athena Provider Group' Extension
    # + ah_practice - Search parameter for ah-practice (reference) - Search by Athena Practice for resources containing the 'Athena Practice' Extension
    # + _security - Search parameter for _security (token) - Search by a security label
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Coverage resources"}
    remote function searchCoverage(
            string? _count = (),
            string? cursor = (),
            string? patient = (),
            string? _revinclude = (),
            string[]? _lastUpdated = (),
            string? ah_provider_group = (),
            string? ah_practice = (),
            string? _security = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "cursor", cursor);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "_revinclude", _revinclude);
        addIfPresent(params, "_lastUpdated", _lastUpdated);
        addIfPresent(params, "ah-provider-group", ah_provider_group);
        addIfPresent(params, "ah-practice", ah_practice);
        addIfPresent(params, "_security", _security);

        return self.fhirConnectorObj->search("Coverage", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the Device resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Device by the logical ID"}
    remote function getDeviceById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Device", id);
    }

    # + patient - Search parameter for patient (reference) - Device
    # + _count - Search parameter for _count (number) - The number of Device resources to return per page for paged search results
    # + _include - Search parameter for _include (special) - Device
    # + cursor - Search parameter for cursor (token) - An identifier for the first resource to return
    # + _revinclude - Search parameter for _revinclude (special) - Device
    # + _id - Search parameter for _id (token) - Device
    # + ah_chart_sharing_group - Search parameter for ah-chart-sharing-group (reference) - Search by Athena Chart Sharing Group for resources containing the 'Athena Chart Sharing Group' Extension
    # + ah_practice - Search parameter for ah-practice (reference) - Search by Athena Practice for resources containing the 'Athena Practice' Extension
    # + _lastUpdated - Search parameter for _lastUpdated (date) - Last updated parameter consists of a comparator (eq, gt, lt, ge and le) and a date (format: YYYY-MM-DD)
    # + _security - Search parameter for _security (token) - Search by a security label
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Device resources"}
    remote function searchDevice(
            string? patient = (),
            string? _count = (),
            string? _include = (),
            string? cursor = (),
            string? _revinclude = (),
            string? _id = (),
            string? ah_chart_sharing_group = (),
            string? ah_practice = (),
            string[]? _lastUpdated = (),
            string? _security = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_include", _include);
        addIfPresent(params, "cursor", cursor);
        addIfPresent(params, "_revinclude", _revinclude);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "ah-chart-sharing-group", ah_chart_sharing_group);
        addIfPresent(params, "ah-practice", ah_practice);
        addIfPresent(params, "_lastUpdated", _lastUpdated);
        addIfPresent(params, "_security", _security);

        return self.fhirConnectorObj->search("Device", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the DiagnosticReport resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get DiagnosticReport by the logical ID"}
    remote function getDiagnosticReportById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("DiagnosticReport", id);
    }

    # + _id - Search parameter for _id (token) - DiagnosticReport
    # + _query - Search parameter for _query (string) - Custom named query
    # + encounter - Search parameter for encounter (reference) - Resource reference to FHIR Encounter resource
    # + patient - Search parameter for patient (reference) - DiagnosticReport
    # + _include - Search parameter for _include (special) - DiagnosticReport
    # + _revinclude - Search parameter for _revinclude (special) - DiagnosticReport
    # + category - Search parameter for category (token) - DiagnosticReport
    # + code - Search parameter for code (token) - DiagnosticReport
    # + date - Search parameter for date (date) - DiagnosticReport
    # + _count - Search parameter for _count (number) - The number of DiagnosticReport resources to return per page for paged search results
    # + cursor - Search parameter for cursor (token) - An identifier for the first resource to return
    # + result - Search parameter for result (reference) - DiagnostReport
    # + performer - Search parameter for performer (reference) - DiagnosticReport
    # + ah_chart_sharing_group - Search parameter for ah-chart-sharing-group (reference) - Search by athena Chart Sharing Group for resources containing the 'athena Chart Sharing Group' Extension
    # + _lastUpdated - Search parameter for _lastUpdated (date) - DiagnosticReport
    # + ah_practice - Search parameter for ah-practice (reference) - Search by Athena Practice for resources containing the 'Athena Practice' Extension
    # + _security - Search parameter for _security (token) - Search by a security label
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search DiagnosticReport resources"}
    remote function searchDiagnosticReport(
            string? _id = (),
            string? _query = (),
            string? encounter = (),
            string? patient = (),
            string? _include = (),
            string? _revinclude = (),
            string? category = (),
            string? code = (),
            string? date = (),
            string? _count = (),
            string? cursor = (),
            string? result = (),
            string? performer = (),
            string? ah_chart_sharing_group = (),
            string[]? _lastUpdated = (),
            string? ah_practice = (),
            string? _security = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "_query", _query);
        addIfPresent(params, "encounter", encounter);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "_include", _include);
        addIfPresent(params, "_revinclude", _revinclude);
        addIfPresent(params, "category", category);
        addIfPresent(params, "code", code);
        addIfPresent(params, "date", date);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "cursor", cursor);
        addIfPresent(params, "result", result);
        addIfPresent(params, "performer", performer);
        addIfPresent(params, "ah-chart-sharing-group", ah_chart_sharing_group);
        addIfPresent(params, "_lastUpdated", _lastUpdated);
        addIfPresent(params, "ah-practice", ah_practice);
        addIfPresent(params, "_security", _security);

        return self.fhirConnectorObj->search("DiagnosticReport", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the DocumentReference resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get DocumentReference by the logical ID"}
    remote function getDocumentReferenceById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("DocumentReference", id);
    }

    # + _id - Search parameter for _id (token) - DocumentReference
    # + patient - Search parameter for patient (reference) - DocumentReference
    # + _include - Search parameter for _include (special) - DocumentReference
    # + _query - Search parameter for _query (string) - Custom named query
    # + _revinclude - Search parameter for _revinclude (special) - DocumentReference
    # + _sort - Search parameter for _sort (special) - DocumentReference
    # + category - Search parameter for category (token) - DocumentReference
    # + 'type - Search parameter for type (token) - DocumentReference
    # + date - Search parameter for date (date) - DocumentReference
    # + _count - Search parameter for _count (number) - The number of DocumentReference resources to return per page for paged search results
    # + cursor - Search parameter for cursor (token) - An identifier for the first resource to return
    # + encounter - Search parameter for encounter (reference) - DocumentReference
    # + author - Search parameter for author (reference) - DocumentReference
    # + custodian - Search parameter for custodian (reference) - DocumentReference
    # + _lastUpdated - Search parameter for _lastUpdated (date) - Last updated parameter consists of a comparator (eq, gt, lt, ge and le) and a date (format: YYYY-MM-DD)
    # + ah_chart_sharing_group - Search parameter for ah-chart-sharing-group (reference) - Search by athena Chart Sharing Group for resources containing the 'athena Chart Sharing Group' Extension
    # + ah_published_date_time_to_portal - Search parameter for ah-published-date-time-to-portal (date) - Search by athenahealth Published Date Time To Portal (e
    # + ah_practice - Search parameter for ah-practice (reference) - Search by Athena Practice for resources containing the 'Athena Practice' Extension
    # + _security - Search parameter for _security (token) - Search by a security label
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search DocumentReference resources"}
    remote function searchDocumentReference(
            string? _id = (),
            string? patient = (),
            string? _include = (),
            string? _query = (),
            string? _revinclude = (),
            string? _sort = (),
            string? category = (),
            string? 'type = (),
            string? date = (),
            string? _count = (),
            string? cursor = (),
            string? encounter = (),
            string? author = (),
            string? custodian = (),
            string[]? _lastUpdated = (),
            string? ah_chart_sharing_group = (),
            string? ah_published_date_time_to_portal = (),
            string? ah_practice = (),
            string? _security = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "_include", _include);
        addIfPresent(params, "_query", _query);
        addIfPresent(params, "_revinclude", _revinclude);
        addIfPresent(params, "_sort", _sort);
        addIfPresent(params, "category", category);
        addIfPresent(params, "type", 'type);
        addIfPresent(params, "date", date);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "cursor", cursor);
        addIfPresent(params, "encounter", encounter);
        addIfPresent(params, "author", author);
        addIfPresent(params, "custodian", custodian);
        addIfPresent(params, "_lastUpdated", _lastUpdated);
        addIfPresent(params, "ah-chart-sharing-group", ah_chart_sharing_group);
        addIfPresent(params, "ah-published-date-time-to-portal", ah_published_date_time_to_portal);
        addIfPresent(params, "ah-practice", ah_practice);
        addIfPresent(params, "_security", _security);

        return self.fhirConnectorObj->search("DocumentReference", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the Encounter resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Encounter by the logical ID"}
    remote function getEncounterById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Encounter", id);
    }

    # + _id - Search parameter for _id (token) - Encounter
    # + patient - Search parameter for patient (reference) - Encounter
    # + date - Search parameter for date (date) - Encounter
    # + _revinclude - Search parameter for _revinclude (special) - Encounter
    # + _include - Search parameter for _include (special) - Encounter
    # + _count - Search parameter for _count (number) - The number of Encounter resources to return per page for paged search results
    # + cursor - Search parameter for cursor (token) - An identifier for the first resource to return
    # + ah_chart_sharing_group - Search parameter for ah-chart-sharing-group (reference) - Search by Athena Chart Sharing Group for resources containing the 'Athena Chart Sharing Group' Extension
    # + ah_practice - Search parameter for ah-practice (reference) - Search by Athena Practice for resources containing the 'Athena Practice' Extension
    # + _lastUpdated - Search parameter for _lastUpdated (date) - Last updated date associated with the encounter (format: YYYY-MM-DD)
    # + location - Search parameter for location (reference) - Encounter
    # + service_provider - Search parameter for service-provider (reference) - Encounter
    # + practitioner - Search parameter for practitioner (reference) - Encounter
    # + _security - Search parameter for _security (token) - Search by a security label
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Encounter resources"}
    remote function searchEncounter(
            string? _id = (),
            string? patient = (),
            string? date = (),
            string? _revinclude = (),
            string? _include = (),
            string? _count = (),
            string? cursor = (),
            string? ah_chart_sharing_group = (),
            string? ah_practice = (),
            string[]? _lastUpdated = (),
            string? location = (),
            string? service_provider = (),
            string? practitioner = (),
            string? _security = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "date", date);
        addIfPresent(params, "_revinclude", _revinclude);
        addIfPresent(params, "_include", _include);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "cursor", cursor);
        addIfPresent(params, "ah-chart-sharing-group", ah_chart_sharing_group);
        addIfPresent(params, "ah-practice", ah_practice);
        addIfPresent(params, "_lastUpdated", _lastUpdated);
        addIfPresent(params, "location", location);
        addIfPresent(params, "service-provider", service_provider);
        addIfPresent(params, "practitioner", practitioner);
        addIfPresent(params, "_security", _security);

        return self.fhirConnectorObj->search("Encounter", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the Goal resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Goal by the logical ID"}
    remote function getGoalById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Goal", id);
    }

    # + patient - Search parameter for patient (reference) - Goal
    # + _count - Search parameter for _count (number) - The number of Goal resources to return per page for paged search results
    # + _id - Search parameter for _id (token) - Goal
    # + _revinclude - Search parameter for _revinclude (special) - Goal
    # + _include - Search parameter for _include (special) - Goal
    # + _lastUpdated - Search parameter for _lastUpdated (date) - Last updated date associated with the Goal (format: YYYY-MM-DD)
    # + cursor - Search parameter for cursor (token) - An identifier for the first resource to return
    # + ah_brand - Search parameter for ah-brand (reference) - Search by Athena Brand for resources containing the 'Athena Brand' Extension
    # + ah_chart_sharing_group - Search parameter for ah-chart-sharing-group (reference) - Search by Athena Chart Sharing Group for resources containing the 'Athena Chart Sharing Group' Extension
    # + ah_practice - Search parameter for ah-practice (reference) - Search by Athena Practice for resources containing the 'Athena Practice' Extension
    # + ah_department - Search parameter for ah-department (reference) - Search by Athena Department for resources containing the 'Athena Department' Extension
    # + ah_provider_group - Search parameter for ah-provider-group (reference) - Search by Athena Provider Group for resources containing the 'Athena Provider Group' Extension
    # + _security - Search parameter for _security (token) - Search by a security label
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Goal resources"}
    remote function searchGoal(
            string? patient = (),
            string? _count = (),
            string? _id = (),
            string? _revinclude = (),
            string? _include = (),
            string[]? _lastUpdated = (),
            string? cursor = (),
            string? ah_brand = (),
            string? ah_chart_sharing_group = (),
            string? ah_practice = (),
            string? ah_department = (),
            string? ah_provider_group = (),
            string? _security = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "_revinclude", _revinclude);
        addIfPresent(params, "_include", _include);
        addIfPresent(params, "_lastUpdated", _lastUpdated);
        addIfPresent(params, "cursor", cursor);
        addIfPresent(params, "ah-brand", ah_brand);
        addIfPresent(params, "ah-chart-sharing-group", ah_chart_sharing_group);
        addIfPresent(params, "ah-practice", ah_practice);
        addIfPresent(params, "ah-department", ah_department);
        addIfPresent(params, "ah-provider-group", ah_provider_group);
        addIfPresent(params, "_security", _security);

        return self.fhirConnectorObj->search("Goal", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the Immunization resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Immunization by the logical ID"}
    remote function getImmunizationById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Immunization", id);
    }

    # + _include - Search parameter for _include (special) - Resource reference to FHIR referenced resources - use with patient
    # + encounter - Search parameter for encounter (reference) - Resource reference to FHIR Encounter resource - use with patient
    # + patient - Search parameter for patient (reference) - Reference to patient related to the resource
    # + date - Search parameter for date (date) - occurence date - use with patient
    # + status - Search parameter for status (token) - Vaccine status - use with patient
    # + _revinclude - Search parameter for _revinclude (special) - Resource reference to FHIR Provenance resource - use with patient
    # + _id - Search parameter for _id (token) - Immunization
    # + _count - Search parameter for _count (number) - The number of Immunization resources to return per page for paged search results
    # + cursor - Search parameter for cursor (token) - An identifier for the first resource to return - use with patient
    # + ah_chart_sharing_group - Search parameter for ah-chart-sharing-group (reference) - Search by Athena Chart Sharing Group for resources containing the 'Athena Chart Sharing Group' Extension - use with patient
    # + ah_practice - Search parameter for ah-practice (reference) - Search by Athena Brand for resources containing the 'Athena Practice' Extension - use with patient
    # + _lastUpdated - Search parameter for _lastUpdated (date) - Last updated date associated with the Immunization
    # + vaccine_code - Search parameter for vaccine-code (token) - Code associated with vaccine Product Administered
    # + _security - Search parameter for _security (token) - Search by a security label
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Immunization resources"}
    remote function searchImmunization(
            string? _include = (),
            string? encounter = (),
            string? patient = (),
            string? date = (),
            string? status = (),
            string? _revinclude = (),
            string? _id = (),
            string? _count = (),
            string? cursor = (),
            string? ah_chart_sharing_group = (),
            string? ah_practice = (),
            string[]? _lastUpdated = (),
            string? vaccine_code = (),
            string? _security = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_include", _include);
        addIfPresent(params, "encounter", encounter);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "date", date);
        addIfPresent(params, "status", status);
        addIfPresent(params, "_revinclude", _revinclude);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "cursor", cursor);
        addIfPresent(params, "ah-chart-sharing-group", ah_chart_sharing_group);
        addIfPresent(params, "ah-practice", ah_practice);
        addIfPresent(params, "_lastUpdated", _lastUpdated);
        addIfPresent(params, "vaccine-code", vaccine_code);
        addIfPresent(params, "_security", _security);

        return self.fhirConnectorObj->search("Immunization", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the Location resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Location by the logical ID"}
    remote function getLocationById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Location", id);
    }

    # + _id - Search parameter for _id (token) - Location
    # + ah_provider_group - Search parameter for ah-provider-group (reference) - Search by Athena Provider Group for resources containing the 'Athena Provider Group' Extension
    # + ah_chart_sharing_group - Search parameter for ah-chart-sharing-group (reference) - Search by Athena Chart Sharing Group for resources containing the 'Athena Chart Sharing Group' Extension
    # + ah_practice - Search parameter for ah-practice (reference) - Search by Athena Practice for resources containing the 'Athena Practice' Extension
    # + _security - Search parameter for _security (token) - Search by a security label
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Location resources"}
    remote function searchLocation(
            string? _id = (),
            string? ah_provider_group = (),
            string? ah_chart_sharing_group = (),
            string? ah_practice = (),
            string? _security = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "ah-provider-group", ah_provider_group);
        addIfPresent(params, "ah-chart-sharing-group", ah_chart_sharing_group);
        addIfPresent(params, "ah-practice", ah_practice);
        addIfPresent(params, "_security", _security);

        return self.fhirConnectorObj->search("Location", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the Medication resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Medication by the logical ID"}
    remote function getMedicationById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Medication", id);
    }

    # + _id - Search parameter for _id (token) - Medication
    # + ingredient_code - Search parameter for ingredient-code (token) - Resource reference to FHIR Medication ingredient resource
    # + ah_practice - Search parameter for ah-practice (reference) - Search by Athena Practice for resources containing the 'Athena Practice' Extension
    # + _security - Search parameter for _security (token) - Search by a security label
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Medication resources"}
    remote function searchMedication(
            string? _id = (),
            string? ingredient_code = (),
            string? ah_practice = (),
            string? _security = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "ingredient-code", ingredient_code);
        addIfPresent(params, "ah-practice", ah_practice);
        addIfPresent(params, "_security", _security);

        return self.fhirConnectorObj->search("Medication", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the MedicationRequest resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get MedicationRequest by the logical ID"}
    remote function getMedicationRequestById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("MedicationRequest", id);
    }

    # + patient - Search parameter for patient (reference) - Reference to a patient related to the prescription - use with intent
    # + intent - Search parameter for intent (token) - Intent type of the prescription - use with patient
    # + status - Search parameter for status (token) - Prescription status - use with patient and intent
    # + _id - Search parameter for _id (token) - MedicationRequest
    # + authoredon - Search parameter for authoredon (date) - Prescription creation date - use with patient and intent
    # + _include - Search parameter for _include (special) - Resource reference to FHIR Medication resource - use with patient and intent
    # + medication - Search parameter for medication (reference) - Resource reference to FHIR Medication resource
    # + subject - Search parameter for subject (reference) - Resource reference to FHIR patient resource
    # + encounter - Search parameter for encounter (reference) - Resource reference to FHIR encounter resource
    # + requester - Search parameter for requester (reference) - Resource reference to FHIR practitioner resource
    # + ah_chart_sharing_group - Search parameter for ah-chart-sharing-group (reference) - Search by Athena Brand for resources containing the 'Athena Chart Sharing Group' Extension - use with patient and intent
    # + ah_practice - Search parameter for ah-practice (reference) - Search by Athena Brand for resources containing the 'Athena Practice' Extension - use with patient and intent
    # + _revinclude - Search parameter for _revinclude (special) - Resource reference to FHIR Provenance resource - use with patient and intent
    # + _count - Search parameter for _count (number) - The number of MedicationRequest resources to return per page for paged search results
    # + code - Search parameter for code (token) - The MedicationRequest resources to return for the RXNORM code
    # + cursor - Search parameter for cursor (token) - An identifier for the first resource to return - use with patient and intent
    # + _lastUpdated - Search parameter for _lastUpdated (date) - Last updated date associated with the medication
    # + ingredient_code - Search parameter for ingredient-code (token) - Resource reference to FHIR Medication resource
    # + ah_most_recent_medication_instance_and_prescribed_vaccines - Search parameter for ah-most-recent-medication-instance-and-prescribed-vaccines (token) - Returns the most recent instance of the medication and prescribed vaccines
    # + _security - Search parameter for _security (token) - Search by a security label
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search MedicationRequest resources"}
    remote function searchMedicationRequest(
            string? patient = (),
            string? intent = (),
            string? status = (),
            string? _id = (),
            string? authoredon = (),
            string? _include = (),
            string? medication = (),
            string? subject = (),
            string? encounter = (),
            string? requester = (),
            string? ah_chart_sharing_group = (),
            string? ah_practice = (),
            string? _revinclude = (),
            string? _count = (),
            string? code = (),
            string? cursor = (),
            string[]? _lastUpdated = (),
            string? ingredient_code = (),
            string? ah_most_recent_medication_instance_and_prescribed_vaccines = (),
            string? _security = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "intent", intent);
        addIfPresent(params, "status", status);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "authoredon", authoredon);
        addIfPresent(params, "_include", _include);
        addIfPresent(params, "medication", medication);
        addIfPresent(params, "subject", subject);
        addIfPresent(params, "encounter", encounter);
        addIfPresent(params, "requester", requester);
        addIfPresent(params, "ah-chart-sharing-group", ah_chart_sharing_group);
        addIfPresent(params, "ah-practice", ah_practice);
        addIfPresent(params, "_revinclude", _revinclude);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "code", code);
        addIfPresent(params, "cursor", cursor);
        addIfPresent(params, "_lastUpdated", _lastUpdated);
        addIfPresent(params, "ingredient-code", ingredient_code);
        addIfPresent(params, "ah-most-recent-medication-instance-and-prescribed-vaccines", ah_most_recent_medication_instance_and_prescribed_vaccines);
        addIfPresent(params, "_security", _security);

        return self.fhirConnectorObj->search("MedicationRequest", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the Observation resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Observation by the logical ID"}
    remote function getObservationById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Observation", id);
    }

    # + _id - Search parameter for _id (token) - Observation
    # + patient - Search parameter for patient (reference) - Observation
    # + _revinclude - Search parameter for _revinclude (special) - Observation
    # + _include - Search parameter for _include (special) - Observation
    # + date - Search parameter for date (date) - Observation
    # + category - Search parameter for category (token) - Observation
    # + code - Search parameter for code (token) - Observation
    # + encounter - Search parameter for encounter (reference) - Observation
    # + _count - Search parameter for _count (number) - The number of Observation resources to return per page for paged search results
    # + cursor - Search parameter for cursor (token) - An identifier for the first resource to return
    # + ah_chart_sharing_group - Search parameter for ah-chart-sharing-group (reference) - Search by athena Chart Sharing Group for resources containing the 'athena Chart Sharing Group' Extension
    # + ah_practice - Search parameter for ah-practice (reference) - Search by athena Practice for resources containing the 'athena Practice' Extension
    # + _lastUpdated - Search parameter for _lastUpdated (date) - Last updated parameter consists of a comparator (eq, gt, lt, ge and le) and a date (format: YYYY-MM-DD)
    # + _security - Search parameter for _security (token) - Search by a security label
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Observation resources"}
    remote function searchObservation(
            string? _id = (),
            string? patient = (),
            string? _revinclude = (),
            string? _include = (),
            string? date = (),
            string? category = (),
            string? code = (),
            string? encounter = (),
            string? _count = (),
            string? cursor = (),
            string? ah_chart_sharing_group = (),
            string? ah_practice = (),
            string[]? _lastUpdated = (),
            string? _security = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "_revinclude", _revinclude);
        addIfPresent(params, "_include", _include);
        addIfPresent(params, "date", date);
        addIfPresent(params, "category", category);
        addIfPresent(params, "code", code);
        addIfPresent(params, "encounter", encounter);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "cursor", cursor);
        addIfPresent(params, "ah-chart-sharing-group", ah_chart_sharing_group);
        addIfPresent(params, "ah-practice", ah_practice);
        addIfPresent(params, "_lastUpdated", _lastUpdated);
        addIfPresent(params, "_security", _security);

        return self.fhirConnectorObj->search("Observation", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the Organization resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Organization by the logical ID"}
    remote function getOrganizationById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Organization", id);
    }

    # + _id - Search parameter for _id (token) - Organization
    # + ah_provider_group - Search parameter for ah-provider-group (reference) - Search by Athena Provider Group for resources containing the 'Athena Provider Group' Extension
    # + ah_chart_sharing_group - Search parameter for ah-chart-sharing-group (reference) - Search by Athena Chart Sharing Group for resources containing the 'Athena Chart Sharing Group' Extension
    # + ah_practice - Search parameter for ah-practice (reference) - Search by Athena Practice for resources containing the 'Athena Practice' Extension
    # + _security - Search parameter for _security (token) - Search by a security label
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Organization resources"}
    remote function searchOrganization(
            string? _id = (),
            string? ah_provider_group = (),
            string? ah_chart_sharing_group = (),
            string? ah_practice = (),
            string? _security = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "ah-provider-group", ah_provider_group);
        addIfPresent(params, "ah-chart-sharing-group", ah_chart_sharing_group);
        addIfPresent(params, "ah-practice", ah_practice);
        addIfPresent(params, "_security", _security);

        return self.fhirConnectorObj->search("Organization", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the Patient resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Patient by the logical ID"}
    remote function getPatientById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Patient", id);
    }

    # + _id - Search parameter for _id (token) - Patient
    # + identifier - Search parameter for identifier (token) - A patient identifier
    # + name - Search parameter for name (string) - A server defined search that may match any of the string fields in the HumanName, including family, given, prefix, suffix, suffix, and/or text
    # + birthdate - Search parameter for birthdate (date) - The patient's date of birth
    # + gender - Search parameter for gender (token) - Gender of the patient
    # + family - Search parameter for family (string) - A portion of the family name of the patient
    # + given - Search parameter for given (string) - A portion of the given name of the patient
    # + _lastUpdated - Search parameter for _lastUpdated (date) - Last updated date of the patient (_lastUpdated may only be used in conjunction with other supported search parameter combinations)
    # + ah_brand - Search parameter for ah-brand (reference) - Search by Athena Brand for resources containing the 'Athena Brand' Extension
    # + ah_chart_sharing_group - Search parameter for ah-chart-sharing-group (reference) - Search by Athena Chart Sharing Group for resources containing the 'Athena Chart Sharing Group' Extension
    # + ah_department - Search parameter for ah-department (reference) - Search by Athena Department for resources containing the 'Athena Department' Extension
    # + ah_provider_group - Search parameter for ah-provider-group (reference) - Search by Athena Provider Group for resources containing the 'Athena Provider Group' Extension
    # + _count - Search parameter for _count (number) - The number of Patient resources to return per page for paged search results
    # + cursor - Search parameter for cursor (token) - An identifier for the first resource to return
    # + _include - Search parameter for _include (special) - Include resources that reference specified value
    # + _revinclude - Search parameter for _revinclude (special) - Other resources to include in the search results when they refer to search matches
    # + ah_practice - Search parameter for ah-practice (reference) - Search by Athena Practice for resources containing the 'Athena Practice' Extension
    # + _security - Search parameter for _security (token) - Search by a security label
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Patient resources"}
    remote function searchPatient(
            string? _id = (),
            string? identifier = (),
            string? name = (),
            string? birthdate = (),
            string? gender = (),
            string? family = (),
            string? given = (),
            string[]? _lastUpdated = (),
            string? ah_brand = (),
            string? ah_chart_sharing_group = (),
            string? ah_department = (),
            string? ah_provider_group = (),
            string? _count = (),
            string? cursor = (),
            string? _include = (),
            string? _revinclude = (),
            string? ah_practice = (),
            string? _security = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "name", name);
        addIfPresent(params, "birthdate", birthdate);
        addIfPresent(params, "gender", gender);
        addIfPresent(params, "family", family);
        addIfPresent(params, "given", given);
        addIfPresent(params, "_lastUpdated", _lastUpdated);
        addIfPresent(params, "ah-brand", ah_brand);
        addIfPresent(params, "ah-chart-sharing-group", ah_chart_sharing_group);
        addIfPresent(params, "ah-department", ah_department);
        addIfPresent(params, "ah-provider-group", ah_provider_group);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "cursor", cursor);
        addIfPresent(params, "_include", _include);
        addIfPresent(params, "_revinclude", _revinclude);
        addIfPresent(params, "ah-practice", ah_practice);
        addIfPresent(params, "_security", _security);

        return self.fhirConnectorObj->search("Patient", mode = fhirClient:POST, searchParameters = params);
    }

remote function healthCardsIssuePatientOperation(@display {label: "Request Mode"} fhirClient:RequestMode mode = fhirClient:POST,
                                                                             @display {label: "Logical ID"} string? id = (),
                                                                             @display {label: "Query Parameters"} map<string[]>? queryParameters = (),
                                                                             @display {label: "Resource data"} json|xml? data = ())
        returns fhirClient:FHIRResponse|fhirClient:FHIRError {
    return check self.fhirConnectorObj->callOperation("Patient", "$health-cards-issue", mode, id, queryParameters, data);
}

    # + id - The logical ID of the Practitioner resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Practitioner by the logical ID"}
    remote function getPractitionerById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Practitioner", id);
    }

    # + _id - Search parameter for _id (token) - Practitioner
    # + ah_provider_group - Search parameter for ah-provider-group (reference) - Search by Athena Provider Group for resources containing the 'Athena Provider Group' Extension
    # + identifier - Search parameter for identifier (token) - Search by athenaNet username identifier (e
    # + ah_practice - Search parameter for ah-practice (reference) - Search by Athenahealth Practice for resources under a specific practice
    # + _security - Search parameter for _security (token) - Search by a security label
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Practitioner resources"}
    remote function searchPractitioner(
            string? _id = (),
            string? ah_provider_group = (),
            string? identifier = (),
            string? ah_practice = (),
            string? _security = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "ah-provider-group", ah_provider_group);
        addIfPresent(params, "identifier", identifier);
        addIfPresent(params, "ah-practice", ah_practice);
        addIfPresent(params, "_security", _security);

        return self.fhirConnectorObj->search("Practitioner", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the Procedure resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Procedure by the logical ID"}
    remote function getProcedureById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Procedure", id);
    }

    # + patient - Search parameter for patient (reference) - Procedure
    # + date - Search parameter for date (date) - Procedure
    # + _revinclude - Search parameter for _revinclude (special) - Procedure
    # + _count - Search parameter for _count (number) - The number of Procedure resources to return per page for paged search results
    # + cursor - Search parameter for cursor (token) - An identifier for the first resource to return
    # + ah_chart_sharing_group - Search parameter for ah-chart-sharing-group (reference) - Search by Athena Chart Sharing Group for resources containing the 'Athena Chart Sharing Group' Extension'
    # + encounter - Search parameter for encounter (reference) - Procedure
    # + _include - Search parameter for _include (special) - Procedure
    # + performer - Search parameter for performer (reference) - Procedure
    # + ah_provider_group - Search parameter for ah-provider-group (reference) - Search by Athena Provider Group for resources containing the 'Athena Provider Group' Extension
    # + device_name - Search parameter for device-name (reference) - Procedure
    # + _id - Search parameter for _id (token) - Procedure
    # + _lastUpdated - Search parameter for _lastUpdated (date) - Last updated date associated with the procedure (format: YYYY-MM-DD)
    # + ah_practice - Search parameter for ah-practice (reference) - Search by Athena Practice for resources containing the 'Athena Practice' Extension
    # + _security - Search parameter for _security (token) - Search by a security label
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Procedure resources"}
    remote function searchProcedure(
            string? patient = (),
            string? date = (),
            string? _revinclude = (),
            string? _count = (),
            string? cursor = (),
            string? ah_chart_sharing_group = (),
            string? encounter = (),
            string? _include = (),
            string? performer = (),
            string? ah_provider_group = (),
            string? device_name = (),
            string? _id = (),
            string[]? _lastUpdated = (),
            string? ah_practice = (),
            string? _security = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "date", date);
        addIfPresent(params, "_revinclude", _revinclude);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "cursor", cursor);
        addIfPresent(params, "ah-chart-sharing-group", ah_chart_sharing_group);
        addIfPresent(params, "encounter", encounter);
        addIfPresent(params, "_include", _include);
        addIfPresent(params, "performer", performer);
        addIfPresent(params, "ah-provider-group", ah_provider_group);
        addIfPresent(params, "device-name", device_name);
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "_lastUpdated", _lastUpdated);
        addIfPresent(params, "ah-practice", ah_practice);
        addIfPresent(params, "_security", _security);

        return self.fhirConnectorObj->search("Procedure", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the Provenance resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Provenance by the logical ID"}
    remote function getProvenanceById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Provenance", id);
    }

    # + target - Search parameter for target (reference) - Provenance
    # + _include - Search parameter for _include (special) - Provenance
    # + ah_practice - Search parameter for ah-practice (reference) - Search by Athena Practice for resources containing the 'Athena Practice' Extension
    # + _security - Search parameter for _security (token) - Search by a security label
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Provenance resources"}
    remote function searchProvenance(
            string? target = (),
            string? _include = (),
            string? ah_practice = (),
            string? _security = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "target", target);
        addIfPresent(params, "_include", _include);
        addIfPresent(params, "ah-practice", ah_practice);
        addIfPresent(params, "_security", _security);

        return self.fhirConnectorObj->search("Provenance", mode = fhirClient:POST, searchParameters = params);
    }

    # + id - The logical ID of the ServiceRequest resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get ServiceRequest by the logical ID"}
    remote function getServiceRequestById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("ServiceRequest", id);
    }

    # + _id - Search parameter for _id (token) - ServiceRequest
    # + encounter - Search parameter for encounter (reference) - Resource reference to FHIR Encounter resource
    # + patient - Search parameter for patient (reference) - ServiceRequest
    # + _count - Search parameter for _count (number) - The number of ServiceRequest resources to return per page for paged search results
    # + status - Search parameter for status (token) - ServiceRequest
    # + authored - Search parameter for authored (date) - ServiceRequest
    # + _lastUpdated - Search parameter for _lastUpdated (date) - Last updated parameter for searching service requests resources by the last time that they changed
    # + cursor - Search parameter for cursor (token) - An identifier for the first resource to return
    # + performer - Search parameter for performer (reference) - ServiceRequest
    # + requester - Search parameter for requester (reference) - ServiceRequest
    # + _include - Search parameter for _include (special) - ServiceRequest
    # + _revinclude - Search parameter for _revinclude (special) - ServiceRequest
    # + ah_chart_sharing_group - Search parameter for ah-chart-sharing-group (reference) - Search by athena Chart Sharing Group for resources containing the 'athena Chart Sharing Group' Extension
    # + ah_practice - Search parameter for ah-practice (reference) - Search by Athena Practice for resources containing the 'Athena Practice' Extension
    # + code - Search parameter for code (token) - ServiceRequest
    # + category - Search parameter for category (token) - ServiceRequest
    # + _security - Search parameter for _security (token) - Search by a security label
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search ServiceRequest resources"}
    remote function searchServiceRequest(
            string? _id = (),
            string? encounter = (),
            string? patient = (),
            string? _count = (),
            string? status = (),
            string? authored = (),
            string[]? _lastUpdated = (),
            string? cursor = (),
            string? performer = (),
            string? requester = (),
            string? _include = (),
            string? _revinclude = (),
            string? ah_chart_sharing_group = (),
            string? ah_practice = (),
            string? code = (),
            string? category = (),
            string? _security = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "encounter", encounter);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "_count", _count);
        addIfPresent(params, "status", status);
        addIfPresent(params, "authored", authored);
        addIfPresent(params, "_lastUpdated", _lastUpdated);
        addIfPresent(params, "cursor", cursor);
        addIfPresent(params, "performer", performer);
        addIfPresent(params, "requester", requester);
        addIfPresent(params, "_include", _include);
        addIfPresent(params, "_revinclude", _revinclude);
        addIfPresent(params, "ah-chart-sharing-group", ah_chart_sharing_group);
        addIfPresent(params, "ah-practice", ah_practice);
        addIfPresent(params, "code", code);
        addIfPresent(params, "category", category);
        addIfPresent(params, "_security", _security);

        return self.fhirConnectorObj->search("ServiceRequest", mode = fhirClient:POST, searchParameters = params);
    }

    remote function exportGroupOperation(@display {label: "Request Mode"} fhirClient:RequestMode mode = fhirClient:POST,
                                                                             @display {label: "Logical ID"} string? id = (),
                                                                             @display {label: "Query Parameters"} map<string[]>? queryParameters = (),
                                                                             @display {label: "Resource data"} json|xml? data = ())
        returns fhirClient:FHIRResponse|fhirClient:FHIRError {
    return check self.fhirConnectorObj->callOperation("Group", "$export", mode, id, queryParameters, data);
}

        # + newQuestionnaireResponse - A new instance of the QuestionnaireResponse resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Create QuestionnaireResponse resource"}
    remote function createQuestionnaireResponse(resourceInternational:QuestionnaireResponse newQuestionnaireResponse)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->create(newQuestionnaireResponse.toJson());
    }

    # + _id - Search parameter for _id (token) - The ID of the resource
    # + _lastUpdated - Search parameter for _lastUpdated (date) - Only return resources which were last updated as specified by the given range
    # + ah_chart_sharing_group - Search parameter for ah-chart-sharing-group (reference) - 
    # + ah_practice - Search parameter for ah-practice (reference) - 
    # + authored - Search parameter for authored (date) - When the questionnaire response was last changed
    # + encounter - Search parameter for encounter (reference) - Encounter associated with the questionnaire response
    # + patient - Search parameter for patient (reference) - The patient that is the subject of the questionnaire response
    # + questionnaireCode - Search parameter for questionnaireCode (token) - 
    # + status - Search parameter for status (string) - The status of the questionnaire response
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search QuestionnaireResponse resources"}
    remote function searchQuestionnaireResponse(
            string? _id = (),
            string[]? _lastUpdated = (),
            string? ah_chart_sharing_group = (),
            string? ah_practice = (),
            string? authored = (),
            string? encounter = (),
            string? patient = (),
            string? questionnaireCode = (),
            string? status = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "_lastUpdated", _lastUpdated);
        addIfPresent(params, "ah-chart-sharing-group", ah_chart_sharing_group);
        addIfPresent(params, "ah-practice", ah_practice);
        addIfPresent(params, "authored", authored);
        addIfPresent(params, "encounter", encounter);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "questionnaireCode", questionnaireCode);
        addIfPresent(params, "status", status);

        return self.fhirConnectorObj->search("QuestionnaireResponse", mode = fhirClient:POST, searchParameters = params);
    }

# + id - The logical ID of the QuestionnaireResponse resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get QuestionnaireResponse by the logical ID"}
    remote function getQuestionnaireResponseById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("QuestionnaireResponse", id);
    }

remote function latestResponseByQuestionnaireQuestionnaireResponseOperation(@display {label: "Request Mode"} fhirClient:RequestMode mode = fhirClient:POST,
                                                                             @display {label: "Logical ID"} string? id = (),
                                                                             @display {label: "Query Parameters"} map<string[]>? queryParameters = (),
                                                                             @display {label: "Resource data"} json|xml? data = ())
        returns fhirClient:FHIRResponse|fhirClient:FHIRError {
    return check self.fhirConnectorObj->callOperation("QuestionnaireResponse", "$latest-response-by-questionnaire", mode, id, queryParameters, data);
}

    remote function submitCareGapsMeasureReportOperation(@display {label: "Request Mode"} fhirClient:RequestMode mode = fhirClient:POST,
                                                                             @display {label: "Logical ID"} string? id = (),
                                                                             @display {label: "Query Parameters"} map<string[]>? queryParameters = (),
                                                                             @display {label: "Resource data"} json|xml? data = ())
        returns fhirClient:FHIRResponse|fhirClient:FHIRError {
    return check self.fhirConnectorObj->callOperation("MeasureReport", "$submit-care-gaps", mode, id, queryParameters, data);
}

    # + id - The logical ID of the Media resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Media by the logical ID"}
    remote function getMediaById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Media", id);
    }

        # + _id - Search parameter for _id (token) - The ID of the resource
    # + _lastUpdated - Search parameter for _lastUpdated (date) - Only return resources which were last updated as specified by the given range
    # + ah_chart_sharing_group - Search parameter for ah-chart-sharing-group (reference) - 
    # + ah_practice - Search parameter for ah-practice (reference) - 
    # + date - Search parameter for date (date) - 
    # + patient - Search parameter for patient (reference) - The identity of a patient to list dispenses  for
    # + status - Search parameter for status (token) - Returns dispenses with a specified dispense status
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search MedicationDispense resources"}
    remote function searchMedicationDispense(
            string? _id = (),
            string[]? _lastUpdated = (),
            string? ah_chart_sharing_group = (),
            string? ah_practice = (),
            string? date = (),
            string? patient = (),
            string? status = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "_lastUpdated", _lastUpdated);
        addIfPresent(params, "ah-chart-sharing-group", ah_chart_sharing_group);
        addIfPresent(params, "ah-practice", ah_practice);
        addIfPresent(params, "date", date);
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "status", status);

        return self.fhirConnectorObj->search("MedicationDispense", mode = fhirClient:POST, searchParameters = params);
    }

# + id - The logical ID of the MedicationDispense resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get MedicationDispense by the logical ID"}
    remote function getMedicationDispenseById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("MedicationDispense", id);
    }

        # + _id - Search parameter for _id (token) - The ID of the resource
    # + _lastUpdated - Search parameter for _lastUpdated (date) - Only return resources which were last updated as specified by the given range
    # + ah_chart_sharing_group - Search parameter for ah-chart-sharing-group (reference) - 
    # + patient - Search parameter for patient (reference) - The patient the specimen comes from
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search Specimen resources"}
    remote function searchSpecimen(
            string? _id = (),
            string[]? _lastUpdated = (),
            string? ah_chart_sharing_group = (),
            string? patient = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "_id", _id);
        addIfPresent(params, "_lastUpdated", _lastUpdated);
        addIfPresent(params, "ah-chart-sharing-group", ah_chart_sharing_group);
        addIfPresent(params, "patient", patient);

        return self.fhirConnectorObj->search("Specimen", mode = fhirClient:POST, searchParameters = params);
    }

# + id - The logical ID of the Specimen resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get Specimen by the logical ID"}
    remote function getSpecimenById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("Specimen", id);
    }

        # + patient - Search parameter for patient (reference) - The patient this related person is related to
    # + _lastUpdated - Search parameter for _lastUpdated (date) - Only return resources which were last updated as specified by the given range
    # + active - Search parameter for active (token) - Indicates if the related person record is active
    # + ah_brand - Search parameter for ah-brand (reference) - The brand extension this related person belongs to
    # + ah_chart_sharing_group - Search parameter for ah-chart-sharing-group (reference) - The chart sharing group this related person belongs to
    # + ah_provider_group - Search parameter for ah-provider-group (reference) - The provider group this related person belongs to
    # + name - Search parameter for name (string) - A server defined search that may match any of the string fields in the HumanName, including family, give, prefix, suffix, suffix, and/or text
    # + _id - Search parameter for _id (string) - The ID of the resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Search RelatedPerson resources"}
    remote function searchRelatedPerson(
            string? patient = (),
            string[]? _lastUpdated = (),
            string? active = (),
            string? ah_brand = (),
            string? ah_chart_sharing_group = (),
            string? ah_provider_group = (),
            string? name = (),
            string? _id = ()
    ) returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        fhirClient:SearchParameters params = {};
        addIfPresent(params, "patient", patient);
        addIfPresent(params, "_lastUpdated", _lastUpdated);
        addIfPresent(params, "active", active);
        addIfPresent(params, "ah-brand", ah_brand);
        addIfPresent(params, "ah-chart-sharing-group", ah_chart_sharing_group);
        addIfPresent(params, "ah-provider-group", ah_provider_group);
        addIfPresent(params, "name", name);
        addIfPresent(params, "_id", _id);

        return self.fhirConnectorObj->search("RelatedPerson", mode = fhirClient:POST, searchParameters = params);
    }

# + id - The logical ID of the RelatedPerson resource
    # + return - Returns a FHIRResponse or FHIRError for the operation
    @display {label: "Get RelatedPerson by the logical ID"}
    remote function getRelatedPersonById(@display {label: "Logical ID"} string id)
                    returns fhirClient:FHIRResponse|fhirClient:FHIRError {
        return check self.fhirConnectorObj->getById("RelatedPerson", id);
    }

}
