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

# FHIR accepted MIME types
public enum MimeType {
    FHIR_JSON = "application/fhir+json",
    FHIR_XML = "application/fhir+xml"
}

# Types of resources 
public enum ResourceType {
    ACCOUNT = "Account",
    ACTIVITY_DEFINITION = "ActivityDefinition",
    ADVERSE_EVENT = "AdverseEvent",
    ALLERGY_INTOLERANCE = "AllergyIntolerance",
    APPOINTMENT = "Appointment",
    APPOINTMENT_RESPONSE = "AppointmentResponse",
    AUDIT_EVENT = "AuditEvent",
    BASIC = "Basic",
    BINARY = "Binary",
    BIOLOGICALLY_DERIVED_PRODUCT = "BiologicallyDerivedProduct",
    BODY_STRUCTURE = "BodyStructure",
    BUNDLE = "Bundle",
    CAPABILITY_STATEMENT = "CapabilityStatement",
    CARE_PLAN = "CarePlan",
    CARE_TEAM = "CareTeam",
    CATALOG_ENTRY = "CatalogEntry",
    CHARGE_ITEM = "ChargeItem",
    CHARGE_ITEM_DEFINITION = "ChargeItemDefinition",
    CLAIM = "Claim",
    CLAIM_RESPONSE = "ClaimResponse",
    CLINICAL_IMPRESSION = "ClinicalImpression",
    CODE_SYSTEM = "CodeSystem",
    COMMUNICATION = "Communication",
    COMMUNICATION_REQUEST = "CommunicationRequest",
    COMPARTMENT_DEFINITION = "CompartmentDefinition",
    COMPOSITION = "Composition",
    CONCEPT_MAP = "ConceptMap",
    CONDITION = "Condition",
    CONSENT = "Consent",
    CONTRACT = "Contract",
    COVERAGE = "Coverage",
    COVERAGE_ELIGIBILITY_REQUEST = "CoverageEligibilityRequest",
    COVERAGE_ELIGIBILITY_RESPONSE = "CoverageEligibilityResponse",
    DETECTED_ISSUE = "DetectedIssue",
    DEVICE = "Device",
    DEVICE_DEFINITION = "DeviceDefinition",
    DEVICE_METRIC = "DeviceMetric",
    DEVICE_REQUEST = "DeviceRequest",
    DEVICE_USE_STATEMENT = "DeviceUseStatement",
    DIAGNOSTIC_REPORT = "DiagnosticReport",
    DOCUMENT_MANIFEST = "DocumentManifest",
    DOCUMENT_REFERENCE = "DocumentReference",
    DOMAIN_RESOURCE = "DomainResource",
    EFFECT_EVIDENCE_SYNTHESIS = "EffectEvidenceSynthesis",
    ENCOUNTER = "Encounter",
    ENDPOINT = "Endpoint",
    ENROLLMENT_REQUEST = "EnrollmentRequest",
    ENROLLMENT_RESPONSE = "EnrollmentResponse",
    EPISODE_OF_CARE = "EpisodeOfCare",
    EVENT_DEFINITION = "EventDefinition",
    EVIDENCE = "Evidence",
    EVIDENCE_VARIABLE = "EvidenceVariable",
    EXAMPLE_SCENARIO = "ExampleScenario",
    EXPLANATION_OF_BENEFIT = "ExplanationOfBenefit",
    FAMILY_MEMBER_HISTORY = "FamilyMemberHistory",
    FLAG = "Flag",
    GOAL = "Goal",
    GRAPH_DEFINITION = "GraphDefinition",
    GROUP = "Group",
    GUIDANCE_RESPONSE = "GuidanceResponse",
    HEALTHCARE_SERVICE = "HealthcareService",
    IMAGING_STUDY = "ImagingStudy",
    IMMUNIZATION = "Immunization",
    IMMUNIZATION_EVALUATION = "ImmunizationEvaluation",
    IMMUNIZATION_RECOMMENDATION = "ImmunizationRecommendation",
    IMPLEMENTATION_GUIDE = "ImplementationGuide",
    INSURANCE_PLAN = "InsurancePlan",
    INVOICE = "Invoice",
    LIBRARY = "Library",
    LINKAGE = "Linkage",
    LIST = "List",
    LOCATION = "Location",
    MEASURE = "Measure",
    MEASURE_REPORT = "MeasureReport",
    MEDIA = "Media",
    MEDICATION = "Medication",
    MEDICATION_ADMINISTRATION = "MedicationAdministration",
    MEDICATION_DISPENSE = "MedicationDispense",
    MEDICATION_KNOWLEDGE = "MedicationKnowledge",
    MEDICATION_REQUEST = "MedicationRequest",
    MEDICATION_STATEMENT = "MedicationStatement",
    MEDICINAL_PRODUCT = "MedicinalProduct",
    MEDICINAL_PRODUCT_AUTHORIZATION = "MedicinalProductAuthorization",
    MEDICINAL_PRODUCT_CONTRAINDICATION = "MedicinalProductContraindication",
    MEDICINAL_PRODUCT_INDICATION = "MedicinalProductIndication",
    MEDICINAL_PRODUCT_INGREDIENT = "MedicinalProductIngredient",
    MEDICINAL_PRODUCT_INTERACTION = "MedicinalProductInteraction",
    MEDICINAL_PRODUCT_MANUFACTURED = "MedicinalProductManufactured",
    MEDICINAL_PRODUCT_PACKAGED = "MedicinalProductPackaged",
    MEDICINAL_PRODUCT_PHARMACEUTICAL = "MedicinalProductPharmaceutical",
    MEDICINAL_PRODUCT_UNDESIRABLE_EFFECT = "MedicinalProductUndesirableEffect",
    MESSAGE_DEFINITION = "MessageDefinition",
    MESSAGE_HEADER = "MessageHeader",
    MOLECULAR_SEQUENCE = "MolecularSequence",
    NAMING_SYSTEM = "NamingSystem",
    NUTRITION_ORDER = "NutritionOrder",
    OBSERVATION = "Observation",
    OBSERVATION_DEFINITION = "ObservationDefinition",
    OPERATION_DEFINITION = "OperationDefinition",
    OPERATION_OUTCOME = "OperationOutcome",
    ORGANIZATION = "Organization",
    ORGANIZATION_AFFILIATION = "OrganizationAffiliation",
    PARAMETERS = "Parameters",
    PATIENT = "Patient",
    PAYMENT_NOTICE = "PaymentNotice",
    PAYMENT_RECONCILIATION = "PaymentReconciliation",
    PERSON = "Person",
    PLAN_DEFINITION = "PlanDefinition",
    PRACTITIONER = "Practitioner",
    PRACTITIONER_ROLE = "PractitionerRole",
    PROCEDURE = "Procedure",
    PROVENANCE = "Provenance",
    QUESTIONNAIRE = "Questionnaire",
    QUESTIONNAIRE_RESPONSE = "QuestionnaireResponse",
    RELATED_PERSON = "RelatedPerson",
    REQUEST_GROUP = "RequestGroup",
    RESEARCH_DEFINITION = "ResearchDefinition",
    RESEARCH_ELEMENT_DEFINITION = "ResearchElementDefinition",
    RESEARCH_STUDY = "ResearchStudy",
    RESEARCH_SUBJECT = "ResearchSubject",
    RESOURCE = "Resource",
    RISK_ASSESSMENT = "RiskAssessment",
    SCHEDULE = "Schedule",
    SEARCH_PARAMETER = "SearchParameter",
    SERVICE_REQUEST = "ServiceRequest",
    SLOT = "Slot",
    SPECIMEN = "Specimen",
    SPECIMEN_DEFINITION = "SpecimenDefinition",
    STRUCTURE_DEFINITION = "StructureDefinition",
    STRUCTURE_MAP = "StructureMap",
    SUBSCRIPTION = "Subscription",
    SUBSTANCE = "Substance",
    SUBSTANCE_NUCLEIC_ACID = "SubstanceNucleicAcid",
    SUBSTANCE_POLYMER = "SubstancePolymer",
    SUBSTANCE_PROTEIN = "SubstanceProtein",
    SUBSTANCE_REFERENCE_INFORMATION = "SubstanceReferenceInformation",
    SUBSTANCE_SOURCE_MATERIAL = "SubstanceSourceMaterial",
    SUBSTANCE_SPECIFICATION = "SubstanceSpecification",
    SUPPLY_DELIVERY = "SupplyDelivery",
    SUPPLY_REQUEST = "SupplyRequest",
    TASK = "Task",
    TERMINOLOGY_CAPABILITIES = "TerminologyCapabilities",
    TEST_REPORT = "TestReport",
    TEST_SCRIPT = "TestScript",
    VALUE_SET = "ValueSet",
    VERIFICATION_RESULT = "VerificationResult",
    VISION_PRESCRIPTION = "VisionPrescription"
}

# Specifies the subset of the resource to be returned
public enum SummaryType {
    TRUE = "true",
    FALSE = "false",
    TEXT = "text",
    DATA = "data",
    COUNT = "count"
}

# Specifies the content that should return when performing create,update or patch 
public enum PreferenceType {
    MINIMAL = "minimal",
    REPRESENTATION = "representation",
    OPERATION_OUTCOME = "OperationOutcome"
}

# Specifies the information that should return in the capability statement
public enum ModeType {
    FULL = "full",
    NORMATIVE = "normative",
    TERMINOLOGY = "terminology"
}

# Types of a FHIR bundle
public enum BundleType {
    BATCH = "batch",
    TRANSACTION = "transaction"
}

# FHIR accepted PATCH content types
public enum PatchContentType {
    PATCH_JSON = "application/json-patch+json",
    PATCH_XML = "application/xml-patch+xml"
}

public enum BulkExportOutputType {
    FHIR_ND_JSON = "application/fhir+ndjson"
}

public enum BulkExportLevel {
    EXPORT_PATIENT = "Patient",
    EXPORT_SYSTEM = "System",
    EXPORT_GROUP = "Group"
}

public enum RequestMode {
    POST = "POST",
    GET = "GET"
};

# Constant symbols
const AMPERSAND = "&";
const SLASH = "/";
const QUOTATION_MARK = "\"";
const QUESTION_MARK = "?";
const EQUALS_SIGN = "=";
const COMMA = ",";
const DOLLAR_SIGN = "$";
const ENCODED_DOLLAR_SIGN = "%24";

# FHIR  parameters 
const _FORMAT = "_format";
const _SUMMARY = "_summary";
const _HISTORY = "_history";
const METADATA = "metadata";
const MODE = "mode";

# Resource paths
const _SEARCH = "_search";

# Bulk export
const EXPORT = "$export";

# x-www-form-urlencoded content type
const APPLICATION_X_WWW_FORM_URLENCODED = "application/x-www-form-urlencoded";

# Server Status codes
const STATUS_CODE_OK = 200;
const STATUS_CODE_CREATED = 201;
const STATUS_CODE_NO_CONTENT = 204;
const STATUS_CODE_ACCEPTED = 202;

# Request Headers
const ACCEPT_HEADER = "Accept";
const PREFER_HEADER = "Prefer";
const LOCATION = "Location";
const CONTENT_TYPE = "Content-Type";
const CONTENT_LOCATION = "Content-Location";
const IF_NONE_EXISTS = "If-None-Exist";
const X_PROGRESS = "X-Progress";
const EXPORT_ID = "Export-ID";

# Error messages 
const RESOURCE_ID_NOT_FOUND_IN_DATA = "The provided resource data doesn't contain a id value";
const RESOURCE_TYPE_NOT_FOUND_IN_DATA = "The provided resource data doesn't contain a resource type value";
const ERROR_WHEN_RETRIEVING_RESOURCE_TYPE = "Error occurred when retrieving resource type from the FHIR payload";
const ERROR_WHEN_RETRIEVING_RESOURCE_ID = "Error occurred when retrieving resource ID from the FHIR payload";
const FHIR_SERVER_ERROR = "FHIR server side error";
const FHIR_CONNECTOR_ERROR = "FHIR connector side error";
const BUNDLE_TYPE_ERROR = "Provided bundle type is incompatible with the method, expected bundle type: ";
const BUNDLE_MISSING_TYPE = "Provided bundle doesn't contain the attribute 'type'";
const PAYLOAD_CONSTRUCTION_ERROR = "Error occurred when constructing the response payload";
const MISSING_RES_TYPE = "Resource type not found";
const REPLACEMENT_URL_NOT_PROVIDED = "URL rewrite is set to true, but replacement URL is not provided";
const GROUP_ID_NOT_PROVIDED = "The parameter 'groupId' is not provided for Group Bulk Export operation";
const MISSING_ID = "'id' is a mandatory parameter for the interaction";
const INVALID_CONDITIONAL_URL = "The provided conditional URL is invalid";
const BULK_EXPORT_ID_NOT_PROVIDED = "Either exportId or contentLocation must be provided for the Bulk Export Status operation";
const BULK_FILE_URL_NOT_PROVIDED = "Either fileUrl or exportId must be provided for the Bulk Export File operation";
const BULK_FILE_SERVER_CONFIG_NOT_PROVIDED = "The target server configuration is not provided for the Bulk Export File operation";

# XML attributes
const XML_ID = "id";
const XML_TYPE = "type";
const XML_LINK = "link";
const XML_RELATION = "relation";
const XML_URL = "url";

# pagination
const NEXT = "next";
const PREVIOUS = "previous";
const PREV = "prev";
const SELF = "self";

# default values
const DEFAULT_POLLING_INTERVAL = 2.0d;
const DEFAULT_EXPORT_DIRECTORY = "bulk_export";
