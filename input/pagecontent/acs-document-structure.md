### ACS document structure

An Ambulance Care Summary is represented as a FHIR document. The document is a [Bundle](StructureDefinition-ambulance-care-summary-bundle.html) with `Bundle.type = document`; the first entry in that Bundle is the [Composition](StructureDefinition-ambulance-care-summary-composition.html) that gives the document its clinical structure.

The Bundle is the document envelope. It carries the persistent document identifier, the document timestamp, and the complete set of resources needed to understand the summary. Each `Bundle.entry` has a `fullUrl`, and references inside the Composition and resources should resolve to entries in the same Bundle.

The Composition is the document table of contents and clinical organisation layer. It identifies the patient, the ambulance encounter, the author, the custodian, and the document type. Its sections group the human-readable narrative and machine-readable resource references into the Ambulance Care Summary data set areas.

<div class="mermaid">
%%{init: {"flowchart": {"curve": "linear", "nodeSpacing": 25, "rankSpacing": 35}}}%%
flowchart TD
    Bundle["Bundle<br/>AmbulanceCareSummaryBundle<br/>type = document"]
    Composition["Composition<br/>first Bundle entry"]
    Metadata["Document context<br/>subject, encounter, author, custodian"]
    Sections["Composition sections<br/>ACS content areas"]
    Resources["Referenced resources<br/>Patient, Encounter, Observations, Conditions,<br/>Medications, Procedures, CarePlan, etc."]

    Bundle --> Composition
    Bundle --> Resources
    Composition --> Metadata
    Composition --> Sections
    Sections -->|"section.entry references"| Resources
</div>

#### Reading the document

1. Start with the Bundle.
   The Bundle is the resource that is exchanged or persisted as the document. It must be a document Bundle and must have the Composition as its first entry.

2. Read the Composition metadata.
   The Composition establishes the document identity and context: `Composition.type`, `Composition.subject`, `Composition.encounter`, `Composition.date`, `Composition.author`, `Composition.title`, and `Composition.custodian`.

3. Follow the Composition sections.
   Each `Composition.section` represents an Ambulance Care Summary content area. The section text is the human-readable presentation of that part of the document. The section entries point to the FHIR resources that carry the structured data.

4. Resolve section entries in the Bundle.
   A section entry reference, such as an Observation for a vital sign or a Condition for an encounter diagnosis, should resolve to a resource included as a `Bundle.entry`. This keeps the document self-contained.

#### Composition sections

| Composition section | Main resources referenced by `section.entry` |
|---|---|
| Incident / Encounter | [Ambulance Encounter](StructureDefinition-ambulance-encounter.html), [Incident Location](StructureDefinition-acs-incident-location.html), [Incident Event](StructureDefinition-acs-incident-event.html), [Patient Status](StructureDefinition-acs-patient-status.html) |
| Patient Contacts | [Patient Contact](StructureDefinition-acs-patient-contact.html) |
| Patient Additional Demographics | [Patient Age](StructureDefinition-acs-patient-age.html) |
| Smoking and Vaping | [Smoking Status](StructureDefinition-acs-smoking-status.html), [Vaping Status](StructureDefinition-acs-vaping-status.html) |
| Problems | [Presenting Complaint](StructureDefinition-acs-presenting-complaint.html), [History of Incident](StructureDefinition-acs-history-of-incident.html), [Encounter Diagnosis](StructureDefinition-acs-encounter-diagnosis.html), [Accident Detail](StructureDefinition-acs-accident-observation.html) |
| Primary Survey | [Primary Survey](StructureDefinition-acs-primary-survey.html) |
| Stroke Assessments | [ABCD2 Stroke Risk Assessment](StructureDefinition-acs-abcd2-stroke-risk-assessment.html), [FAST Stroke Assessment](StructureDefinition-acs-fast-stroke-assessment.html) |
| Falls Risk Assessment | [Falls Risk Assessment](StructureDefinition-acs-falls-risk-assessment.html) |
| Patient History | [Past Medical History](StructureDefinition-acs-past-medical-history.html), [Last Oral Intake](StructureDefinition-acs-last-oral-intake.html) |
| Allergies and Intolerances | [Allergy / Intolerance](StructureDefinition-acs-allergy-intolerance.html) |
| Current Medications | [Current Medication](StructureDefinition-acs-current-medication.html) |
| Measurements and Vital Signs | [ACS Observation](StructureDefinition-acs-observation.html) and the measurement-specific observation profiles |
| Medications Administered or Supplied | [Medication Administration](StructureDefinition-acs-medication-administration.html), [Medication Dispense](StructureDefinition-acs-medication-dispense.html) |
| Procedures | [Procedure](StructureDefinition-acs-procedure.html) |
| Transport/treatment Refusal | [Transport/Treatment Refusal](StructureDefinition-acs-transport-treatment-refusal.html) |
| Patient Competence | [Patient Competence Assessment](StructureDefinition-acs-patient-competence-assessment.html) |
| Care Plan | [Care Plan](StructureDefinition-acs-care-plan.html), [Referral](StructureDefinition-acs-referral.html), [Appointment](StructureDefinition-acs-appointment.html) |
| Clinical Images | [Clinical Image](StructureDefinition-acs-clinical-image.html) |

#### Implementation notes

- The Composition organises the document; it does not physically contain the clinical resources. The resources are separate `Bundle.entry.resource` instances and are linked from the Composition by reference.
- `Composition.subject` identifies the patient for the document. Most clinical resources should also carry their own patient subject reference where the base FHIR resource supports it.
- `Composition.encounter` identifies the ambulance incident for the document. Clinical resources recorded during that incident should carry encounter or context references where the resource supports them.
- The Bundle should include the patient, encounter, authors, custodian, and every resource referenced from a Composition section so the document can be interpreted without fetching external clinical content.
- See the [Example Ambulance Care Summary Document](Bundle-AmbulanceCareSummaryExample.html) for a worked Bundle/Composition example.
