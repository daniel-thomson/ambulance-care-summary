// =====================================================================
// Encounter (Incident) - HISO 10052:2026 §2.3
// =====================================================================

Profile: AmbulanceEncounter
Parent: Encounter
Id: ambulance-encounter
Title: "Ambulance Encounter"
Description: "Summary of an ambulance encounter with a patient (an 'incident' in ambulance terminology), per HISO 10052:2026 §2.3."
* identifier 1..* MS
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier contains masterIncidentNumber 1..1 MS
* identifier[masterIncidentNumber].system = "https://standards.digital.health.nz/ns/ambulance-master-incident-number"
* identifier[masterIncidentNumber] ^short = "Master Incident Number assigned by the CAD system (format NNNN-N-ccyy/mm/dd)"
* status MS
* class MS
* type 1..1 MS
* type from AcsEncounterTypeVS (extensible)
* type ^short = "Encounter type code (air/land ambulance, community clinic, telehealth)"
* subject 1..1 MS
* subject only Reference(AmbulanceCareSummaryPatient)
* participant MS
* participant.individual only Reference(AmbulanceServiceProviderRole or AmbulanceClinician)
* participant ^short = "Ambulance service provider (clinician) attending the incident"
* period 1..1 MS
* period.start 1..1 MS
* period.start ^short = "Encounter date/time - when the operator first became aware of the incident"
* reasonReference only Reference(AcsPresentingComplaint or AcsEncounterDiagnosis)
* diagnosis MS
* diagnosis.condition only Reference(AcsEncounterDiagnosis)
* diagnosis ^short = "Encounter diagnosis - the clinician's clinical impression(s)"
* hospitalization.dischargeDisposition from AcsDispositionVS (extensible)
* hospitalization.dischargeDisposition ^short = "Encounter disposition code"
* hospitalization.destination only Reference(ReceivingFacility)
* hospitalization.destination ^short = "Receiving facility (destination), if the patient was transported"
* serviceProvider 1..1 MS
* serviceProvider only Reference(AmbulanceServiceOrganization)
