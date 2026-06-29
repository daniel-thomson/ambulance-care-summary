// =====================================================================
// AllergyIntolerance - HISO 10052:2026 §2.5 Allergies
// =====================================================================

Profile: AcsAllergyIntolerance
Parent: AllergyIntolerance
Id: acs-allergy-intolerance
Title: "ACS Allergy / Intolerance"
Description: "A self-reported allergy or intolerance (HISO 10052:2026 §2.5 Allergies). May be coded, or recorded as free text including 'None' or 'Unknown'."
* clinicalStatus MS
* code 1..1 MS
* code ^short = "Allergy/intolerance (coded and/or free text via code.text); use a no-known-allergy code for 'None'"
* patient 1..1 MS
* patient only Reference(AmbulanceCareSummaryPatient)
* note ^short = "Free text detail of the allergy"
