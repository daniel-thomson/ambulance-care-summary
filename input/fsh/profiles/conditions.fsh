// =====================================================================
// Conditions
//   §2.3 Encounter diagnosis (clinical impression)
//   §2.5 Past medical history
// =====================================================================

Profile: AcsEncounterDiagnosis
Parent: $NzCondition
Id: acs-encounter-diagnosis
Title: "ACS Encounter Diagnosis"
Description: "A diagnosis / clinical impression made at the encounter, coded from the NZ Emergency Care Reference Set (HISO 10052:2026 §2.3 Encounter diagnosis code)."
* category 1..* MS
* category = $cond-category#encounter-diagnosis
* code 1..1 MS
* code from AcsEncounterDiagnosisVS (extensible)
* subject 1..1 MS
* subject only Reference(AmbulanceCareSummaryPatient)
* encounter only Reference(AmbulanceEncounter)

Profile: AcsPastMedicalHistory
Parent: $NzCondition
Id: acs-past-medical-history
Title: "ACS Past Medical History"
Description: "An item of the patient's relevant medical history (HISO 10052:2026 §2.5 Past medical history). May be coded, or recorded as free text including 'None' or 'Unknown'."
* category 1..* MS
* category = $cond-category#problem-list-item
* code 0..1 MS
* code ^short = "Coded history item and/or free text (code.text), e.g. 'None' or 'Unknown'"
* subject 1..1 MS
* subject only Reference(AmbulanceCareSummaryPatient)
* note ^short = "Free-text overview of relevant medical history"
