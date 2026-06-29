// =====================================================================
// Incident details, contacts, media, and assessment profiles
// =====================================================================

RuleSet: AcsObservationPanel
* insert AcsObsCommon
* value[x] 0..0
* component MS
* component ^slicing.discriminator.type = #pattern
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open

// --- Incident / encounter supporting resources -----------------------
Profile: AcsIncidentLocation
Parent: $NzLocation
Id: acs-incident-location
Title: "ACS Incident Location"
Description: "The location where the ambulance incident occurred or where the patient was found."
* name MS
* name ^short = "Short label for the incident location, where available"
* description MS
* description ^short = "Free-text incident location description"
* type MS
* type ^short = "Incident location type, e.g. workplace or private residence"
* address MS
* address ^short = "Incident location address or descriptive location"

Profile: AcsIncidentEvent
Parent: AcsObservation
Id: acs-incident-event
Title: "ACS Incident Event"
Description: "A timestamped operational event in the ambulance incident timeline, such as dispatch, scene arrival, patient located, departure, destination arrival, or incident closure."
* code 1..1 MS
* code from AcsIncidentEventVS (extensible)
* code ^short = "Type of incident timeline event"
* value[x] 1..1 MS
* value[x] only dateTime
* valueDateTime ^short = "Date and time the incident event occurred"

Profile: AcsPatientContact
Parent: $NzRelatedPerson
Id: acs-patient-contact
Title: "ACS Patient Contact"
Description: "A contact person relevant to the ambulance encounter, such as next of kin or a person consulted about treatment or transport decisions."
* patient 1..1 MS
* patient only Reference(AmbulanceCareSummaryPatient)
* relationship MS
* relationship ^short = "Relationship or role, e.g. next of kin"
* name MS
* telecom MS
* extension contains ContactInstruction named contactInstruction 0..1 MS
* extension[contactInstruction] ^short = "Free-text contact instruction or context"

Profile: AcsHistoryOfIncident
Parent: AcsObservation
Id: acs-history-of-incident
Title: "ACS History of Incident"
Description: "Free-text narrative history of the incident or complaint as recorded by the ambulance clinician."
* code = AcsMetadataCS#history-of-incident "History of incident"
* value[x] 1..1 MS
* value[x] only string
* valueString ^short = "Narrative history of incident"

Profile: AcsClinicalImage
Parent: Media
Id: acs-clinical-image
Title: "ACS Clinical Image"
Description: "A clinical image, diagram, or photograph associated with the ambulance care summary, including body diagrams, vehicle diagrams, and scene or clinical photos."
* status MS
* type MS
* type ^short = "Media type, typically image"
* subject 1..1 MS
* subject only Reference(AmbulanceCareSummaryPatient)
* encounter MS
* encounter only Reference(AmbulanceEncounter)
* created[x] MS
* operator only Reference(AmbulanceClinician or AmbulanceServiceProviderRole)
* content 1..1 MS
* content ^short = "Image attachment or reference"
* bodySite MS
* bodySite ^short = "Body site shown, where applicable"
* note MS

// --- Primary survey --------------------------------------------------
Profile: AcsPrimarySurvey
Parent: AcsObservation
Id: acs-primary-survey
Title: "ACS Primary Survey"
Description: "Primary survey findings recorded during the ambulance encounter, including responsiveness, airway, breathing, circulation, and blood loss."
* insert AcsObservationPanel
* code = AcsMetadataCS#primary-survey "Primary survey"
* component contains
    responsiveness 0..1 MS and
    airway 0..1 MS and
    breathing 0..1 MS and
    circulation 0..1 MS and
    bloodLoss 0..1 MS
* component[responsiveness].code = AcsMetadataCS#primary-survey-responsiveness "Responsiveness"
* component[responsiveness].value[x] only CodeableConcept or string
* component[responsiveness].value[x] MS
* component[airway].code = AcsMetadataCS#primary-survey-airway "Airway"
* component[airway].value[x] only CodeableConcept or string
* component[airway].value[x] MS
* component[breathing].code = AcsMetadataCS#primary-survey-breathing "Breathing"
* component[breathing].value[x] only CodeableConcept or string
* component[breathing].value[x] MS
* component[circulation].code = AcsMetadataCS#primary-survey-circulation "Circulation"
* component[circulation].value[x] only CodeableConcept or string
* component[circulation].value[x] MS
* component[bloodLoss].code = AcsMetadataCS#primary-survey-blood-loss "Blood loss"
* component[bloodLoss].value[x] only CodeableConcept or string
* component[bloodLoss].value[x] MS

// --- Stroke assessments ---------------------------------------------
Profile: AcsABCD2StrokeRiskAssessment
Parent: AcsObservation
Id: acs-abcd2-stroke-risk-assessment
Title: "ACS ABCD2 Stroke Risk Assessment"
Description: "ABCD2 stroke risk assessment findings, score, and any reason the assessment could not be completed."
* insert AcsObservationPanel
* code = AcsMetadataCS#abcd2-assessment "ABCD2 stroke risk assessment"
* component contains
    notPossible 0..1 MS and
    age60OrOlder 0..1 MS and
    hypertensive 0..1 MS and
    clinicalFeatures 0..1 MS and
    duration 0..1 MS and
    diabetes 0..1 MS and
    score 0..1 MS
* component[notPossible].code = AcsMetadataCS#assessment-not-possible "Assessment not possible reason"
* component[notPossible].value[x] only CodeableConcept or string
* component[notPossible].value[x] MS
* component[age60OrOlder].code = AcsMetadataCS#abcd2-age-60-or-older "Age 60 or older"
* component[age60OrOlder].value[x] only boolean
* component[age60OrOlder].value[x] MS
* component[hypertensive].code = AcsMetadataCS#abcd2-hypertensive "Hypertensive"
* component[hypertensive].value[x] only boolean
* component[hypertensive].value[x] MS
* component[clinicalFeatures].code = AcsMetadataCS#abcd2-clinical-features "ABCD2 clinical features"
* component[clinicalFeatures].value[x] only CodeableConcept or string
* component[clinicalFeatures].value[x] MS
* component[duration].code = AcsMetadataCS#abcd2-duration "Duration of symptoms"
* component[duration].value[x] only CodeableConcept or string
* component[duration].value[x] MS
* component[diabetes].code = AcsMetadataCS#abcd2-diabetes "Diabetes"
* component[diabetes].value[x] only boolean
* component[diabetes].value[x] MS
* component[score].code = AcsMetadataCS#abcd2-score "ABCD2 score"
* component[score].value[x] only integer
* component[score].value[x] MS

Profile: AcsFASTStrokeAssessment
Parent: AcsObservation
Id: acs-fast-stroke-assessment
Title: "ACS FAST Stroke Assessment"
Description: "FAST stroke assessment findings, timing, hospital notification, and any reason the assessment could not be completed."
* insert AcsObservationPanel
* code = AcsMetadataCS#fast-assessment "FAST stroke assessment"
* component contains
    notPossible 0..1 MS and
    face 0..1 MS and
    faceLaterality 0..1 MS and
    arms 0..1 MS and
    armsLaterality 0..1 MS and
    speech 0..1 MS and
    onset 0..1 MS and
    lastSeenWell 0..1 MS and
    foundInCondition 0..1 MS and
    receivingHospitalNotified 0..1 MS
* component[notPossible].code = AcsMetadataCS#assessment-not-possible "Assessment not possible reason"
* component[notPossible].value[x] only CodeableConcept or string
* component[notPossible].value[x] MS
* component[face].code = AcsMetadataCS#fast-face "Face"
* component[face].value[x] only CodeableConcept or string
* component[face].value[x] MS
* component[faceLaterality].code = AcsMetadataCS#fast-face-laterality "Face laterality"
* component[faceLaterality].value[x] only CodeableConcept or string
* component[faceLaterality].value[x] MS
* component[arms].code = AcsMetadataCS#fast-arms "Arms"
* component[arms].value[x] only CodeableConcept or string
* component[arms].value[x] MS
* component[armsLaterality].code = AcsMetadataCS#fast-arms-laterality "Arms laterality"
* component[armsLaterality].value[x] only CodeableConcept or string
* component[armsLaterality].value[x] MS
* component[speech].code = AcsMetadataCS#fast-speech "Speech"
* component[speech].value[x] only CodeableConcept or string
* component[speech].value[x] MS
* component[onset].code = AcsMetadataCS#stroke-onset "Stroke symptom onset"
* component[onset].value[x] only dateTime
* component[onset].value[x] MS
* component[lastSeenWell].code = AcsMetadataCS#last-seen-well "When last seen well"
* component[lastSeenWell].value[x] only dateTime
* component[lastSeenWell].value[x] MS
* component[foundInCondition].code = AcsMetadataCS#found-in-condition "Patient found in this condition"
* component[foundInCondition].value[x] only boolean
* component[foundInCondition].value[x] MS
* component[receivingHospitalNotified].code = AcsMetadataCS#receiving-hospital-notified "Receiving hospital notified"
* component[receivingHospitalNotified].value[x] only boolean
* component[receivingHospitalNotified].value[x] MS

// --- Falls risk ------------------------------------------------------
Profile: AcsFallsRiskAssessment
Parent: AcsObservation
Id: acs-falls-risk-assessment
Title: "ACS Falls Risk Assessment"
Description: "Falls risk assessment findings, home-safety factors, and any reason the assessment could not be completed."
* insert AcsObservationPanel
* code = AcsMetadataCS#falls-risk-assessment "Falls risk assessment"
* component contains
    notPossible 0..1 MS and
    fallFrequency 0..1 MS and
    avoidsActivities 0..1 MS and
    feetProblem 0..1 MS and
    gaitStrengthBalanceProblem 0..1 MS and
    usesAid 0..1 MS and
    dizziness 0..1 MS and
    cognitiveImpairment 0..1 MS and
    tripHazards 0..1 MS and
    homeModificationsRequired 0..1 MS and
    homeModificationsNotes 0..1 MS and
    livesAlone 0..1 MS and
    fallsAssessmentNotes 0..1 MS
* component[notPossible].code = AcsMetadataCS#assessment-not-possible "Assessment not possible reason"
* component[notPossible].value[x] only CodeableConcept or string
* component[notPossible].value[x] MS
* component[fallFrequency].code = AcsMetadataCS#fall-frequency "Fall frequency"
* component[fallFrequency].value[x] only CodeableConcept or string
* component[fallFrequency].value[x] MS
* component[avoidsActivities].code = AcsMetadataCS#avoids-activities "Avoids activities"
* component[avoidsActivities].value[x] only boolean
* component[avoidsActivities].value[x] MS
* component[feetProblem].code = AcsMetadataCS#feet-problem "Feet problem"
* component[feetProblem].value[x] only boolean
* component[feetProblem].value[x] MS
* component[gaitStrengthBalanceProblem].code = AcsMetadataCS#gait-strength-balance-problem "Gait strength balance problem"
* component[gaitStrengthBalanceProblem].value[x] only boolean
* component[gaitStrengthBalanceProblem].value[x] MS
* component[usesAid].code = AcsMetadataCS#uses-aid "Uses an aid"
* component[usesAid].value[x] only boolean
* component[usesAid].value[x] MS
* component[dizziness].code = AcsMetadataCS#dizziness "Dizziness"
* component[dizziness].value[x] only boolean
* component[dizziness].value[x] MS
* component[cognitiveImpairment].code = AcsMetadataCS#cognitive-impairment "Cognitive impairment"
* component[cognitiveImpairment].value[x] only boolean
* component[cognitiveImpairment].value[x] MS
* component[tripHazards].code = AcsMetadataCS#trip-hazards "Trip hazards"
* component[tripHazards].value[x] only boolean
* component[tripHazards].value[x] MS
* component[homeModificationsRequired].code = AcsMetadataCS#home-modifications-required "Home modifications required"
* component[homeModificationsRequired].value[x] only boolean
* component[homeModificationsRequired].value[x] MS
* component[homeModificationsNotes].code = AcsMetadataCS#home-modifications-notes "Home modifications notes"
* component[homeModificationsNotes].value[x] only string
* component[homeModificationsNotes].value[x] MS
* component[livesAlone].code = AcsMetadataCS#lives-alone "Lives alone"
* component[livesAlone].value[x] only boolean
* component[livesAlone].value[x] MS
* component[fallsAssessmentNotes].code = AcsMetadataCS#falls-assessment-notes "Falls assessment notes"
* component[fallsAssessmentNotes].value[x] only string
* component[fallsAssessmentNotes].value[x] MS

// --- Refusal and competence -----------------------------------------
Profile: AcsTransportTreatmentRefusal
Parent: AcsObservation
Id: acs-transport-treatment-refusal
Title: "ACS Transport/Treatment Refusal"
Description: "Details recorded when treatment or transport is required but refused, represented as an Observation panel."
* insert AcsObservationPanel
* code = AcsMetadataCS#transport-treatment-refusal "Transport/treatment refusal"
* component contains
    treatmentRequired 0..1 MS and
    transportRequired 0..1 MS and
    consultedWith 0..1 MS and
    reasonForRefusal 0..1 MS and
    consequencesExplained 0..1 MS
* component[treatmentRequired].code = AcsMetadataCS#treatment-required "Treatment required"
* component[treatmentRequired].value[x] only boolean
* component[treatmentRequired].value[x] MS
* component[transportRequired].code = AcsMetadataCS#transport-required "Transport required"
* component[transportRequired].value[x] only boolean
* component[transportRequired].value[x] MS
* component[consultedWith].code = AcsMetadataCS#consulted-with "Consulted with"
* component[consultedWith].value[x] only string
* component[consultedWith].value[x] MS
* component[reasonForRefusal].code = AcsMetadataCS#reason-for-refusal "Reason for refusal"
* component[reasonForRefusal].value[x] only string
* component[reasonForRefusal].value[x] MS
* component[consequencesExplained].code = AcsMetadataCS#consequences-explained "Consequences explained"
* component[consequencesExplained].value[x] only string
* component[consequencesExplained].value[x] MS

Profile: AcsPatientCompetenceAssessment
Parent: AcsObservation
Id: acs-patient-competence-assessment
Title: "ACS Patient Competence Assessment"
Description: "Assessment of whether the patient appears able to understand, retain, and weigh information relevant to treatment or transport decisions."
* insert AcsObservationPanel
* code = AcsMetadataCS#patient-competence-assessment "Patient competence assessment"
* component contains
    understandsTreatmentInformation 0..1 MS and
    understandsDecisionConsequences 0..1 MS and
    remembersInformation 0..1 MS and
    selfHarmConcern 0..1 MS
* component[understandsTreatmentInformation].code = AcsMetadataCS#understands-treatment-information "Understands treatment information"
* component[understandsTreatmentInformation].value[x] only boolean
* component[understandsTreatmentInformation].value[x] MS
* component[understandsDecisionConsequences].code = AcsMetadataCS#understands-decision-consequences "Understands decision consequences"
* component[understandsDecisionConsequences].value[x] only boolean
* component[understandsDecisionConsequences].value[x] MS
* component[remembersInformation].code = AcsMetadataCS#remembers-information "Remembers information"
* component[remembersInformation].value[x] only boolean
* component[remembersInformation].value[x] MS
* component[selfHarmConcern].code = AcsMetadataCS#self-harm-concern "Self-harm concern"
* component[selfHarmConcern].value[x] only boolean
* component[selfHarmConcern].value[x] MS

// --- Patient history -------------------------------------------------
Profile: AcsLastOralIntake
Parent: AcsObservation
Id: acs-last-oral-intake
Title: "ACS Last Oral Intake"
Description: "The patient's last oral intake time and details, including food or fluid description where recorded."
* code = $LOINC#67517-3 "Last oral intake"
* value[x] 0..1 MS
* value[x] only dateTime
* valueDateTime ^short = "Date and time of last oral intake"
* extension contains OnsetUnknown named intakeTimeUnknown 0..1 MS
* component MS
* component ^slicing.discriminator.type = #pattern
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open
* component contains intakeDetail 0..1 MS
* component[intakeDetail].code = AcsMetadataCS#last-oral-intake-detail "Last oral intake detail"
* component[intakeDetail].value[x] only string
* component[intakeDetail].value[x] MS
