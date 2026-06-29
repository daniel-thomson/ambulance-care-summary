// =====================================================================
// Patient (Demographics) - HISO 10052:2026 §2.1
// =====================================================================

Profile: AmbulanceCareSummaryPatient
Parent: $NzPatient
Id: ambulance-care-summary-patient
Title: "Ambulance Care Summary Patient"
Description: "The patient receiving care from an ambulance operator. Based on NZ Base NzPatient; demographic data per HISO 10052:2026 §2.1 and HISO 10046 Consumer Health Identity Standard."
* identifier[NHI] ^short = "NHI Number"
* name 1..* MS
* name ^short = "Person name"
* gender MS
* gender ^short = "Gender"
* birthDate MS
* birthDate ^short = "Date of Birth"
* extension contains $nz-sex-at-birth named sexAtBirth 0..1 MS
* extension[sexAtBirth] ^short = "Sex at birth (biological sex assigned at birth)"
* deceased[x] MS
* deceased[x] ^short = "Person death information"
* address MS
* telecom MS
* communication MS
* communication ^short = "Language"
