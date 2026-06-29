// =====================================================================
// ValueSets for the Ambulance Care Summary
// =====================================================================

ValueSet: AcsEncounterTypeVS
Id: acs-encounter-type-vs
Title: "ACS Encounter Type Value Set"
Description: "Type of ambulance encounter."
* ^status = #draft
* ^experimental = true
* include codes from system AcsEncounterTypeCS

ValueSet: AcsDispositionVS
Id: acs-encounter-disposition-vs
Title: "ACS Encounter Disposition Value Set"
Description: "What the clinician decided to do with the patient."
* ^status = #draft
* ^experimental = true
* include codes from system AcsDispositionCS

ValueSet: AcsSupplyMethodVS
Id: acs-supply-method-vs
Title: "ACS Medication Supply Method Value Set"
Description: "The method by which a medication is provided to a patient."
* ^status = #draft
* ^experimental = true
* include codes from system AcsSupplyMethodCS

ValueSet: AcsMechanismOfInjuryVS
Id: acs-mechanism-of-injury-vs
Title: "ACS Mechanism of Injury Value Set"
Description: "The event that caused any injuries."
* ^status = #draft
* ^experimental = true
* include codes from system AcsMechanismOfInjuryCS

ValueSet: AcsPatientStatusVS
Id: acs-patient-status-vs
Title: "ACS Patient Status Value Set"
Description: "Status of the patient at a point in time."
* ^status = #draft
* ^experimental = true
* include codes from system AcsPatientStatusCS

ValueSet: AcsEcgInterpretationVS
Id: acs-ecg-interpretation-vs
Title: "ACS ECG Interpretation Value Set"
Description: "Initial presenting rhythm of the heart."
* ^status = #draft
* ^experimental = true
* include codes from system AcsEcgInterpretationCS

ValueSet: AcsSkinConditionVS
Id: acs-skin-condition-vs
Title: "ACS Skin Condition Value Set"
Description: "Observed skin condition."
* ^status = #draft
* ^experimental = true
* include codes from system AcsSkinConditionCS

ValueSet: AcsRouteVS
Id: acs-route-vs
Title: "ACS Medication Route Value Set"
Description: "Route by which a medication dose is administered."
* ^status = #draft
* ^experimental = true
* include codes from system AcsRouteCS

ValueSet: AcsAgeUnitVS
Id: acs-age-unit-vs
Title: "ACS Age Unit Value Set"
Description: "Unit of measure for patient age: day, month or year (UCUM)."
* ^status = #draft
* ^experimental = true
* $UCUM#d "day"
* $UCUM#mo "month"
* $UCUM#a "year"

ValueSet: MpdsVS
Id: mpds-vs
Title: "Medical Priority Dispatch System (MPDS) Value Set"
Description: "All MPDS determinant codes (HISO 10052:2026 Appendix A)."
* ^status = #draft
* ^experimental = true
* include codes from system MpdsCS

// --- SNOMED CT based value sets ---------------------------------------
// Where HISO 10052:2026 references a SNOMED CT subset/reference set, the
// value set is expressed intensionally against SNOMED CT. Expansions are
// resolved by the NZ terminology service. These are intentionally broad
// in this draft and are expected to be tightened to the relevant NZ
// reference sets in a production release.

ValueSet: AcsSmokingStatusVS
Id: acs-smoking-status-vs
Title: "ACS Smoking Status Value Set"
Description: "Smoking status (NZ smoking status reference set 72741000210106)."
* ^status = #draft
* ^experimental = true
* include codes from system $SCT where concept is-a #365980008 "Tobacco use and exposure - finding"

ValueSet: AcsVapingStatusVS
Id: acs-vaping-status-vs
Title: "ACS Vaping Status Value Set"
Description: "Vaping status (NZ vaping status reference set 72721000210100)."
* ^status = #draft
* ^experimental = true
* include codes from system $SCT where concept is-a #722499006 "Electronic cigarette use finding"

ValueSet: AcsEncounterDiagnosisVS
Id: acs-encounter-diagnosis-vs
Title: "ACS Encounter Diagnosis Value Set"
Description: "Clinical impressions / diagnoses (NZ Emergency Care Reference Set). Broad clinical-finding subset in this draft."
* ^status = #draft
* ^experimental = true
* include codes from system $SCT where concept is-a #404684003 "Clinical finding"

ValueSet: AcsProcedureTypeVS
Id: acs-procedure-type-vs
Title: "ACS Procedure Type Value Set"
Description: "Type of procedure or intervention performed (HISO 10052:2026 §2.8). Procedure subset in this draft."
* ^status = #draft
* ^experimental = true
* include codes from system $SCT where concept is-a #71388002 "Procedure"

ValueSet: AcsAdviceToPatientVS
Id: acs-advice-to-patient-vs
Title: "ACS Advice to Patient Value Set"
Description: "Self-care advice (subset of SNOMED CT < 420227002 |Recommendation to|)."
* ^status = #draft
* ^experimental = true
* include codes from system $SCT where concept is-a #420227002 "Recommendation to"

ValueSet: AcsReferralPathwayVS
Id: acs-referral-pathway-vs
Title: "ACS Referral Pathway Value Set"
Description: "Onward referral pathway (subset of SNOMED CT < 169443000 |Preventive procedure| or < 243120004 |Regimes and therapies|)."
* ^status = #draft
* ^experimental = true
* include codes from system $SCT where concept is-a #169443000 "Preventive procedure"
* include codes from system $SCT where concept is-a #243120004 "Regimes and therapies"
