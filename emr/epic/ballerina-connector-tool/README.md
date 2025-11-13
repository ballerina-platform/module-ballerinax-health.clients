# FHIR Client Connector

FHIR client connector that can be used to connect to a FHIR server and perform common interactions and operations.

## Capability Statement

- `https://fhir.epic.com/interconnect-fhir-oauth/api/FHIR/R4/metadata`

## Supported FHIR Resource Types

The table below lists supported resource types, interactions and operations. Interactions are shown as inline code and separated by line breaks for readability.

| Resource Type | Interactions | Operations |
|---|---|---|
| Account | `read`<br>`search-type` | - |
| AdverseEvent | `read`<br>`search-type` | - |
| AllergyIntolerance | `create`<br>`read`<br>`search-type` | - |
| Appointment | `read`<br>`search-type` | - |
| Binary | `read`<br>`search-type` | - |
| BodyStructure | `create`<br>`read`<br>`search-type`<br>`update` | - |
| CarePlan | `read`<br>`search-type` | - |
| CareTeam | `read`<br>`search-type` | - |
| Claim | `read`<br>`search-type` | - |
| Communication | `create`<br>`read`<br>`search-type` | - |
| ConceptMap | `create`<br>`read` | - |
| Condition | `create`<br>`read`<br>`search-type` | - |
| Consent | `read`<br>`search-type` | - |
| Contract | `read`<br>`search-type` | - |
| Coverage | `read`<br>`search-type` | - |
| Device | `read`<br>`search-type` | - |
| DeviceRequest | `read`<br>`search-type` | - |
| DeviceUseStatement | `read`<br>`search-type` | - |
| DiagnosticReport | `read`<br>`search-type`<br>`update` | - |
| DocumentReference | `create`<br>`read`<br>`search-type`<br>`update` | - |
| Encounter | `read`<br>`search-type` | - |
| Endpoint | `read`<br>`search-type` | - |
| EpisodeOfCare | `read`<br>`search-type` | - |
| ExplanationOfBenefit | `read`<br>`search-type` | - |
| FamilyMemberHistory | `read`<br>`search-type` | - |
| Flag | `read`<br>`search-type` | - |
| Goal | `read`<br>`search-type` | - |
| Group | `read`<br>`search-type` | `group-export` |
| ImagingStudy | `read`<br>`search-type` | - |
| Immunization | `read`<br>`search-type` | - |
| ImmunizationRecommendation | `read`<br>`search-type` | - |
| List | `read`<br>`search-type` | - |
| Location | `read`<br>`search-type` | - |
| Measure | `read`<br>`search-type` | - |
| MeasureReport | `read`<br>`search-type` | - |
| Media | `read`<br>`search-type` | - |
| Medication | `read`<br>`search-type` | - |
| MedicationAdministration | `read`<br>`search-type` | - |
| MedicationDispense | `read`<br>`search-type` | - |
| MedicationRequest | `read`<br>`search-type` | - |
| NutritionOrder | `read`<br>`search-type` | - |
| Observation | `create`<br>`read`<br>`search-type`<br>`update` | - |
| Organization | `read`<br>`search-type` | - |
| Patient | `create`<br>`read`<br>`search-type` | `match`<br>`summary` |
| Practitioner | `read`<br>`search-type` | - |
| PractitionerRole | `read`<br>`search-type` | - |
| Procedure | `create`<br>`read`<br>`search-type`<br>`update` | - |
| Provenance | `read` | - |
| Questionnaire | `read`<br>`search-type` | - |
| QuestionnaireResponse | `create`<br>`read`<br>`search-type` | - |
| RelatedPerson | `read`<br>`search-type` | - |
| RequestGroup | `read`<br>`search-type` | - |
| ResearchStudy | `read`<br>`search-type` | - |
| ResearchSubject | `read`<br>`search-type` | - |
| ServiceRequest | `create`<br>`read`<br>`search-type`<br>`update` | - |
| Specimen | `read`<br>`search-type` | - |
| Substance | `read`<br>`search-type` | - |
| Task | `read`<br>`search-type`<br>`update` | - |

Notes:
- `—` indicates no special operations supported for that resource in this connector.
- Use the server's CapabilityStatement to verify support for additional interactions or operations on a given server instance.

## Functions

The connector represents the interactions and operations as functions. Each function corresponds to a specific FHIR interaction or operation.

| Interaction/Operation | Function                             |
|-----------------------|--------------------------------------|
| Read                  | `get{ResourceType}ById`              |
| Version Read          | `get{ResourceType}ByVersion`         |
| Update                | `update{ResourceType}`               |
| Patch                 | `patch{ResourceType}`                |
| Delete                | `delete{ResourceType}`               |
| History Type          | `get{ResourceType}History`           |
| History Instance      | `get{ResourceType}InstanceHistory`   |
| Create                | `create{ResourceType}`               |
| Search Type           | `search{ResourceType}`               |
| \$Operation           | `{Operation}{ResourceType}Operation` |

Replace `{ResourceType}` with the actual resource type (e.g., Patient, Observation) and `{Operation}` with the specific operation name (e.g., everything, validate).