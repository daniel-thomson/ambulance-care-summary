### Ambulance Care Summary

<p class="dragon">Important note: This implementation guide is being provided for informational / example usage only - much of it is auto-generated / many details are likely to be wrong.</p>

This Implementation Guide provides an example of how a New Zealand Ambulance Care Summary might structured and represented as an FHIR document. It is based on the draft of the HISO 10052:2026 Ambulance Care Summary Standard.

The Ambulance Care Summary supports two purposes described in the standard:

1. **Transfer of care** &mdash; briefing the clinician who takes responsibility for the patient at handover (for example an emergency department), and forming part of the patient's permanent shared clinical record.
2. **GP advice** &mdash; advising an enrolled patient's GP of an ambulance contact when the patient was not transported.

### Document structure

An Ambulance Care Summary is a FHIR document: a [Bundle](StructureDefinition-ambulance-care-summary-bundle.html) of `type = document` whose first entry is a [Composition](StructureDefinition-ambulance-care-summary-composition.html). The Composition organises the clinical content into sections that follow the HISO 10052:2026 data set specification (&sect;2):

| Composition section | HISO 10052:2026 section | Key resource profiles |
|---|---|---|
| Incident / Encounter | &sect;2.3 Encounter | [Ambulance Encounter](StructureDefinition-ambulance-encounter.html), [Patient Status](StructureDefinition-acs-patient-status.html) |
| Smoking and Vaping | &sect;2.2 Smoking and vaping | [Smoking Status](StructureDefinition-acs-smoking-status.html), [Vaping Status](StructureDefinition-acs-vaping-status.html) |
| Problems | &sect;2.4 Problems | [Presenting Complaint](StructureDefinition-acs-presenting-complaint.html), [Encounter Diagnosis](StructureDefinition-acs-encounter-diagnosis.html), [Accident Detail](StructureDefinition-acs-accident-observation.html) |
| Patient History | &sect;2.5 Patient History | [Past Medical History](StructureDefinition-acs-past-medical-history.html), [Current Medication](StructureDefinition-acs-current-medication.html), [Allergy / Intolerance](StructureDefinition-acs-allergy-intolerance.html) |
| Measurements and Vital Signs | &sect;2.6 Measurements and vital signs | [ACS Observation](StructureDefinition-acs-observation.html) and the measurement-specific profiles |
| Medications Administered or Supplied | &sect;2.7 Medications | [Medication Administration](StructureDefinition-acs-medication-administration.html), [Medication Dispense](StructureDefinition-acs-medication-dispense.html) |
| Procedures | &sect;2.8 Procedures | [Procedure](StructureDefinition-acs-procedure.html) |
| Care Plan | &sect;2.9 Care Plan | [Care Plan](StructureDefinition-acs-care-plan.html), [Referral](StructureDefinition-acs-referral.html), [Appointment](StructureDefinition-acs-appointment.html) |

The patient (&sect;2.1 Demographics) is the subject of the document and is profiled as [Ambulance Care Summary Patient](StructureDefinition-ambulance-care-summary-patient.html).

### Relationship to other NZ specifications

- **NZ Base** &mdash; profiles reuse the NZ Base profiles (`NzPatient`, `NzPractitioner`, `NzPractitionerRole`, `NzOrganization`, `NzLocation`, `NzCondition`, `NzMedicationStatement`, `NzMedicationDispense`) as parents where they exist, and use the NZ identifier namespaces (NHI, HPI-CPN, HPI-ORG, HPI-Facility, Paramedic Council).
- **NZ Patient Summary (NZPS / IPS)** &mdash; many sections align with HISO 10099:2022 NZ Patient Summary. Where relevant, equivalent content patterns are recreated in this guide rather than inheriting NZPS profiles directly. At least - that should be the intention - currently only some parts are there (e.g. vaping status uses the SNOMED NZ ref set, smoking status is includes all sorts of smoking status codes from the international version and would need fixing)

### Worked example

A complete-ish example, derived from the reference CDA Ambulance Care Summary:
[Example Ambulance Care Summary Document](Bundle-AmbulanceCareSummaryExample.html).

### Terminology

HISO 10052:2026 specifies **SNOMED CT** as the terminology for most coded data elements. This IG was rapidly generated and does not include correct terminology in many places (most term resources are defined locally and are marked `draft`/`experimental`) and are expected to be replaced by, or mapped to, the relevant SNOMED CT NZ Edition reference sets in a proper specification. The [Medical Priority Dispatch System (MPDS)](CodeSystem-mpds.html) determinant codes (Appendix A) are provided for the presenting complaint.

<p class="dragon">Important note Reminder: This guide is informational only and is likely to differ significantly from any actual implementaiton. </p>
