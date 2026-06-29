// =====================================================================
// Care Plan - HISO 10052:2026 §2.9
//   Advice to patient / GP, appointment made, referral initiated
// =====================================================================

Profile: AcsCarePlan
Parent: CarePlan
Id: acs-care-plan
Title: "ACS Care Plan"
Description: "Recommendations for continuing care after the encounter, including advice to the patient and to the patient's GP (HISO 10052:2026 §2.9)."
* status MS
* intent MS
* subject 1..1 MS
* subject only Reference(AmbulanceCareSummaryPatient)
* encounter only Reference(AmbulanceEncounter)
* description ^short = "Advice to patient (coded advice may also appear in activity)"
* note ^short = "Advice to the patient's GP"
* activity.detail.code from AcsAdviceToPatientVS (extensible)

Profile: AcsReferral
Parent: ServiceRequest
Id: acs-referral
Title: "ACS Referral"
Description: "A referral initiated to a pathway (e.g. falls prevention, smoking cessation) provided by a third party (HISO 10052:2026 §2.9 Referral initiated)."
* status MS
* intent = #order
* priority ^short = "Use 'urgent' when the referral should be actioned as soon as possible"
* code 1..1 MS
* code from AcsReferralPathwayVS (extensible)
* code ^short = "Referral pathway"
* subject 1..1 MS
* subject only Reference(AmbulanceCareSummaryPatient)
* encounter only Reference(AmbulanceEncounter)
* reasonCode ^short = "Reason for referral"
* extension contains PatientConsentObtained named patientConsentObtained 0..1 MS

Profile: AcsAppointment
Parent: Appointment
Id: acs-appointment
Title: "ACS Appointment"
Description: "An appointment made on the patient's behalf with a third-party provider (HISO 10052:2026 §2.9 Appointment made)."
* status MS
* start 1..1 MS
* start ^short = "Appointment date/time"
* participant 1..* MS
* participant.actor ^short = "Patient and the third-party provider"
* extension contains PatientConsentObtained named patientConsentObtained 0..1 MS
