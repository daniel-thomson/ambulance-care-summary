// =====================================================================
// Local CodeSystems for the Ambulance Care Summary
//
// HISO 10052:2026 specifies SNOMED CT as the terminology for most coded
// data elements but (being a data-set specification) does not enumerate
// SCTIDs. For a buildable draft IG these enumerated value domains are
// expressed here as local CodeSystems. In a production release these are
// expected to be replaced by, or mapped to, SNOMED CT reference sets.
// =====================================================================

CodeSystem: AcsEncounterTypeCS
Id: acs-encounter-type
Title: "ACS Encounter Type Code System"
Description: "Type of ambulance encounter (HISO 10052:2026 §2.3 Encounter type code)."
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* #air-ambulance "Air ambulance"
* #land-ambulance "Land ambulance"
* #community-clinic "Community clinic"
* #telehealth "Telehealth consultation"

CodeSystem: AcsDispositionCS
Id: acs-encounter-disposition
Title: "ACS Encounter Disposition Code System"
Description: "What the clinician decided to do with the patient (HISO 10052:2026 §2.3 Encounter disposition code)."
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* #no-action "No action required"
* #hear-and-advise "Hear and advise"
* #see-and-advise "See and advise"
* #see-and-treat "See and treat"
* #treat-and-transport "Treat and transport"

CodeSystem: AcsSupplyMethodCS
Id: acs-supply-method
Title: "ACS Medication Supply Method Code System"
Description: "The method by which a medication is provided to a patient (HISO 10052:2026 §2.7 Supply method)."
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* #administration "Administration of medication"
* #dispensing "Dispensing medication"

CodeSystem: AcsMechanismOfInjuryCS
Id: acs-mechanism-of-injury
Title: "ACS Mechanism of Injury Code System"
Description: "The event that caused any injuries (HISO 10052:2026 §2.4 Mechanism of injury)."
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* #rta "Road traffic accident (RTA)"
* #work "Work accident"
* #sports "Sports accident"
* #assault "Assault"
* #cold "Accident due to excessive cold"
* #heat "Accident due to excessive heat"
* #machinery "Accident caused by machinery"
* #electric "Accident caused by electric current"
* #animal "Accidental physical contact with animal"
* #fire "Accident caused by fire and flames"
* #corrosive "Accidental exposure to corrosive or caustic chemical"
* #hazardous "Exposure to potentially hazardous substance"
* #fall "Fall"
* #other "Other"

CodeSystem: AcsPatientStatusCS
Id: acs-patient-status
Title: "ACS Patient Status Code System"
Description: "Status of the patient at a point in time (HISO 10052:2026 §2.6 Patient status)."
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* #deceased "Deceased"
* #immediate-threat "Immediate threat to life"
* #potential-threat "Potential threat to life"
* #unlikely-threat "Unlikely threat to life"
* #no-threat "No threat to life"

CodeSystem: AcsEcgInterpretationCS
Id: acs-ecg-interpretation
Title: "ACS ECG Interpretation Code System"
Description: "Initial presenting rhythm of the heart (HISO 10052:2026 §2.6 ECG interpretation)."
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* #sinus-rhythm "Sinus rhythm"
* #af "Atrial fibrillation"
* #aflutter "Atrial flutter"
* #svt "Supraventricular tachycardia (SVT)"
* #vf "Ventricular fibrillation (VF)"
* #vt "Ventricular tachycardia (VT)"
* #sinus-tachy "Sinus tachycardia"
* #sinus-brady "Sinus bradycardia"
* #junctional "Junctional"
* #pvc "Premature ventricular contractions (PVC)"
* #pac "Premature atrial contractions (PAC)"
* #pjc "Premature junctional contractions (PJC)"
* #hb-1 "1st degree heart block"
* #hb-2-mobitz-1 "2nd degree heart block; Mobitz type 1"
* #hb-2-mobitz-2 "2nd degree heart block; Mobitz type 2"
* #hb-complete "Complete heart block"
* #lbbb "Left bundle branch block (LBBB)"
* #rbbb "Right bundle branch block (RBBB)"
* #asystole "Asystole"
* #unknown "Unknown"
* #other "Other"

CodeSystem: AcsSkinConditionCS
Id: acs-skin-condition
Title: "ACS Skin Condition Code System"
Description: "Observed skin condition (HISO 10052:2026 §2.6 Skin condition)."
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* #normal "Normal"
* #diaphoretic "Diaphoretic (sweaty)"
* #pallor "Pallor (pale)"
* #flushed "Flushed"
* #cyanosed "Cyanosed (bluish discolouration)"

CodeSystem: AcsRouteCS
Id: acs-route
Title: "ACS Medication Route Code System"
Description: "Route by which a dose is administered (HISO 10052:2026 §2.7 Route)."
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* #infusion "Infusion"
* #inhalation "Inhalation route"
* #im "Intramuscular route"
* #nasal "Nasal route"
* #io "Intraosseous route"
* #iv "Intravenous route"
* #manual-hyperinflation "Manual hyperinflation"
* #nasal-cannula "Oxygen administration via nasal cannula"
* #nebuliser "Nebuliser mask"
* #oral "Per oral route"
* #rectal "Per rectum"
* #reservoir-mask "Reservoir mask"
* #face-mask "Simple face mask"
* #subcut "Subcutaneous route"
* #sublingual "Sublingual route"
* #topical "Topical route"
* #transdermal "Transdermal route"

CodeSystem: AcsMetadataCS
Id: acs-metadata
Title: "ACS Document/Section Metadata Code System"
Description: "Local codes used for Ambulance Care Summary sections and observations that do not have an agreed national/LOINC/SNOMED code in this draft."
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* #section-incident "Incident / Encounter"
* #section-accident "Accident details"
* #presenting-complaint "Presenting complaint (MPDS)"
* #other-presenting-complaint "Other presenting complaint"
* #history-of-incident "History of incident"
* #patient-age "Patient age"
* #master-incident-number "Master incident number"
