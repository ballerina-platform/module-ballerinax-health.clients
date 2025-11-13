# FHIR Client Connector

FHIR client connector that can be used to connect to a FHIR server and perform common interactions and operations.

## Capability Statement

- `https://fhir-ehr-code.cerner.com/r4/ec2458f2-1e24-41c8-b71b-0e701af7583d/metadata?_format=application/json`

## Supported FHIR Resource Types

The table below lists supported resource types, interactions and operations. Interactions are shown as inline code and separated by line breaks for readability.

| Resource Type | Interactions | Operations |
|---|---|---|
| CapabilityStatement | `read` | - |
| Account | `read`<br>`search-type` | - |
| AllergyIntolerance | `read`<br>`search-type`<br>`create`<br>`update` | - |
| Appointment | `read`<br>`search-type`<br>`create`<br>`patch` | - |
| Basic | `create` | - |
| Binary | `read` | `autogen-ccd-if` |
| CarePlan | `read`<br>`search-type` | - |
| CareTeam | `read`<br>`search-type` | - |
| ChargeItem | `read`<br>`search-type` | `credit`<br>`modify`<br>`create` |
| Communication | `read`<br>`search-type`<br>`create`<br>`patch` | - |
| Condition | `read`<br>`search-type`<br>`create`<br>`update` | - |
| Consent | `read`<br>`search-type` | - |
| Coverage | `read`<br>`search-type`<br>`create`<br>`patch`<br>`delete` | - |
| Device | `read`<br>`search-type` | - |
| DiagnosticReport | `read`<br>`search-type`<br>`create` | - |
| DocumentReference | `read`<br>`search-type`<br>`create`<br>`update` | `USCoreFetchDocumentReferences` |
| Encounter | `read`<br>`search-type`<br>`create`<br>`patch` | - |
| FamilyMemberHistory | `read`<br>`search-type`<br>`create`<br>`update` | - |
| Goal | `read`<br>`search-type` | - |
| Group |  | `export` |
| Immunization | `read`<br>`search-type`<br>`create`<br>`update` | - |
| InsurancePlan | `read`<br>`search-type` | - |
| Location | `read`<br>`search-type` | - |
| Media | `read` | - |
| MedicationAdministration | `read`<br>`search-type` | - |
| MedicationDispense | `read`<br>`search-type` | - |
| MedicationRequest | `read`<br>`search-type`<br>`create`<br>`patch` | - |
| NutritionOrder | `read`<br>`search-type` | - |
| Observation | `read`<br>`search-type`<br>`create`<br>`update` | - |
| OperationDefinition | `read` | - |
| Organization | `read`<br>`search-type`<br>`create` | `get-cg-for-mrcu` |
| Patient | `read`<br>`search-type`<br>`create`<br>`patch` | `health-cards-issue`<br>`export` |
| Person | `read`<br>`search-type` | - |
| Practitioner | `read`<br>`search-type`<br>`create` | - |
| Procedure | `read`<br>`search-type`<br>`create` | - |
| Provenance | `read`<br>`search-type`<br>`create` | - |
| Questionnaire | `read`<br>`search-type` | - |
| QuestionnaireResponse | `read`<br>`search-type`<br>`update` | - |
| RelatedPerson | `read`<br>`search-type`<br>`create`<br>`patch` | - |
| Schedule | `read`<br>`search-type` | - |
| ServiceRequest | `read`<br>`search-type` | - |
| Slot | `read`<br>`search-type`<br>`patch` | - |
| Specimen | `read`<br>`search-type` | - |
| StructureDefinition | `read` | - |

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