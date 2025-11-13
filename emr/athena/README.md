# FHIR Client Connector

FHIR client connector that can be used to connect to a FHIR server and perform common interactions and operations.

## Capability Statement

- `https://api.preview.platform.athenahealth.com/fhir/r4/metadata`

## Supported FHIR Resource Types

The table below lists supported resource types, interactions and operations. Interactions are shown as inline code and separated by line breaks for readability.

| Resource Type | Interactions | Operations |
|---|---|---|
| AllergyIntolerance | `read`<br>`search-type` | - |
| Appointment | `read`<br>`search-type` | - |
| Binary | `read` | - |
| CarePlan | `read`<br>`search-type` | - |
| CareTeam | `read`<br>`search-type` | - |
| Condition | `read`<br>`search-type` | - |
| Coverage | `read`<br>`search-type` | - |
| Device | `read`<br>`search-type` | - |
| DiagnosticReport | `read`<br>`search-type` | - |
| DocumentReference | `read`<br>`search-type` | - |
| Encounter | `read`<br>`search-type` | - |
| Goal | `read`<br>`search-type` | - |
| Immunization | `read`<br>`search-type` | - |
| Location | `read`<br>`search-type` | - |
| Medication | `read`<br>`search-type` | - |
| MedicationRequest | `read`<br>`search-type` | - |
| Observation | `read`<br>`search-type` | - |
| Organization | `read`<br>`search-type` | - |
| Patient | `read`<br>`search-type` | `health-cards-issue` |
| Practitioner | `read`<br>`search-type` | - |
| Procedure | `read`<br>`search-type` | - |
| Provenance | `read`<br>`search-type` | - |
| ServiceRequest | `read`<br>`search-type` | - |
| Group |  | `export` |
| QuestionnaireResponse | `create`<br>`search-type`<br>`read` | `latest-response-by-questionnaire` |
| MeasureReport |  | `submit-care-gaps` |
| Media | `read` | - |
| MedicationDispense | `search-type`<br>`read` | - |
| Specimen | `search-type`<br>`read` | - |
| RelatedPerson | `search-type`<br>`read` | - |

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