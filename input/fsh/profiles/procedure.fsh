// =====================================================================
// Procedure (Interventions) - HISO 10052:2026 §2.8
// =====================================================================

Profile: AcsProcedure
Parent: Procedure
Id: acs-procedure
Title: "ACS Procedure"
Description: "A procedure or intervention performed on the patient during the encounter (HISO 10052:2026 §2.8)."
* status MS
* code 1..1 MS
* code from AcsProcedureTypeVS (extensible)
* code ^short = "Procedure type"
* subject 1..1 MS
* subject only Reference(AmbulanceCareSummaryPatient)
* encounter only Reference(AmbulanceEncounter)
* performed[x] 1..1 MS
* performed[x] only dateTime
* performedDateTime ^short = "Intervention time - the start time of the procedure"
* performer.actor only Reference(AmbulanceServiceProviderRole or AmbulanceClinician)
* bodySite ^short = "Body structure, with laterality / anatomical relationship where applicable"
* outcome ^short = "Intervention success (successful / unsuccessful) where applicable"
* note ^short = "Additional material related to this intervention"
