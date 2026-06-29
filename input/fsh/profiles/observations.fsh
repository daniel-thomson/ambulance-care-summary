// =====================================================================
// Observations
//   §2.1 Patient age
//   §2.2 Smoking and vaping
//   §2.4 Problems (presenting complaint, accident details)
//   §2.6 Measurements and vital signs
// =====================================================================

RuleSet: AcsObsCommon
* status MS
* code MS
* subject 1..1 MS
* subject only Reference(AmbulanceCareSummaryPatient)
* encounter only Reference(AmbulanceEncounter)
* effective[x] MS
* effective[x] only dateTime
* effectiveDateTime ^short = "Observation date and time"

RuleSet: AcsObsEffectiveRequired
* effective[x] 1..1 MS

RuleSet: AcsVital
* insert AcsObsCommon
* insert AcsObsEffectiveRequired
* category 1..* MS
* category = $obs-category#vital-signs

// --- Base ------------------------------------------------------------
Profile: AcsObservation
Parent: Observation
Id: acs-observation
Title: "ACS Observation"
Description: "Base profile for observations recorded during an ambulance encounter (HISO 10052:2026). Specialised by the measurement-specific profiles."
* insert AcsObsCommon

// --- §2.1 Patient age ------------------------------------------------
Profile: AcsPatientAge
Parent: AcsObservation
Id: acs-patient-age
Title: "ACS Patient Age"
Description: "Patient's current age, calculated from birth date or estimated (HISO 10052:2026 §2.1)."
* insert AcsObsEffectiveRequired
* code = $LOINC#30525-0 "Age"
* value[x] only Quantity
* valueQuantity.system = $UCUM
* valueQuantity.code from AcsAgeUnitVS (required)
* valueQuantity ^short = "Age, with unit of measure day (d), month (mo) or year (a)"
* extension contains AgeEstimated named ageEstimated 0..1 MS

// --- §2.2 Smoking and vaping -----------------------------------------
Profile: AcsSmokingStatus
Parent: AcsObservation
Id: acs-smoking-status
Title: "ACS Smoking Status"
Description: "Current smoking status at the time of the encounter (HISO 10052:2026 §2.2)."
* insert AcsObsEffectiveRequired
* category 1..* MS
* category = $obs-category#social-history
* code = $LOINC#72166-2 "Tobacco smoking status"
* value[x] only CodeableConcept
* valueCodeableConcept from AcsSmokingStatusVS (preferred)

Profile: AcsVapingStatus
Parent: AcsObservation
Id: acs-vaping-status
Title: "ACS Vaping Status"
Description: "Current vaping status at the time of the encounter (HISO 10052:2026 §2.2)."
* category 1..* MS
* category = $obs-category#social-history
* insert AcsObsEffectiveRequired
* code = $SCT#722499006 "Electronic cigarette use finding"
* value[x] only CodeableConcept
* valueCodeableConcept from AcsVapingStatusVS (preferred)

// --- §2.4 Problems ---------------------------------------------------
Profile: AcsPresentingComplaint
Parent: AcsObservation
Id: acs-presenting-complaint
Title: "ACS Presenting Complaint"
Description: "The reason the ambulance was called, coded with MPDS, or free text when no code applies (HISO 10052:2026 §2.4)."
* code = $LOINC#67570-2 "Chief complaint"
* effective[x] 0..1
* value[x] only CodeableConcept or string
* valueCodeableConcept from MpdsVS (extensible)
* value[x] ^short = "Presenting complaint (MPDS code) or other presenting complaint (free text)"
* extension contains OnsetUnknown named onsetUnknown 0..1 MS

Profile: AcsAccidentObservation
Parent: AcsObservation
Id: acs-accident-observation
Title: "ACS Accident Detail Observation"
Description: "An accident detail collected when an ACC claim applies - e.g. mechanism of injury, place of injury, or a road-traffic-accident detail such as rollover or seatbelt worn (HISO 10052:2026 §2.4 Accident details)."
* effective[x] 0..1
* value[x] only CodeableConcept or boolean or Quantity or string
* value[x] ^short = "Accident detail value (coded, boolean, quantity or text depending on the data element)"

// --- §2.6 Measurements and vital signs -------------------------------
Profile: AcsBloodGlucose
Parent: AcsObservation
Id: acs-blood-glucose
Title: "ACS Blood Glucose Level"
Description: "Blood glucose level (BGL), HISO 10052:2026 §2.6."
* insert AcsVital
* code = $LOINC#15074-8 "Glucose [Moles/volume] in Blood"
* value[x] only Quantity
* valueQuantity = 'mmol/L'
* valueQuantity.system = $UCUM
* valueQuantity.code = #mmol/L

Profile: AcsBloodPressure
Parent: AcsObservation
Id: acs-blood-pressure
Title: "ACS Blood Pressure"
Description: "Systolic and diastolic blood pressure, HISO 10052:2026 §2.6."
* insert AcsVital
* code = $LOINC#85354-9 "Blood pressure panel"
* value[x] 0..0
* component MS
* component ^slicing.discriminator.type = #pattern
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open
* component contains systolic 0..1 MS and diastolic 0..1 MS
* component[systolic].code = $LOINC#8480-6 "Systolic blood pressure"
* component[systolic].valueQuantity = 'mm[Hg]'
* component[systolic].valueQuantity.system = $UCUM
* component[systolic].valueQuantity.code = #mm[Hg]
* component[diastolic].code = $LOINC#8462-4 "Diastolic blood pressure"
* component[diastolic].valueQuantity = 'mm[Hg]'
* component[diastolic].valueQuantity.system = $UCUM
* component[diastolic].valueQuantity.code = #mm[Hg]

Profile: AcsHeartRate
Parent: AcsObservation
Id: acs-heart-rate
Title: "ACS Heart Rate"
Description: "Heart rate in beats per minute, HISO 10052:2026 §2.6."
* insert AcsVital
* code = $LOINC#8867-4 "Heart rate"
* value[x] only Quantity
* valueQuantity = '/min'
* valueQuantity.system = $UCUM
* valueQuantity.code = #/min

Profile: AcsRespiratoryRate
Parent: AcsObservation
Id: acs-respiratory-rate
Title: "ACS Respiratory Rate"
Description: "Respiratory rate in breaths per minute, HISO 10052:2026 §2.6."
* insert AcsVital
* code = $LOINC#9279-1 "Respiratory rate"
* value[x] only Quantity
* valueQuantity = '/min'
* valueQuantity.system = $UCUM
* valueQuantity.code = #/min

Profile: AcsOxygenSaturation
Parent: AcsObservation
Id: acs-oxygen-saturation
Title: "ACS Oxygen Saturation"
Description: "Peripheral oxygen saturation (SpO2), HISO 10052:2026 §2.6."
* insert AcsVital
* code = $LOINC#59408-5 "Oxygen saturation in Arterial blood by Pulse oximetry"
* value[x] only Quantity
* valueQuantity = '%'
* valueQuantity.system = $UCUM
* valueQuantity.code = #%

Profile: AcsBodyTemperature
Parent: AcsObservation
Id: acs-body-temperature
Title: "ACS Body Temperature"
Description: "Patient's body temperature, HISO 10052:2026 §2.6."
* insert AcsVital
* code = $LOINC#8310-5 "Body temperature"
* value[x] only Quantity
* valueQuantity = 'Cel'
* valueQuantity.system = $UCUM
* valueQuantity.code = #Cel

Profile: AcsGlasgowComaScore
Parent: AcsObservation
Id: acs-glasgow-coma-score
Title: "ACS Glasgow Coma Score"
Description: "Glasgow Coma Scale (GCS) total score, value 3-15, HISO 10052:2026 §2.6."
* insert AcsVital
* code = $LOINC#9269-2 "Glasgow coma score total"
* value[x] only Quantity
* valueQuantity ^short = "GCS total (3-15)"

Profile: AcsPainScore
Parent: AcsObservation
Id: acs-pain-score
Title: "ACS Pain Score"
Description: "Patient's self-reported pain on the 0-10 Numerical Pain Rating Scale, HISO 10052:2026 §2.6."
* insert AcsVital
* code = $LOINC#72514-3 "Pain severity - 0-10 verbal numeric rating [Score] - Reported"
* value[x] only Quantity
* valueQuantity ^short = "Pain score (0-10)"

Profile: AcsEndTidalCO2
Parent: AcsObservation
Id: acs-end-tidal-co2
Title: "ACS End-tidal CO2"
Description: "End-tidal carbon dioxide (ETCO2), HISO 10052:2026 §2.6."
* insert AcsVital
* code = $LOINC#19889-5 "Carbon dioxide [Partial pressure] in Exhaled gas --at end expiration"
* value[x] only Quantity
* valueQuantity = 'mm[Hg]'
* valueQuantity.system = $UCUM
* valueQuantity.code = #mm[Hg]

Profile: AcsPeakExpiratoryFlow
Parent: AcsObservation
Id: acs-peak-expiratory-flow
Title: "ACS Peak Expiratory Flow Rate"
Description: "Peak Expiratory Flow Rate (PEFR), range 1-800, HISO 10052:2026 §2.6."
* insert AcsVital
* code = $LOINC#33452-4 "Maximum expiratory gas flow Respiratory system airway by Peak flow meter"
* value[x] only Quantity
* valueQuantity = 'L/min'
* valueQuantity.system = $UCUM
* valueQuantity.code = #L/min

Profile: AcsCapillaryRefillTime
Parent: AcsObservation
Id: acs-capillary-refill-time
Title: "ACS Capillary Refill Time"
Description: "Capillary refill time in seconds, with the location (peripheral or central) at which it was measured, HISO 10052:2026 §2.6."
* insert AcsVital
* code = $LOINC#44963-7 "Capillary refill [Time]"
* value[x] only Quantity
* valueQuantity = 's'
* valueQuantity.system = $UCUM
* valueQuantity.code = #s
* bodySite ^short = "Capillary refill time location (peripheral or central)"

Profile: AcsEcgInterpretation
Parent: AcsObservation
Id: acs-ecg-interpretation
Title: "ACS ECG Interpretation"
Description: "Initial presenting rhythm of the heart, HISO 10052:2026 §2.6."
* insert AcsVital
* code = $LOINC#8884-9 "Heart rate rhythm"
* value[x] only CodeableConcept
* valueCodeableConcept from AcsEcgInterpretationVS (extensible)

Profile: AcsSkinCondition
Parent: AcsObservation
Id: acs-skin-condition
Title: "ACS Skin Condition"
Description: "Observed skin condition, HISO 10052:2026 §2.6."
* insert AcsVital
* code = $SCT#225544001 "General skin examination"
* value[x] only CodeableConcept
* valueCodeableConcept from AcsSkinConditionVS (extensible)

Profile: AcsPatientStatus
Parent: AcsObservation
Id: acs-patient-status
Title: "ACS Patient Status"
Description: "Status of the patient (threat to life), recorded at least once per encounter, HISO 10052:2026 §2.6."
* insert AcsVital
* code = $SCT#410536001 "Clinical status of patient (observable entity)"
* value[x] only CodeableConcept
* valueCodeableConcept from AcsPatientStatusVS (extensible)

Profile: AcsPupilSize
Parent: AcsObservation
Id: acs-pupil-size
Title: "ACS Pupil Size"
Description: "Pupil size (mm) of an eye, with the eye side (left or right), HISO 10052:2026 §2.6."
* insert AcsVital
* code = $SCT#367665004 "Diameter of pupil (observable entity)"
* value[x] only Quantity
* valueQuantity = 'mm'
* valueQuantity.system = $UCUM
* valueQuantity.code = #mm
* bodySite ^short = "Eye side (left or right)"

Profile: AcsPupilReaction
Parent: AcsObservation
Id: acs-pupil-reaction
Title: "ACS Pupil Reaction"
Description: "Pupil reaction to light for an eye, with the eye side (left or right), HISO 10052:2026 §2.6."
* insert AcsVital
* code = $SCT#301939004 "Pupillary function (observable entity)"
* value[x] only boolean
* value[x] ^short = "True if the pupil responds to light"
* bodySite ^short = "Eye side (left or right)"
