// =====================================================================
// Ambulance Care Summary document: Bundle + Composition
// =====================================================================

Profile: AmbulanceCareSummaryBundle
Parent: Bundle
Id: ambulance-care-summary-bundle
Title: "Ambulance Care Summary Bundle"
Description: "A FHIR document Bundle containing an Ambulance Care Summary. The first entry is an AmbulanceCareSummaryComposition."
* . ^short = "Ambulance Care Summary FHIR document"
* type = #document (exactly)
* identifier 1..1 MS
* identifier ^short = "Persistent document identifier (HISO 10040.4 Document identifier)"
* timestamp 1..1 MS
* entry 1..* MS
* entry.fullUrl 1..1
* entry ^slicing.discriminator.type = #type
* entry ^slicing.discriminator.path = "resource"
* entry ^slicing.rules = #open
* entry ^slicing.description = "Bundle entries, the first of which is the Composition"
* entry contains composition 1..1 MS
* entry[composition].resource only AmbulanceCareSummaryComposition
* entry[composition] ^short = "The Composition is the first resource in the document Bundle"


Profile: AmbulanceCareSummaryComposition
Parent: Composition
Id: ambulance-care-summary-composition
Title: "Ambulance Care Summary Composition"
Description: "The Composition that structures an Ambulance Care Summary FHIR document, based on the data set in HISO 10052:2026."
* . ^short = "Ambulance Care Summary"
* identifier 1..1 MS
* status MS
* type = $LOINC#74207-2 "Ambulance Care Summary"
* type MS
* subject 1..1 MS
* subject only Reference(AmbulanceCareSummaryPatient)
* subject ^short = "The patient this summary is about"
* encounter 1..1 MS
* encounter only Reference(AmbulanceEncounter)
* date MS
* date ^short = "Document creation date/time (HISO 10040.4 Creation datetime)"
* author 1..* MS
* author only Reference(AmbulanceServiceProviderRole or AmbulanceClinician or AmbulanceServiceOrganization)
* author ^short = "The ambulance clinician (and/or operator) that authored the summary"
* title MS
* title = "Ambulance Care Summary"
* custodian 1..1 MS
* custodian only Reference(AmbulanceServiceOrganization)
* custodian ^short = "The ambulance operator responsible for the summary"
* attester ^short = "Legal authenticator, e.g. the ambulance operator's Medical Director"
* attester.party only Reference(AmbulanceClinician or AmbulanceServiceProviderRole or AmbulanceServiceOrganization)

// ---- Sections -------------------------------------------------------
* section ^slicing.discriminator.type = #pattern
* section ^slicing.discriminator.path = "code"
* section ^slicing.rules = #open
* section ^slicing.description = "Ambulance Care Summary sections (HISO 10052:2026 §2)"
* section contains
    encounter 1..1 MS and
    socialHistory 0..1 MS and
    problems 1..1 MS and
    pastHistory 0..1 MS and
    allergies 0..1 MS and
    medicationSummary 0..1 MS and
    vitalSigns 0..1 MS and
    medicationsAdministered 0..1 MS and
    procedures 0..1 MS and
    carePlan 0..1 MS

* section[encounter].title = "Incident / Encounter"
* section[encounter].code = $LOINC#46240-8 "History of encounters"
* section[encounter].entry 1..*
* section[encounter].entry only Reference(AmbulanceEncounter or AcsPatientStatus)

* section[socialHistory].title = "Smoking and Vaping"
* section[socialHistory].code = $LOINC#29762-2 "Social history"
* section[socialHistory].entry only Reference(AcsSmokingStatus or AcsVapingStatus)

* section[problems].title = "Problems"
* section[problems].code = $LOINC#10154-3 "Chief complaint"
* section[problems].entry only Reference(AcsPresentingComplaint or AcsEncounterDiagnosis or AcsAccidentObservation)

* section[pastHistory].title = "Patient History"
* section[pastHistory].code = $LOINC#11348-0 "History of past illness"
* section[pastHistory].entry only Reference(AcsPastMedicalHistory)

* section[allergies].title = "Allergies and Intolerances"
* section[allergies].code = $LOINC#48765-2 "Allergies and adverse reactions"
* section[allergies].entry only Reference(AcsAllergyIntolerance)

* section[medicationSummary].title = "Current Medications"
* section[medicationSummary].code = $LOINC#10160-0 "History of medication use"
* section[medicationSummary].entry only Reference(AcsCurrentMedication)

* section[vitalSigns].title = "Measurements and Vital Signs"
* section[vitalSigns].code = $LOINC#8716-3 "Vital signs"
* section[vitalSigns].entry only Reference(AcsObservation)

* section[medicationsAdministered].title = "Medications Administered or Supplied"
* section[medicationsAdministered].code = $LOINC#29549-3 "Medication administered"
* section[medicationsAdministered].entry only Reference(AcsMedicationAdministration or AcsMedicationDispense)

* section[procedures].title = "Procedures"
* section[procedures].code = $LOINC#47519-4 "History of procedures"
* section[procedures].entry only Reference(AcsProcedure)

* section[carePlan].title = "Care Plan"
* section[carePlan].code = $LOINC#18776-5 "Plan of care"
* section[carePlan].entry only Reference(AcsCarePlan or AcsReferral or AcsAppointment)
