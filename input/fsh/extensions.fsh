// =====================================================================
// Extensions for Ambulance Care Summary data elements that have no
// suitable representation on the base FHIR resources.
// =====================================================================

Extension: AgeEstimated
Id: age-estimated
Title: "Age Estimated"
Description: "Indicates the patient's age was estimated by the clinician rather than derived from a known date of birth (HISO 10052:2026 §2.1 Age estimated)."
* ^context[+].type = #element
* ^context[=].expression = "Observation"
* value[x] only boolean

Extension: OnsetUnknown
Id: onset-unknown
Title: "Onset Unknown"
Description: "Indicates the onset date/time of the relevant finding is unknown (HISO 10052:2026 §2.4 Onset time unknown, §2.5 Last oral intake unknown)."
* ^context[+].type = #element
* ^context[=].expression = "Condition"
* ^context[+].type = #element
* ^context[=].expression = "Observation"
* value[x] only boolean

Extension: AdministeredPrn
Id: administered-prn
Title: "Administered PRN"
Description: "Medication was administered as necessary (pro re nata) (HISO 10052:2026 §2.7 Administered PRN)."
* ^context[+].type = #element
* ^context[=].expression = "MedicationAdministration"
* value[x] only boolean

Extension: PatientConsentObtained
Id: patient-consent-obtained
Title: "Patient Consent Obtained"
Description: "The patient consented to their personal information being shared with the third party (HISO 10052:2026 §2.9 Patient consent obtained)."
* ^context[+].type = #element
* ^context[=].expression = "ServiceRequest"
* ^context[+].type = #element
* ^context[=].expression = "Appointment"
* value[x] only boolean

Extension: ContactInstruction
Id: contact-instruction
Title: "Contact Instruction"
Description: "Free-text instruction or context for contacting a person relevant to the ambulance encounter."
* ^context[+].type = #element
* ^context[=].expression = "RelatedPerson"
* value[x] only string
