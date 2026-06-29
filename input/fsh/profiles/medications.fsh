// =====================================================================
// Medications
//   §2.5 Self-reported current medications
//   §2.7 Medications administered or dispensed during the encounter
// =====================================================================

Profile: AcsCurrentMedication
Parent: $NzMedicationStatement
Id: acs-current-medication
Title: "ACS Current Medication"
Description: "A medication the patient self-reports currently taking (HISO 10052:2026 §2.5 Medications). NZMT or ATC codes preferred; may be 'None' or 'Unknown'."
* status MS
* medication[x] MS
* medication[x] ^short = "Medicine (NZMT/ATC coded or free text)"
* subject 1..1 MS
* subject only Reference(AmbulanceCareSummaryPatient)
* informationSource ^short = "Source of the statement (typically the patient - self reported)"

Profile: AcsMedicationAdministration
Parent: MedicationAdministration
Id: acs-medication-administration
Title: "ACS Medication Administration"
Description: "A medication administered to the patient during the encounter (HISO 10052:2026 §2.7, Supply method = administration)."
* status MS
* medication[x] 1..1 MS
* medication[x] ^short = "Medicinal product code (NZMT) and/or name"
* subject 1..1 MS
* subject only Reference(AmbulanceCareSummaryPatient)
* context only Reference(AmbulanceEncounter)
* effective[x] 1..1 MS
* effective[x] only dateTime
* effectiveDateTime ^short = "Supply time - when the medicine was administered"
* performer.actor only Reference(AmbulanceServiceProviderRole or AmbulanceClinician)
* dosage 1..1 MS
* dosage.route from AcsRouteVS (extensible)
* dosage.dose 1..1 MS
* dosage.dose ^short = "Dose administered (value and unit)"
* extension contains AdministeredPrn named administeredPrn 0..1 MS
* note ^short = "Additional information related to the medication"

Profile: AcsMedicationDispense
Parent: $NzMedicationDispense
Id: acs-medication-dispense
Title: "ACS Medication Dispense"
Description: "A medication dispensed (supplied for later use) to the patient during the encounter (HISO 10052:2026 §2.7, Supply method = dispensing)."
* status MS
* medication[x] 1..1 MS
* medication[x] ^short = "Medicinal product code (NZMT) and/or name"
* subject 1..1 MS
* subject only Reference(AmbulanceCareSummaryPatient)
* quantity MS
* quantity ^short = "Count of doses dispensed"
* whenHandedOver MS
* whenHandedOver ^short = "Supply time - when the medicine was supplied"
* dosageInstruction.route from AcsRouteVS (extensible)
* note ^short = "Additional information related to the medication"
