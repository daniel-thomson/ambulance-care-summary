// =====================================================================
// CDA recreation example - complete Ambulance Care Summary document
// Data source: CDA-examples/ambulanceCareSummaryCDAExample.xml
// =====================================================================

Alias: $NZMT = urn:oid:2.16.840.1.113883.2.18.26

RuleSet: AcsCdaObservationContext
* status = #final
* subject = Reference(acs-cda-patient-bob)
* encounter = Reference(acs-cda-encounter)

RuleSet: AcsCdaVitalContext
* insert AcsCdaObservationContext
* category = $obs-category#vital-signs
* effectiveDateTime = "2016-06-14T11:35:00+12:00"
* note.text = "A note about the observations"

RuleSet: AcsCdaMedicationCommon
* status = #completed
* subject = Reference(acs-cda-patient-bob)
* context = Reference(acs-cda-encounter)
* performer.actor = Reference(acs-cda-providerrole-josephine)

RuleSet: AcsCdaProcedureCommon
* status = #completed
* subject = Reference(acs-cda-patient-bob)
* encounter = Reference(acs-cda-encounter)
* performer.actor = Reference(acs-cda-providerrole-josephine)

RuleSet: AcsCdaSectionEntry(sectionName, resourceType, resourceId)
* section[{sectionName}].entry[+].reference = "https://example.org/fhir/{resourceType}/{resourceId}"

RuleSet: AcsCdaBundleEntry(resourceType, resourceId)
* entry[+].fullUrl = "https://example.org/fhir/{resourceType}/{resourceId}"
* entry[=].resource = {resourceId}

// --- Header, patient, contacts, and provider actors ------------------
Instance: acs-cda-patient-bob
InstanceOf: AmbulanceCareSummaryPatient
Usage: #example
Title: "CDA Example Patient - Bob Bobson"
Description: "Patient demographics from the CDA ambulance care summary example."
* identifier[NHI].system = $nhi
* identifier[NHI].value = "ABC1235"
* extension[sexAtBirth].valueCodeableConcept = http://hl7.org/fhir/administrative-gender#male "Male"
* name.use = #official
* name.prefix = "Mr"
* name.given[0] = "Bob"
* name.given[1] = "Bobby"
* name.family = "Bobson"
* gender = #male
* birthDate = "1984-06-02"
* telecom[0].system = #phone
* telecom[0].value = "(03) 444 7890"
* telecom[0].use = #home
* telecom[1].system = #phone
* telecom[1].value = "(03) 444 7654"
* telecom[1].use = #work
* telecom[2].system = #phone
* telecom[2].value = "(027) 7878 7878"
* telecom[2].use = #mobile
* telecom[3].system = #email
* telecom[3].value = "bob@bobson.org.nz"
* telecom[3].use = #home
* address.use = #home
* address.line[0] = "Bobs Big Building"
* address.line[1] = "17 Bobson Boulevard"
* address.district = "Baldrick"
* address.city = "Boganville"
* address.postalCode = "6789"
* address.country = "New Zealand"

Instance: acs-cda-patient-age
InstanceOf: AcsPatientAge
Usage: #example
Title: "CDA Example Patient Age"
Description: "Patient age and age-estimated flag from the CDA additional demographics section."
* insert AcsCdaObservationContext
* code = $LOINC#30525-0 "Age"
* effectiveDateTime = "2016-06-14T11:13:00+12:00"
* valueQuantity = 30 'a'
* extension[ageEstimated].valueBoolean = false

Instance: acs-cda-contact-mother
InstanceOf: AcsPatientContact
Usage: #example
Title: "CDA Example Patient Contact - Mother"
Description: "Next-of-kin/contact instruction recorded in the CDA participants."
* patient = Reference(acs-cda-patient-bob)
* relationship.text = "Next of kin"
* name.text = "Patient's mother"
* telecom.system = #phone
* telecom.value = "0211211212"
* extension[contactInstruction].valueString = "Please contact mother on 0211211212"

Instance: acs-cda-clinician-josephine
InstanceOf: AmbulanceClinician
Usage: #example
Title: "CDA Example Clinician - Josephine Manu-Bloggs"
Description: "Attending ambulance clinician and CDA author."
* identifier[paramedicCouncil].system = $paramedic-council
* identifier[paramedicCouncil].value = "100901"
* name.use = #official
* name.given = "Josephine"
* name.family = "Manu-Bloggs"
* address.use = #work
* address.line = "2 Harrison Road"
* address.district = "Panmure"
* address.city = "Auckland"
* address.postalCode = "1741"
* address.country = "New Zealand"
* telecom.system = #phone
* telecom.value = "+6495791015"
* telecom.use = #work

Instance: acs-cda-clinician-bob
InstanceOf: AmbulanceClinician
Usage: #example
Title: "CDA Example Clinician - Bob"
Description: "Second attending ambulance officer from the CDA participants."
* identifier[paramedicCouncil].system = $paramedic-council
* identifier[paramedicCouncil].value = "600821"
* name.use = #usual
* name.given = "Bob"

Instance: acs-cda-medical-director-rex
InstanceOf: AmbulanceClinician
Usage: #example
Title: "CDA Example Legal Authenticator - Dr Rex Anthony Smith"
Description: "Medical director recorded as the CDA legal authenticator."
* identifier[hpiCpn].system = $hpi-person
* identifier[hpiCpn].value = "17AHVX"
* name.use = #official
* name.prefix = "Dr"
* name.given = "Rex Anthony"
* name.family = "Smith"
* address.use = #work
* address.line = "2 Harrison Road"
* address.district = "Panmure"
* address.city = "Auckland"
* address.postalCode = "1741"
* address.country = "New Zealand"
* telecom.system = #phone
* telecom.value = "+6495791015"
* telecom.use = #work

Instance: acs-cda-org-stjohn
InstanceOf: AmbulanceServiceOrganization
Usage: #example
Title: "CDA Example Ambulance Operator - Order of St John"
Description: "Ambulance operator/custodian from the CDA example."
* identifier[hpiOrg].system = $hpi-org
* identifier[hpiOrg].value = "G02780-A"
* name = "Order of St John"
* telecom.system = #phone
* telecom.value = "+6495791015"
* telecom.use = #work
* address.use = #work
* address.line = "2 Harrison Road"
* address.district = "Panmure"
* address.city = "Auckland"
* address.postalCode = "1741"
* address.country = "New Zealand"

Instance: acs-cda-providerrole-josephine
InstanceOf: AmbulanceServiceProviderRole
Usage: #example
Title: "CDA Example Provider Role - Josephine at St John"
Description: "Provider role for the author and first attending ambulance officer."
* practitioner = Reference(acs-cda-clinician-josephine)
* organization = Reference(acs-cda-org-stjohn)
* code = $SCT#397897005 "Paramedic"

Instance: acs-cda-providerrole-bob
InstanceOf: AmbulanceServiceProviderRole
Usage: #example
Title: "CDA Example Provider Role - Bob at St John"
Description: "Provider role for the second attending ambulance officer."
* practitioner = Reference(acs-cda-clinician-bob)
* organization = Reference(acs-cda-org-stjohn)
* code = $SCT#397897005 "Paramedic"

Instance: acs-cda-providerrole-rex
InstanceOf: AmbulanceServiceProviderRole
Usage: #example
Title: "CDA Example Provider Role - Medical Director"
Description: "Provider role for the legal authenticator."
* practitioner = Reference(acs-cda-medical-director-rex)
* organization = Reference(acs-cda-org-stjohn)
* code[0].text = "Medical Director"

Instance: acs-cda-facility-sunshine
InstanceOf: ReceivingFacility
Usage: #example
Title: "CDA Example Receiving Facility - Sunshine Hospital ED"
Description: "Receiving destination from the CDA encompassing encounter."
* status = #active
* name = "Sunshine Hospital Emergency Department"

// --- Incident / encounter -------------------------------------------
Instance: acs-cda-incident-location
InstanceOf: AcsIncidentLocation
Usage: #example
Title: "CDA Example Incident Location"
Description: "Incident location and location type from the CDA incident history."
* status = #active
* name = "MATAI RD/CAMPBELL RD"
* description = "MATAI RD/CAMPBELL RD 10 Miro Rd"
* type.text = "Workplace"
* address.text = "MATAI RD/CAMPBELL RD 10 Miro Rd"

Instance: acs-cda-encounter
InstanceOf: AmbulanceEncounter
Usage: #example
Title: "CDA Example Encounter - Incident 0450-1-2016/06/14"
Description: "Ambulance encounter reconstructed from the CDA documentationOf/componentOf and incident history."
* identifier[masterIncidentNumber].system = "https://standards.digital.health.nz/ns/ambulance-master-incident-number"
* identifier[masterIncidentNumber].value = "0450-1-2016/06/14"
* identifier[accClaimNumber].system = $acc-claim
* identifier[accClaimNumber].value = "XA12345"
* identifier[unitCallSign].system = "https://standards.digital.health.nz/ns/ambulance-unit-call-sign"
* identifier[unitCallSign].value = "MTWELL1"
* status = #finished
* class = $v3-ActCode#EMER "emergency"
* type = AcsEncounterTypeCS#land-ambulance
* subject = Reference(acs-cda-patient-bob)
* participant[0].individual = Reference(acs-cda-providerrole-josephine)
* participant[1].individual = Reference(acs-cda-providerrole-bob)
* location[0].location = Reference(acs-cda-incident-location)
* location[1].location = Reference(acs-cda-facility-sunshine)
* period.start = "2016-06-14T11:13:00+12:00"
* period.end = "2016-06-14T12:42:00+12:00"
* reasonReference = Reference(acs-cda-presenting-complaint)
* diagnosis[0].condition = Reference(acs-cda-diagnosis-asthma)
* diagnosis[0].rank = 1
* diagnosis[1].condition = Reference(acs-cda-diagnosis-generally-unwell)
* diagnosis[1].rank = 2
* hospitalization.dischargeDisposition = AcsDispositionCS#treat-and-transport "Treat and transport"
* hospitalization.dischargeDisposition.text = "Transport"
* hospitalization.destination = Reference(acs-cda-facility-sunshine)
* serviceProvider = Reference(acs-cda-org-stjohn)

RuleSet: AcsCdaIncidentEventContext
* insert AcsCdaObservationContext

Instance: acs-cda-event-call-received
InstanceOf: AcsIncidentEvent
Usage: #example
Title: "CDA Example Incident Event - Call Received"
Description: "Time call received."
* insert AcsCdaIncidentEventContext
* code = AcsMetadataCS#incident-event-call-received "Time call received"
* valueDateTime = "2016-06-14T11:13:00+12:00"

Instance: acs-cda-event-unit-dispatched
InstanceOf: AcsIncidentEvent
Usage: #example
Title: "CDA Example Incident Event - Unit Dispatched"
Description: "Time unit dispatched."
* insert AcsCdaIncidentEventContext
* code = AcsMetadataCS#incident-event-unit-dispatched "Time unit dispatched"
* valueDateTime = "2016-06-14T11:14:00+12:00"

Instance: acs-cda-event-unit-responded
InstanceOf: AcsIncidentEvent
Usage: #example
Title: "CDA Example Incident Event - Unit Responded"
Description: "Time unit responded."
* insert AcsCdaIncidentEventContext
* code = AcsMetadataCS#incident-event-unit-responded "Time unit responded"
* valueDateTime = "2016-06-14T11:14:00+12:00"

Instance: acs-cda-event-arrived-scene
InstanceOf: AcsIncidentEvent
Usage: #example
Title: "CDA Example Incident Event - Arrived at Scene"
Description: "Time unit arrived at scene."
* insert AcsCdaIncidentEventContext
* code = AcsMetadataCS#incident-event-arrived-scene "Time unit arrived at scene"
* valueDateTime = "2016-06-14T11:28:00+12:00"

Instance: acs-cda-event-patient-located
InstanceOf: AcsIncidentEvent
Usage: #example
Title: "CDA Example Incident Event - Patient Located"
Description: "Time patient located."
* insert AcsCdaIncidentEventContext
* code = AcsMetadataCS#incident-event-patient-located "Time patient located"
* valueDateTime = "2016-06-14T11:30:00+12:00"

Instance: acs-cda-event-departed-scene
InstanceOf: AcsIncidentEvent
Usage: #example
Title: "CDA Example Incident Event - Departed Scene"
Description: "Time unit departed with patient."
* insert AcsCdaIncidentEventContext
* code = AcsMetadataCS#incident-event-departed-scene "Time unit departed with patient"
* valueDateTime = "2016-06-14T11:55:00+12:00"

Instance: acs-cda-event-arrived-destination
InstanceOf: AcsIncidentEvent
Usage: #example
Title: "CDA Example Incident Event - Arrived at Destination"
Description: "Time unit arrived at destination."
* insert AcsCdaIncidentEventContext
* code = AcsMetadataCS#incident-event-arrived-destination "Time unit arrived at destination"
* valueDateTime = "2016-06-14T12:07:00+12:00"

Instance: acs-cda-event-closed
InstanceOf: AcsIncidentEvent
Usage: #example
Title: "CDA Example Incident Event - Incident Closed"
Description: "Time incident closed."
* insert AcsCdaIncidentEventContext
* code = AcsMetadataCS#incident-event-closed "Time incident closed"
* valueDateTime = "2016-06-14T12:42:00+12:00"

Instance: acs-cda-patient-status-scene
InstanceOf: AcsPatientStatus
Usage: #example
Title: "CDA Example Patient Status at Scene"
Description: "Patient status at scene from the CDA incident history and primary survey."
* insert AcsCdaObservationContext
* category = $obs-category#vital-signs
* code = $SCT#410536001 "Clinical status of patient (observable entity)"
* effectiveDateTime = "2016-06-14T11:30:00+12:00"
* valueCodeableConcept = AcsPatientStatusCS#immediate-threat "Immediate threat to life"

Instance: acs-cda-patient-status-final
InstanceOf: AcsPatientStatus
Usage: #example
Title: "CDA Example Final Patient Status"
Description: "Final patient status from the CDA incident history."
* insert AcsCdaObservationContext
* category = $obs-category#vital-signs
* code = $SCT#410536001 "Clinical status of patient (observable entity)"
* effectiveDateTime = "2016-06-14T12:07:00+12:00"
* valueCodeableConcept = AcsPatientStatusCS#no-threat "No threat to life"

// --- Social history, complaint history, accident details, impressions -
Instance: acs-cda-smoking
InstanceOf: AcsSmokingStatus
Usage: #example
Title: "CDA Example Smoking Status"
Description: "Smoking status carried forward from the basic CDA-derived example."
* status = #final
* category = $obs-category#social-history
* code = $LOINC#72166-2 "Tobacco smoking status"
* subject = Reference(acs-cda-patient-bob)
* encounter = Reference(acs-cda-encounter)
* effectiveDateTime = "2016-06-14T11:30:00+12:00"
* valueCodeableConcept = $SCT#8517006 "Ex-smoker"

Instance: acs-cda-presenting-complaint
InstanceOf: AcsPresentingComplaint
Usage: #example
Title: "CDA Example Presenting Complaint - Shortness of Breath"
Description: "Presenting complaint from the CDA complaint history."
* insert AcsCdaObservationContext
* code = $LOINC#67570-2 "Chief complaint"
* effectiveDateTime = "2016-06-14T02:00:00+12:00"
* valueString = "Shortness of breath"

Instance: acs-cda-history-of-incident
InstanceOf: AcsHistoryOfIncident
Usage: #example
Title: "CDA Example History of Incident"
Description: "Free-text history of incident from the CDA complaint history."
* insert AcsCdaObservationContext
* code = AcsMetadataCS#history-of-incident "History of incident"
* effectiveDateTime = "2016-06-14T11:13:00+12:00"
* valueString = "History line 1\nHistory line 2\nHistory line 3"

Instance: acs-cda-accident-mechanism
InstanceOf: AcsAccidentObservation
Usage: #example
Title: "CDA Example Accident Detail - Mechanism of Injury"
Description: "Mechanism of injury from the CDA complaint history."
* insert AcsCdaObservationContext
* code = $LOINC#67494-5 "Mechanism of Injury"
* valueString = "Chemical poisoning"

Instance: acs-cda-accident-sport
InstanceOf: AcsAccidentObservation
Usage: #example
Title: "CDA Example Accident Detail - Sports Injury"
Description: "Sport recorded for the injury."
* insert AcsCdaObservationContext
* code = $LOINC#11372-0 "Sports Injury"
* valueCodeableConcept.text = "Rugby Union"

Instance: acs-cda-accident-vehicle-type
InstanceOf: AcsAccidentObservation
Usage: #example
Title: "CDA Example Accident Detail - Vehicle Type"
Description: "Vehicle type from the road traffic accident details."
* insert AcsCdaObservationContext
* code = $SCT#46160005 "Vehicle type"
* valueCodeableConcept = $SCT#71783008 "Car"

Instance: acs-cda-accident-patient-characteristic
InstanceOf: AcsAccidentObservation
Usage: #example
Title: "CDA Example Accident Detail - Patient Characteristic"
Description: "Patient role/characteristic in the vehicle."
* insert AcsCdaObservationContext
* code = $SCT#127348004 "Patient characteristic"
* valueCodeableConcept = $SCT#303980003 "Driver"

Instance: acs-cda-accident-impact-speed
InstanceOf: AcsAccidentObservation
Usage: #example
Title: "CDA Example Accident Detail - Estimated Impact Speed"
Description: "Estimated vehicle impact speed."
* insert AcsCdaObservationContext
* code.text = "Estimated Impact Speed"
* valueQuantity = 150 'km/h'

Instance: acs-cda-accident-passenger-intrusion
InstanceOf: AcsAccidentObservation
Usage: #example
Title: "CDA Example Accident Detail - Passenger Compartment Intrusion"
Description: "Passenger compartment intrusion flag."
* insert AcsCdaObservationContext
* code.text = "Passenger Compartment Intrusion"
* valueBoolean = true

Instance: acs-cda-accident-patient-ejected
InstanceOf: AcsAccidentObservation
Usage: #example
Title: "CDA Example Accident Detail - Patient Ejected"
Description: "Patient ejected flag."
* insert AcsCdaObservationContext
* code.text = "Patient Ejected"
* valueBoolean = true

Instance: acs-cda-accident-rollover
InstanceOf: AcsAccidentObservation
Usage: #example
Title: "CDA Example Accident Detail - Rollover"
Description: "Vehicle rollover flag."
* insert AcsCdaObservationContext
* code.text = "Rollover"
* valueBoolean = true

Instance: acs-cda-accident-end-over-end
InstanceOf: AcsAccidentObservation
Usage: #example
Title: "CDA Example Accident Detail - End Over End"
Description: "End over end flag."
* insert AcsCdaObservationContext
* code.text = "End Over End"
* valueBoolean = true

Instance: acs-cda-accident-airbag
InstanceOf: AcsAccidentObservation
Usage: #example
Title: "CDA Example Accident Detail - Air Bag Deployed"
Description: "Air bag deployed flag."
* insert AcsCdaObservationContext
* code.text = "Air Bag Deployed"
* valueBoolean = true

Instance: acs-cda-accident-seatbelt
InstanceOf: AcsAccidentObservation
Usage: #example
Title: "CDA Example Accident Detail - Seatbelt or Child Restraint Used"
Description: "Seatbelt or child restraint used flag."
* insert AcsCdaObservationContext
* code.text = "Seatbelt or child restraint used"
* valueBoolean = true

Instance: acs-cda-accident-helmet
InstanceOf: AcsAccidentObservation
Usage: #example
Title: "CDA Example Accident Detail - Helmet Worn"
Description: "Helmet worn flag."
* insert AcsCdaObservationContext
* code.text = "Helmet Worn"
* valueBoolean = true

Instance: acs-cda-accident-self-extricated
InstanceOf: AcsAccidentObservation
Usage: #example
Title: "CDA Example Accident Detail - Self-extricated"
Description: "Self-extricated flag."
* insert AcsCdaObservationContext
* code.text = "Self-extricated"
* valueBoolean = true

Instance: acs-cda-accident-patient-trapped
InstanceOf: AcsAccidentObservation
Usage: #example
Title: "CDA Example Accident Detail - Patient Trapped"
Description: "Patient trapped flag."
* insert AcsCdaObservationContext
* code.text = "Patient Trapped"
* valueBoolean = true

Instance: acs-cda-diagnosis-asthma
InstanceOf: AcsEncounterDiagnosis
Usage: #example
Title: "CDA Example Encounter Diagnosis - Asthma"
Description: "Primary clinical impression from the CDA clinical impression section."
* clinicalStatus = $cond-clinical#active
* category = $cond-category#encounter-diagnosis
* code = $SCT#195967001 "Asthma"
* subject = Reference(acs-cda-patient-bob)
* encounter = Reference(acs-cda-encounter)
* onsetDateTime = "2016-06-14T11:13:00+12:00"
* note.text = "Clinical impression notes line 1\nClinical impression notes line 2"

Instance: acs-cda-diagnosis-generally-unwell
InstanceOf: AcsEncounterDiagnosis
Usage: #example
Title: "CDA Example Encounter Diagnosis - Generally Unwell"
Description: "Secondary clinical impression from the CDA clinical impression section."
* clinicalStatus = $cond-clinical#active
* category = $cond-category#encounter-diagnosis
* code = $SCT#213257006 "Generally unwell"
* subject = Reference(acs-cda-patient-bob)
* encounter = Reference(acs-cda-encounter)
* onsetDateTime = "2016-06-14T11:13:00+12:00"
* note.text = "Clinical impression notes line 1\nClinical impression notes line 2"

// --- Assessment panels ----------------------------------------------
Instance: acs-cda-primary-survey
InstanceOf: AcsPrimarySurvey
Usage: #example
Title: "CDA Example Primary Survey"
Description: "Primary survey findings from the CDA primary survey section."
* insert AcsCdaObservationContext
* code = AcsMetadataCS#primary-survey "Primary survey"
* effectiveDateTime = "2016-06-14T11:30:00+12:00"
* component[responsiveness].code = AcsMetadataCS#primary-survey-responsiveness "Responsiveness"
* component[responsiveness].valueString = "Alert"
* component[airway].code = AcsMetadataCS#primary-survey-airway "Airway"
* component[airway].valueString = "Patent (clear)"
* component[breathing].code = AcsMetadataCS#primary-survey-breathing "Breathing"
* component[breathing].valueString = "Ineffective"
* component[circulation].code = AcsMetadataCS#primary-survey-circulation "Circulation"
* component[circulation].valueString = "Compromised"
* component[bloodLoss].code = AcsMetadataCS#primary-survey-blood-loss "Blood loss"
* component[bloodLoss].valueString = "Nil"

Instance: acs-cda-abcd2-refused
InstanceOf: AcsABCD2StrokeRiskAssessment
Usage: #example
Title: "CDA Example ABCD2 Stroke Risk Assessment - Refused"
Description: "ABCD2 assessment-not-possible entry from the CDA."
* insert AcsCdaObservationContext
* code = AcsMetadataCS#abcd2-assessment "ABCD2 stroke risk assessment"
* effectiveDateTime = "2016-06-14T11:00:00+12:00"
* component[notPossible].code = AcsMetadataCS#assessment-not-possible "Assessment not possible reason"
* component[notPossible].valueString = "Patient refused"

Instance: acs-cda-abcd2-completed
InstanceOf: AcsABCD2StrokeRiskAssessment
Usage: #example
Title: "CDA Example ABCD2 Stroke Risk Assessment - Completed"
Description: "Completed ABCD2 assessment from the CDA."
* insert AcsCdaObservationContext
* code = AcsMetadataCS#abcd2-assessment "ABCD2 stroke risk assessment"
* effectiveDateTime = "2016-06-14T11:00:00+12:00"
* component[age60OrOlder].code = AcsMetadataCS#abcd2-age-60-or-older "Age 60 or older"
* component[age60OrOlder].valueBoolean = false
* component[hypertensive].code = AcsMetadataCS#abcd2-hypertensive "Hypertensive"
* component[hypertensive].valueBoolean = true
* component[clinicalFeatures].code = AcsMetadataCS#abcd2-clinical-features "ABCD2 clinical features"
* component[clinicalFeatures].valueString = "Speech disturbance without weakness"
* component[duration].code = AcsMetadataCS#abcd2-duration "Duration of symptoms"
* component[duration].valueString = ">= 60 min"
* component[diabetes].code = AcsMetadataCS#abcd2-diabetes "Diabetes"
* component[diabetes].valueBoolean = false
* component[score].code = AcsMetadataCS#abcd2-score "ABCD2 score"
* component[score].valueInteger = 3

Instance: acs-cda-fast-refused
InstanceOf: AcsFASTStrokeAssessment
Usage: #example
Title: "CDA Example FAST Stroke Assessment - Refused"
Description: "FAST assessment-not-possible entry from the CDA."
* insert AcsCdaObservationContext
* code = AcsMetadataCS#fast-assessment "FAST stroke assessment"
* effectiveDateTime = "2016-06-14T11:00:00+12:00"
* component[notPossible].code = AcsMetadataCS#assessment-not-possible "Assessment not possible reason"
* component[notPossible].valueString = "Patient refused"

Instance: acs-cda-fast-completed
InstanceOf: AcsFASTStrokeAssessment
Usage: #example
Title: "CDA Example FAST Stroke Assessment - Completed"
Description: "Completed FAST assessment from the CDA."
* insert AcsCdaObservationContext
* code = AcsMetadataCS#fast-assessment "FAST stroke assessment"
* effectiveDateTime = "2016-06-14T11:00:00+12:00"
* component[face].code = AcsMetadataCS#fast-face "Face"
* component[face].valueString = "Right side droop"
* component[faceLaterality].code = AcsMetadataCS#fast-face-laterality "Face laterality"
* component[faceLaterality].valueString = "Right"
* component[arms].code = AcsMetadataCS#fast-arms "Arms"
* component[arms].valueString = "Right side drift"
* component[armsLaterality].code = AcsMetadataCS#fast-arms-laterality "Arms laterality"
* component[armsLaterality].valueString = "Right"
* component[speech].code = AcsMetadataCS#fast-speech "Speech"
* component[speech].valueString = "Slurred"
* component[onset].code = AcsMetadataCS#stroke-onset "Stroke symptom onset"
* component[onset].valueDateTime = "2016-06-14T09:35:00+12:00"
* component[lastSeenWell].code = AcsMetadataCS#last-seen-well "When last seen well"
* component[lastSeenWell].valueDateTime = "2016-06-13T17:30:00+12:00"
* component[foundInCondition].code = AcsMetadataCS#found-in-condition "Patient found in this condition"
* component[foundInCondition].valueBoolean = true
* component[receivingHospitalNotified].code = AcsMetadataCS#receiving-hospital-notified "Receiving hospital notified"
* component[receivingHospitalNotified].valueBoolean = true

Instance: acs-cda-falls-refused
InstanceOf: AcsFallsRiskAssessment
Usage: #example
Title: "CDA Example Falls Risk Assessment - Refused"
Description: "Falls assessment-not-possible entry from the CDA."
* insert AcsCdaObservationContext
* code = AcsMetadataCS#falls-risk-assessment "Falls risk assessment"
* effectiveDateTime = "2016-06-14T11:00:00+12:00"
* component[notPossible].code = AcsMetadataCS#assessment-not-possible "Assessment not possible reason"
* component[notPossible].valueString = "Patient refused"

Instance: acs-cda-falls-completed
InstanceOf: AcsFallsRiskAssessment
Usage: #example
Title: "CDA Example Falls Risk Assessment - Completed"
Description: "Completed falls risk assessment from the CDA."
* insert AcsCdaObservationContext
* code = AcsMetadataCS#falls-risk-assessment "Falls risk assessment"
* effectiveDateTime = "2016-06-14T11:00:00+12:00"
* component[fallFrequency].code = AcsMetadataCS#fall-frequency "Fall frequency"
* component[fallFrequency].valueString = "Weekly"
* component[avoidsActivities].code = AcsMetadataCS#avoids-activities "Avoids activities"
* component[avoidsActivities].valueBoolean = true
* component[feetProblem].code = AcsMetadataCS#feet-problem "Feet problem"
* component[feetProblem].valueBoolean = true
* component[gaitStrengthBalanceProblem].code = AcsMetadataCS#gait-strength-balance-problem "Gait strength balance problem"
* component[gaitStrengthBalanceProblem].valueBoolean = true
* component[usesAid].code = AcsMetadataCS#uses-aid "Uses an aid"
* component[usesAid].valueBoolean = false
* component[dizziness].code = AcsMetadataCS#dizziness "Dizziness"
* component[dizziness].valueBoolean = false
* component[cognitiveImpairment].code = AcsMetadataCS#cognitive-impairment "Cognitive impairment"
* component[cognitiveImpairment].valueBoolean = false
* component[tripHazards].code = AcsMetadataCS#trip-hazards "Trip hazards"
* component[tripHazards].valueBoolean = true
* component[homeModificationsRequired].code = AcsMetadataCS#home-modifications-required "Home modifications required"
* component[homeModificationsRequired].valueBoolean = true
* component[homeModificationsNotes].code = AcsMetadataCS#home-modifications-notes "Home modifications notes"
* component[homeModificationsNotes].valueString = "Shower rail, handrail on front steps"
* component[livesAlone].code = AcsMetadataCS#lives-alone "Lives alone"
* component[livesAlone].valueBoolean = true
* component[fallsAssessmentNotes].code = AcsMetadataCS#falls-assessment-notes "Falls assessment notes"
* component[fallsAssessmentNotes].valueString = "The house needs a tidy up there is stuff all over the floor"

Instance: acs-cda-refusal
InstanceOf: AcsTransportTreatmentRefusal
Usage: #example
Title: "CDA Example Transport/Treatment Refusal"
Description: "Transport/treatment refusal details from the CDA."
* insert AcsCdaObservationContext
* code = AcsMetadataCS#transport-treatment-refusal "Transport/treatment refusal"
* effectiveDateTime = "2016-06-14T11:00:00+12:00"
* component[treatmentRequired].code = AcsMetadataCS#treatment-required "Treatment required"
* component[treatmentRequired].valueBoolean = true
* component[transportRequired].code = AcsMetadataCS#transport-required "Transport required"
* component[transportRequired].valueBoolean = true
* component[consultedWith].code = AcsMetadataCS#consulted-with "Consulted with"
* component[consultedWith].valueString = "Patients mother"
* component[reasonForRefusal].code = AcsMetadataCS#reason-for-refusal "Reason for refusal"
* component[reasonForRefusal].valueString = "Doesnt like hospital"
* component[consequencesExplained].code = AcsMetadataCS#consequences-explained "Consequences explained"
* component[consequencesExplained].valueString = "Possible blindness, insanity and death"

Instance: acs-cda-competence
InstanceOf: AcsPatientCompetenceAssessment
Usage: #example
Title: "CDA Example Patient Competence Assessment"
Description: "Patient competence findings from the CDA."
* insert AcsCdaObservationContext
* code = AcsMetadataCS#patient-competence-assessment "Patient competence assessment"
* effectiveDateTime = "2016-06-14T11:00:00+12:00"
* component[understandsTreatmentInformation].code = AcsMetadataCS#understands-treatment-information "Understands treatment information"
* component[understandsTreatmentInformation].valueBoolean = true
* component[understandsDecisionConsequences].code = AcsMetadataCS#understands-decision-consequences "Understands decision consequences"
* component[understandsDecisionConsequences].valueBoolean = true
* component[remembersInformation].code = AcsMetadataCS#remembers-information "Remembers information"
* component[remembersInformation].valueBoolean = true
* component[selfHarmConcern].code = AcsMetadataCS#self-harm-concern "Self-harm concern"
* component[selfHarmConcern].valueBoolean = false

// --- Measurements and vital signs -----------------------------------
Instance: acs-cda-gcs
InstanceOf: AcsGlasgowComaScore
Usage: #example
Title: "CDA Example GCS"
Description: "GCS score from the CDA clinical summary."
* insert AcsCdaVitalContext
* code = $LOINC#9269-2 "Glasgow coma score total"
* valueQuantity = 15 '{score}'

Instance: acs-cda-hr
InstanceOf: AcsHeartRate
Usage: #example
Title: "CDA Example Heart Rate"
Description: "Heart rate from the CDA clinical summary."
* insert AcsCdaVitalContext
* code = $LOINC#8867-4 "Heart rate"
* valueQuantity = 136 '/min'

Instance: acs-cda-rr
InstanceOf: AcsRespiratoryRate
Usage: #example
Title: "CDA Example Respiratory Rate"
Description: "Respiratory rate from the CDA clinical summary."
* insert AcsCdaVitalContext
* code = $LOINC#9279-1 "Respiratory rate"
* valueQuantity = 48 '/min'

Instance: acs-cda-bp
InstanceOf: AcsBloodPressure
Usage: #example
Title: "CDA Example Blood Pressure"
Description: "Blood pressure from the CDA clinical summary."
* insert AcsCdaVitalContext
* code = $LOINC#85354-9 "Blood pressure panel"
* component[systolic].code = $LOINC#8480-6 "Systolic blood pressure"
* component[systolic].valueQuantity = 132 'mm[Hg]'
* component[diastolic].code = $LOINC#8462-4 "Diastolic blood pressure"
* component[diastolic].valueQuantity = 90 'mm[Hg]'

Instance: acs-cda-spo2
InstanceOf: AcsOxygenSaturation
Usage: #example
Title: "CDA Example Oxygen Saturation"
Description: "SpO2 from the CDA clinical summary."
* insert AcsCdaVitalContext
* code = $LOINC#59408-5 "Oxygen saturation in Arterial blood by Pulse oximetry"
* valueQuantity = 95 '%'

Instance: acs-cda-ecg
InstanceOf: AcsEcgInterpretation
Usage: #example
Title: "CDA Example ECG Interpretation"
Description: "ECG/rhythm from the CDA clinical summary. CDA narrative says Atrial Flutter; structured entry says Atrial Fibrillation."
* insert AcsCdaVitalContext
* code = $LOINC#8884-9 "Heart rate rhythm"
* valueCodeableConcept = AcsEcgInterpretationCS#aflutter "Atrial flutter"
* note[1].text = "CDA structured entry coded Atrial Fibrillation while narrative table displayed Atrial Flutter."

Instance: acs-cda-bgl
InstanceOf: AcsBloodGlucose
Usage: #example
Title: "CDA Example Blood Glucose Level"
Description: "Blood glucose level from the CDA clinical summary."
* insert AcsCdaVitalContext
* code = $LOINC#15074-8 "Glucose [Moles/volume] in Blood"
* valueQuantity = 4.0 'mmol/L'

Instance: acs-cda-caprefill-peripheral
InstanceOf: AcsCapillaryRefillTime
Usage: #example
Title: "CDA Example Peripheral Capillary Refill Time"
Description: "Peripheral capillary refill time from the CDA clinical summary."
* insert AcsCdaVitalContext
* code = $LOINC#44963-7 "Capillary refill [Time]"
* bodySite.text = "Peripheral"
* valueQuantity = 2 's'

Instance: acs-cda-caprefill-central
InstanceOf: AcsCapillaryRefillTime
Usage: #example
Title: "CDA Example Central Capillary Refill Time"
Description: "Central capillary refill time from the CDA structured clinical summary."
* insert AcsCdaVitalContext
* code = $LOINC#44963-7 "Capillary refill [Time]"
* bodySite.text = "Central"
* valueQuantity = 3 's'

Instance: acs-cda-temp
InstanceOf: AcsBodyTemperature
Usage: #example
Title: "CDA Example Body Temperature"
Description: "Body temperature from the CDA clinical summary."
* insert AcsCdaVitalContext
* code = $LOINC#8310-5 "Body temperature"
* valueQuantity = 38.6 'Cel'

Instance: acs-cda-pain
InstanceOf: AcsPainScore
Usage: #example
Title: "CDA Example Pain Score"
Description: "Pain score from the CDA clinical summary."
* insert AcsCdaVitalContext
* code = $LOINC#72514-3 "Pain severity - 0-10 verbal numeric rating [Score] - Reported"
* valueQuantity = 5 '{score}'

Instance: acs-cda-pupil-reaction-left
InstanceOf: AcsPupilReaction
Usage: #example
Title: "CDA Example Left Pupil Reaction"
Description: "Left pupil reaction from the CDA clinical summary."
* insert AcsCdaVitalContext
* code = $SCT#301939004 "Pupillary function (observable entity)"
* bodySite.text = "Left eye"
* valueBoolean = true

Instance: acs-cda-pupil-size-left
InstanceOf: AcsPupilSize
Usage: #example
Title: "CDA Example Left Pupil Size"
Description: "Left pupil diameter from the CDA clinical summary."
* insert AcsCdaVitalContext
* code = $SCT#367665004 "Diameter of pupil (observable entity)"
* bodySite.text = "Left eye"
* valueQuantity = 5 'mm'

Instance: acs-cda-pupil-reaction-right
InstanceOf: AcsPupilReaction
Usage: #example
Title: "CDA Example Right Pupil Reaction"
Description: "Right pupil reaction from the CDA clinical summary."
* insert AcsCdaVitalContext
* code = $SCT#301939004 "Pupillary function (observable entity)"
* bodySite.text = "Right eye"
* valueBoolean = true

Instance: acs-cda-pupil-size-right
InstanceOf: AcsPupilSize
Usage: #example
Title: "CDA Example Right Pupil Size"
Description: "Right pupil diameter from the CDA clinical summary."
* insert AcsCdaVitalContext
* code = $SCT#367665004 "Diameter of pupil (observable entity)"
* bodySite.text = "Right eye"
* valueQuantity = 5 'mm'

Instance: acs-cda-etco2
InstanceOf: AcsEndTidalCO2
Usage: #example
Title: "CDA Example End-tidal CO2"
Description: "ETCO2 from the CDA clinical summary. CDA table labels this as mmHg while the structured CDA unit is percent."
* insert AcsCdaVitalContext
* code = $LOINC#19889-5 "Carbon dioxide [Partial pressure] in Exhaled gas --at end expiration"
* valueQuantity = 70 'mm[Hg]'
* note[1].text = "CDA structured unit was %, but the clinical summary heading labelled ETCO2 as mmHg."

Instance: acs-cda-skin
InstanceOf: AcsSkinCondition
Usage: #example
Title: "CDA Example Skin Condition"
Description: "Skin condition from the CDA clinical summary."
* insert AcsCdaVitalContext
* code = $SCT#225544001 "General skin examination"
* valueCodeableConcept = AcsSkinConditionCS#diaphoretic "Diaphoretic (sweaty)"

Instance: acs-cda-pefr
InstanceOf: AcsPeakExpiratoryFlow
Usage: #example
Title: "CDA Example Peak Expiratory Flow Rate"
Description: "PEFR from the CDA clinical summary."
* insert AcsCdaVitalContext
* code = $LOINC#33452-4 "Maximum expiratory gas flow Respiratory system airway by Peak flow meter"
* valueQuantity = 92 'L/min'

// --- Patient history, current meds, allergies, and advice ------------
Instance: acs-cda-medical-history
InstanceOf: AcsPastMedicalHistory
Usage: #example
Title: "CDA Example Past Medical History"
Description: "Medical history notes from the CDA medical history section."
* category = $cond-category#problem-list-item
* subject = Reference(acs-cda-patient-bob)
* code.text = "Medical history notes"
* note.text = "Medical history notes line 1\nMedical history notes line 2\nMedical history notes line 3"

Instance: acs-cda-current-medications
InstanceOf: AcsCurrentMedication
Usage: #example
Title: "CDA Example Current Medications"
Description: "Self-reported medication notes from the CDA medical history section."
* status = #active
* medicationCodeableConcept.text = "Ventolin, ipratropium"
* subject = Reference(acs-cda-patient-bob)
* informationSource = Reference(acs-cda-patient-bob)

Instance: acs-cda-allergy-nka
InstanceOf: AcsAllergyIntolerance
Usage: #example
Title: "CDA Example Allergy - NKA"
Description: "No known allergies from the CDA medical history section."
* clinicalStatus = $allerg-clinical#inactive
* code = $SCT#716186003 "No known allergy"
* patient = Reference(acs-cda-patient-bob)
* note.text = "NKA"

Instance: acs-cda-last-oral-intake
InstanceOf: AcsLastOralIntake
Usage: #example
Title: "CDA Example Last Oral Intake"
Description: "Last oral intake time and detail from the CDA medical history section."
* insert AcsCdaObservationContext
* code = $LOINC#67517-3 "Last oral intake"
* effectiveDateTime = "2016-06-14T11:00:00+12:00"
* valueDateTime = "2016-06-14T11:00:00+12:00"
* component[intakeDetail].code = AcsMetadataCS#last-oral-intake-detail "Last oral intake detail"
* component[intakeDetail].valueString = "Steak and cheese pie"

Instance: acs-cda-careplan
InstanceOf: AcsCarePlan
Usage: #example
Title: "CDA Example Care Plan"
Description: "Advice to patient and GP from the CDA advice and instructions section."
* status = #active
* intent = #plan
* subject = Reference(acs-cda-patient-bob)
* encounter = Reference(acs-cda-encounter)
* description = "Per asthma leaflet\nRecommend ask Housing NZ to remove privet bush"
* note.text = "Pt states stressors at home which seem to precipitate asthma attacks\nAlso note flowering privet bush outside front door see photo"

Instance: acs-cda-referral-gp
InstanceOf: AcsReferral
Usage: #example
Title: "CDA Example Referral - GP Surgery Appointment"
Description: "Referral pathway from the CDA incident history."
* status = #active
* intent = #order
* code = $SCT#183561008 "GP Surgery Appointment"
* subject = Reference(acs-cda-patient-bob)
* encounter = Reference(acs-cda-encounter)
* reasonCode.text = "Recommend GP appt to get more meds"

// --- Clinical, body, vehicle, and scene images -----------------------
RuleSet: AcsCdaImageCommon
* status = #completed
* type.text = "Image"
* subject = Reference(acs-cda-patient-bob)
* encounter = Reference(acs-cda-encounter)
* createdDateTime = "2016-06-14T11:13:00+12:00"
* operator = Reference(acs-cda-providerrole-josephine)
* content.contentType = #image/jpeg

Instance: acs-cda-image-vehicle
InstanceOf: AcsClinicalImage
Usage: #example
Title: "CDA Example Image - Vehicle Diagram"
Description: "Vehicle diagram referenced in the CDA complaint history."
* insert AcsCdaImageCommon
* content.url = "vehicle.jpg"
* note.text = "Vehicle diagram"

Instance: acs-cda-image-body-front
InstanceOf: AcsClinicalImage
Usage: #example
Title: "CDA Example Image - Body Diagram Front"
Description: "Front body diagram referenced in the CDA clinical impression section."
* insert AcsCdaImageCommon
* bodySite.text = "Body front"
* content.url = "body-front.jpg"
* note.text = "Body diagram (front)"

Instance: acs-cda-image-body-back
InstanceOf: AcsClinicalImage
Usage: #example
Title: "CDA Example Image - Body Diagram Back"
Description: "Back body diagram referenced in the CDA clinical impression section."
* insert AcsCdaImageCommon
* bodySite.text = "Body back"
* content.url = "body-back.jpg"
* note.text = "Body diagram (back)"

Instance: acs-cda-image-01
InstanceOf: AcsClinicalImage
Usage: #example
Title: "CDA Example Image - Photo 1"
Description: "Photo 1 from the CDA clinical images section."
* insert AcsCdaImageCommon
* content.url = "image-01.jpg"
* note.text = "Photo 1"

Instance: acs-cda-image-02
InstanceOf: AcsClinicalImage
Usage: #example
Title: "CDA Example Image - Photo 2"
Description: "Photo 2 from the CDA clinical images section."
* insert AcsCdaImageCommon
* content.url = "image-02.jpg"
* note.text = "Photo 2"

// --- Medications administered ---------------------------------------
Instance: acs-cda-med-adenosine
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Adenosine"
Description: "Adenosine administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#10018481000116100 "Adenosine"
* medicationCodeableConcept.text = "Adenosine"
* effectiveDateTime = "2016-06-14T11:01:00+12:00"
* dosage.route = AcsRouteCS#iv
* dosage.dose = 6 'mg'
* note.text = "A note about Adenosine"

Instance: acs-cda-med-adrenaline-bolus
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Adrenaline Bolus"
Description: "Adrenaline bolus administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#10077261000116100 "Adrenaline (bolus)"
* medicationCodeableConcept.text = "Adrenaline (bolus)"
* effectiveDateTime = "2016-06-14T11:02:00+12:00"
* dosage.route = AcsRouteCS#iv
* dosage.dose = 0.1 'mg'
* note.text = "A note about Adrenaline (bolus)"

Instance: acs-cda-med-adrenaline-infusion
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Adrenaline Infusion"
Description: "Adrenaline infusion administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#10077261000116100 "Adrenaline (infusion)"
* medicationCodeableConcept.text = "Adrenaline (infusion)"
* effectiveDateTime = "2016-06-14T11:03:00+12:00"
* dosage.route = AcsRouteCS#iv
* dosage.dose = 0.1 'mg'
* note.text = "A note about Adrenaline (infusion)"

Instance: acs-cda-med-adrenaline-neb
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Adrenaline NEB"
Description: "Nebulised adrenaline administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#10077261000116100 "Adrenaline (NEB)"
* medicationCodeableConcept.text = "Adrenaline (NEB)"
* effectiveDateTime = "2016-06-14T11:04:00+12:00"
* dosage.route = AcsRouteCS#nebuliser
* dosage.dose = 5 'mg'
* note.text = "A note about Adrenaline (NEB)"

Instance: acs-cda-med-adrenaline-im-in
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Adrenaline IM IN"
Description: "Adrenaline IM/IN administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#10077261000116100 "Adrenaline (IM, IN)"
* medicationCodeableConcept.text = "Adrenaline (IM, IN)"
* effectiveDateTime = "2016-06-14T11:05:00+12:00"
* dosage.route = AcsRouteCS#im
* dosage.dose = 0.3 'mg'
* note.text = "A note about Adrenaline (IM, IN)"

Instance: acs-cda-med-adrenaline-arrest
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Adrenaline IV for Arrest"
Description: "Adrenaline IV for arrest administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#10077261000116100 "Adrenaline (IV for arrest)"
* medicationCodeableConcept.text = "Adrenaline (IV for arrest)"
* effectiveDateTime = "2016-06-14T11:06:00+12:00"
* dosage.route = AcsRouteCS#iv
* dosage.dose = 1 'mg'
* note.text = "A note about Adrenaline (IV for arrest)"

Instance: acs-cda-med-amiodarone-arrest
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Amiodarone IV for Arrest"
Description: "Amiodarone IV for arrest administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#10039841000116100 "Amiodarone (IV for arrest)"
* medicationCodeableConcept.text = "Amiodarone (IV for arrest)"
* effectiveDateTime = "2016-06-14T11:07:00+12:00"
* dosage.route = AcsRouteCS#iv
* dosage.dose = 300 'mg'
* note.text = "A note about Amiodarone (IV for arrest)"

Instance: acs-cda-med-amiodarone-bolus
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Amiodarone Bolus"
Description: "Amiodarone bolus administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#10039841000116100 "Amiodarone (bolus)"
* medicationCodeableConcept.text = "Amiodarone (bolus)"
* effectiveDateTime = "2016-06-14T11:08:00+12:00"
* dosage.route = AcsRouteCS#iv
* dosage.dose = 300 'mg'
* note.text = "A note about Amiodarone (bolus)"

Instance: acs-cda-med-amiodarone-infusion
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Amiodarone Infusion"
Description: "Amiodarone infusion administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#10039841000116100 "Amiodarone (infusion)"
* medicationCodeableConcept.text = "Amiodarone (infusion)"
* effectiveDateTime = "2016-06-14T11:09:00+12:00"
* dosage.route = AcsRouteCS#iv
* dosage.dose = 300 'mg'
* note.text = "A note about Amiodarone (infusion)"

Instance: acs-cda-med-aspirin
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Aspirin"
Description: "Aspirin administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#10077721000116100 "Aspirin"
* medicationCodeableConcept.text = "Aspirin"
* effectiveDateTime = "2016-06-14T11:10:00+12:00"
* dosage.route = AcsRouteCS#oral
* dosage.dose = 300 'mg'
* note.text = "A note about Aspirin"

Instance: acs-cda-med-atropine
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Atropine"
Description: "Atropine administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#10080811000116100 "Atropine"
* medicationCodeableConcept.text = "Atropine"
* effectiveDateTime = "2016-06-14T11:11:00+12:00"
* dosage.route = AcsRouteCS#iv
* dosage.dose = 0.6 'mg'
* note.text = "A note about Atropine"

Instance: acs-cda-med-calcium-chloride
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Calcium Chloride"
Description: "Calcium chloride administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#20075381000116100 "Calcium chloride"
* medicationCodeableConcept.text = "Calcium chloride"
* effectiveDateTime = "2016-06-14T11:12:00+12:00"
* dosage.route = AcsRouteCS#iv
* dosage.dose = 1 'g'
* note.text = "A note about Calcium chloride"

Instance: acs-cda-med-ceftriaxone
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Ceftriaxone"
Description: "Ceftriaxone administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#50085551000117100 "Ceftriaxone"
* medicationCodeableConcept.text = "Ceftriaxone"
* effectiveDateTime = "2016-06-14T11:13:00+12:00"
* dosage.route = AcsRouteCS#iv
* dosage.dose = 2 'g'
* note.text = "A note about Ceftriaxone"

Instance: acs-cda-med-clopidogrel
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Clopidogrel"
Description: "Clopidogrel administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#10050681000116100 "Clopidogrel"
* medicationCodeableConcept.text = "Clopidogrel"
* effectiveDateTime = "2016-06-14T11:14:00+12:00"
* dosage.route = AcsRouteCS#oral
* dosage.dose = 600 'mg'
* note.text = "A note about Clopidogrel"

Instance: acs-cda-med-entonox
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Entonox"
Description: "Entonox PRN administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#50152261000117100 "Entonox"
* medicationCodeableConcept.text = "Entonox"
* effectiveDateTime = "2016-06-14T11:15:00+12:00"
* dosage.route = AcsRouteCS#inhalation
* dosage.dose = 1 '{dose}'
* extension[administeredPrn].valueBoolean = true
* note.text = "A note about Entonox"

Instance: acs-cda-med-fentanyl
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Fentanyl"
Description: "Fentanyl administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#10200041000116100 "Fentanyl"
* medicationCodeableConcept.text = "Fentanyl"
* effectiveDateTime = "2016-06-14T11:16:00+12:00"
* dosage.route = AcsRouteCS#subcut
* dosage.dose = 10 'mcg'
* note.text = "A note about Fentanyl"

Instance: acs-cda-med-glucagon
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Glucagon"
Description: "Glucagon administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#10305571000116100 "Glucagon"
* medicationCodeableConcept.text = "Glucagon"
* effectiveDateTime = "2016-06-14T11:17:00+12:00"
* dosage.route = AcsRouteCS#im
* dosage.dose = 1 'mg'
* note.text = "A note about Glucagon"

Instance: acs-cda-med-oral-glucose
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Oral Glucose"
Description: "Oral glucose sachet administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#10306431000116100 "Oral Glucose (sachet)"
* medicationCodeableConcept.text = "Oral Glucose (sachet)"
* effectiveDateTime = "2016-06-14T11:18:00+12:00"
* dosage.route = AcsRouteCS#oral
* dosage.dose = 10 'g'
* note.text = "A note about Oral Glucose (sachet)"

Instance: acs-cda-med-glucose-10-percent
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - 10 percent Glucose"
Description: "10 percent glucose administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#20020091000116100 "10% Glucose"
* medicationCodeableConcept.text = "10% Glucose"
* effectiveDateTime = "2016-06-14T11:19:00+12:00"
* dosage.route = AcsRouteCS#iv
* dosage.dose = 100 'mL'
* note.text = "A note about 10% Glucose"

Instance: acs-cda-med-gtn
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - GTN"
Description: "GTN administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#10311771000116100 "GTN"
* medicationCodeableConcept.text = "GTN"
* effectiveDateTime = "2016-06-14T11:20:00+12:00"
* dosage.route = AcsRouteCS#sublingual
* dosage.dose = 0.4 'mg'
* note.text = "A note about GTN"

Instance: acs-cda-med-ibuprofen
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Ibuprofen"
Description: "Ibuprofen administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#10013271000116100 "Ibuprofen"
* medicationCodeableConcept.text = "Ibuprofen"
* effectiveDateTime = "2016-06-14T11:21:00+12:00"
* dosage.route = AcsRouteCS#oral
* dosage.dose = 400 'mg'
* note.text = "A note about Ibuprofen"

Instance: acs-cda-med-ipratropium-neb
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Ipratropium"
Description: "Nebulised ipratropium administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#10081781000116100 "Ipratropium"
* medicationCodeableConcept.text = "Ipratropium"
* effectiveDateTime = "2016-06-14T11:22:00+12:00"
* dosage.route = AcsRouteCS#nebuliser
* dosage.dose = 500 'mcg'
* note.text = "A note about Ipratropium"

Instance: acs-cda-med-ipratropium-mdi
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Ipratropium MDI"
Description: "Ipratropium MDI administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#10082091000116100 "Ipratropium (MDI)"
* medicationCodeableConcept.text = "Ipratropium (MDI)"
* effectiveDateTime = "2016-06-14T11:23:00+12:00"
* dosage.route = AcsRouteCS#inhalation
* dosage.dose = 1 '{puff}'
* note.text = "A note about Ipratropium (MDI)"

Instance: acs-cda-med-ketamine
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Ketamine"
Description: "Ketamine administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#10385011000116100 "Ketamine"
* medicationCodeableConcept.text = "Ketamine"
* effectiveDateTime = "2016-06-14T11:24:00+12:00"
* dosage.route = AcsRouteCS#iv
* dosage.dose = 10 'mg'
* note.text = "A note about Ketamine"

Instance: acs-cda-med-lignocaine
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Lignocaine"
Description: "Lignocaine administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#10465961000116100 "Lignocaine"
* medicationCodeableConcept.text = "Lignocaine"
* effectiveDateTime = "2016-06-14T11:25:00+12:00"
* dosage.route = AcsRouteCS#subcut
* dosage.dose = 1 'mL'
* note.text = "A note about Lignocaine"

Instance: acs-cda-med-lignocaine-ring-block
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Lignocaine Ring Block"
Description: "Lignocaine for ring block administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#10465961000116100 "Lignocaine (SC for ring block)"
* medicationCodeableConcept.text = "Lignocaine (SC for ring block)"
* effectiveDateTime = "2016-06-14T11:26:00+12:00"
* dosage.route = AcsRouteCS#subcut
* dosage.dose = 1 'mL'
* note.text = "A note about Lignocaine (SC for ring block)"

Instance: acs-cda-med-lignocaine-cannulation
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Lignocaine Cannulation"
Description: "Lignocaine for cannulation administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#10465961000116100 "Lignocaine (SC for cannulation)"
* medicationCodeableConcept.text = "Lignocaine (SC for cannulation)"
* effectiveDateTime = "2016-06-14T11:27:00+12:00"
* dosage.route = AcsRouteCS#subcut
* dosage.dose = 0.1 'mL'
* note.text = "A note about Lignocaine (SC for cannulation)"

Instance: acs-cda-med-loratadine
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Loratadine"
Description: "Loratadine administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#44423041000116100 "Loratadine"
* medicationCodeableConcept.text = "Loratadine"
* effectiveDateTime = "2016-06-14T11:28:00+12:00"
* dosage.route = AcsRouteCS#oral
* dosage.dose = 10 'mg'
* note.text = "A note about Loratadine"

Instance: acs-cda-med-methoxyflurane
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Methoxyflurane"
Description: "Methoxyflurane administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#10535011000116100 "Methoxyflurane"
* medicationCodeableConcept.text = "Methoxyflurane"
* effectiveDateTime = "2016-06-14T11:29:00+12:00"
* dosage.route = AcsRouteCS#inhalation
* dosage.dose = 3 'mL'
* note.text = "A note about Methoxyflurane"

Instance: acs-cda-med-midazolam-im
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Midazolam IM"
Description: "Midazolam IM administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#10369851000116100 "Midazolam (IM)"
* medicationCodeableConcept.text = "Midazolam (IM)"
* effectiveDateTime = "2016-06-14T11:30:00+12:00"
* dosage.route = AcsRouteCS#im
* dosage.dose = 5 'mg'
* note.text = "A note about Midazolam (IM)"

Instance: acs-cda-med-midazolam-iv
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Midazolam IV"
Description: "Midazolam IV administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#10370021000116100 "Midazolam"
* medicationCodeableConcept.text = "Midazolam"
* effectiveDateTime = "2016-06-14T11:31:00+12:00"
* dosage.route = AcsRouteCS#iv
* dosage.dose = 0.5 'mg'
* note.text = "A note about Midazolam"

Instance: acs-cda-med-morphine
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Morphine"
Description: "Morphine administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#10446531000116100 "Morphine"
* medicationCodeableConcept.text = "Morphine"
* effectiveDateTime = "2016-06-14T11:32:00+12:00"
* dosage.route = AcsRouteCS#iv
* dosage.dose = 1 'mg'
* note.text = "A note about Morphine"

Instance: acs-cda-med-naloxone
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Naloxone"
Description: "Naloxone administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#24308091000116100 "Naloxone"
* medicationCodeableConcept.text = "Naloxone"
* effectiveDateTime = "2016-06-14T11:33:00+12:00"
* dosage.route = AcsRouteCS#iv
* dosage.dose = 0.1 'mg'
* note.text = "A note about Naloxone"

Instance: acs-cda-med-ondansetron-injection
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Ondansetron Injection"
Description: "Ondansetron injection administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#20041441000116100 "Ondansetron (injection)"
* medicationCodeableConcept.text = "Ondansetron (injection)"
* effectiveDateTime = "2016-06-14T11:34:00+12:00"
* dosage.route = AcsRouteCS#iv
* dosage.dose = 4 'mg'
* note.text = "A note about Ondansetron (injection)"

Instance: acs-cda-med-ondansetron-wafer
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Ondansetron Wafer"
Description: "Ondansetron wafer administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#10754891000116100 "Ondansetron (wafer)"
* medicationCodeableConcept.text = "Ondansetron (wafer)"
* effectiveDateTime = "2016-06-14T11:35:00+12:00"
* dosage.route = AcsRouteCS#oral
* dosage.dose = 4 'mg'
* note.text = "A note about Ondansetron (wafer)"

Instance: acs-cda-med-other-quinapril
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Other Quinapril"
Description: "Other patient-owned medication noted in the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept.text = "Other (specify in Notes)"
* effectiveDateTime = "2016-06-14T11:36:00+12:00"
* dosage.route = AcsRouteCS#oral
* dosage.dose = 12.5 'mg'
* note.text = "Patients own Quinapril"

Instance: acs-cda-med-oxygen
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Oxygen"
Description: "Oxygen administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#44748921000116100 "Oxygen"
* medicationCodeableConcept.text = "Oxygen"
* effectiveDateTime = "2016-06-14T11:37:00+12:00"
* dosage.route = AcsRouteCS#inhalation
* dosage.dose = 1 'L/min'
* note.text = "A note about Oxygen"

Instance: acs-cda-med-oxytocin
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Oxytocin"
Description: "Oxytocin administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#10704091000116100 "Oxytocin"
* medicationCodeableConcept.text = "Oxytocin"
* effectiveDateTime = "2016-06-14T11:38:00+12:00"
* dosage.route = AcsRouteCS#im
* dosage.dose = 5 '[iU]'
* note.text = "A note about Oxytocin"

Instance: acs-cda-med-paracetamol-tablet
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Paracetamol Tablet"
Description: "Paracetamol tablet administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#10037311000116100 "Paracetamol (tablet)"
* medicationCodeableConcept.text = "Paracetamol (tablet)"
* effectiveDateTime = "2016-06-14T11:39:00+12:00"
* dosage.route = AcsRouteCS#oral
* dosage.dose = 1000 'mg'
* note.text = "A note about Paracetamol (tablet)"

Instance: acs-cda-med-paracetamol-syrup
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Paracetamol Syrup"
Description: "Paracetamol syrup administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#10037431000116100 "Paracetamol (syrup)"
* medicationCodeableConcept.text = "Paracetamol (syrup)"
* effectiveDateTime = "2016-06-14T11:40:00+12:00"
* dosage.route = AcsRouteCS#oral
* dosage.dose = 1000 'mg'
* note.text = "A note about Paracetamol (syrup)"

Instance: acs-cda-med-prednisone
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Prednisone"
Description: "Prednisone administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#10060531000116100 "Prednisone"
* medicationCodeableConcept.text = "Prednisone"
* effectiveDateTime = "2016-06-14T11:41:00+12:00"
* dosage.route = AcsRouteCS#oral
* dosage.dose = 40 'mg'
* note.text = "A note about Prednisone"

Instance: acs-cda-med-rocuronium
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Rocuronium"
Description: "Rocuronium administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#10268791000116100 "Rocuronium"
* medicationCodeableConcept.text = "Rocuronium"
* effectiveDateTime = "2016-06-14T11:42:00+12:00"
* dosage.route = AcsRouteCS#iv
* dosage.dose = 50 'mg'
* note.text = "A note about Rocuronium"

Instance: acs-cda-med-salbutamol-neb
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Salbutamol"
Description: "Nebulised salbutamol administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#20009521000116100 "Salbutamol"
* medicationCodeableConcept.text = "Salbutamol"
* effectiveDateTime = "2016-06-14T11:43:00+12:00"
* dosage.route = AcsRouteCS#nebuliser
* dosage.dose = 5 'mg'
* note.text = "A note about Salbutamol"

Instance: acs-cda-med-salbutamol-mdi
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Salbutamol MDI"
Description: "Salbutamol MDI administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#10619771000116100 "Salbutamol (MDI)"
* medicationCodeableConcept.text = "Salbutamol (MDI)"
* effectiveDateTime = "2016-06-14T11:44:00+12:00"
* dosage.route = AcsRouteCS#inhalation
* dosage.dose = 1 '{puff}'
* note.text = "A note about Salbutamol (MDI)"

Instance: acs-cda-med-salbutamol-ipratropium-mdi
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Salbutamol plus Ipratropium MDI"
Description: "Salbutamol plus ipratropium MDI administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#10175721000116100 "Salbutamol + Ipratropium MDI"
* medicationCodeableConcept.text = "Salbutamol + Ipratropium MDI"
* effectiveDateTime = "2016-06-14T11:45:00+12:00"
* dosage.route = AcsRouteCS#inhalation
* dosage.dose = 1 '{puff}'
* note.text = "A note about Salbutamol + Ipratropium MDI"

Instance: acs-cda-med-sodium-bicarbonate
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Sodium Bicarbonate"
Description: "Sodium bicarbonate administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#26666421000116100 "Sodium bicarbonate"
* medicationCodeableConcept.text = "Sodium bicarbonate"
* effectiveDateTime = "2016-06-14T11:46:00+12:00"
* dosage.route = AcsRouteCS#iv
* dosage.dose = 100 'mL'
* note.text = "A note about Sodium bicarbonate"

Instance: acs-cda-med-sodium-chloride
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - 0.9 percent Sodium Chloride"
Description: "0.9 percent sodium chloride administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#20053941000116100 "0.9% Sodium chloride"
* medicationCodeableConcept.text = "0.9% Sodium chloride"
* effectiveDateTime = "2016-06-14T11:47:00+12:00"
* dosage.route = AcsRouteCS#iv
* dosage.dose = 50 'mL'
* note.text = "A note about 0.9% Sodium chloride"

Instance: acs-cda-med-suxamethonium
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Suxamethonium"
Description: "Suxamethonium administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#10277071000116100 "Suxamethonium"
* medicationCodeableConcept.text = "Suxamethonium"
* effectiveDateTime = "2016-06-14T11:48:00+12:00"
* dosage.route = AcsRouteCS#iv
* dosage.dose = 100 'mg'
* note.text = "A note about Suxamethonium"

Instance: acs-cda-med-tramadol
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "CDA Example Medication - Tramadol"
Description: "Tramadol administration from the CDA clinical summary."
* insert AcsCdaMedicationCommon
* medicationCodeableConcept = $NZMT#10713471000116100 "Tramadol"
* medicationCodeableConcept.text = "Tramadol"
* effectiveDateTime = "2016-06-14T11:49:00+12:00"
* dosage.route = AcsRouteCS#oral
* dosage.dose = 50 'mg'
* note.text = "A note about Tramadol"

// --- Procedures / interventions -------------------------------------
Instance: acs-cda-proc-airway-manual-clear
InstanceOf: AcsProcedure
Usage: #example
Title: "CDA Example Procedure - Airway Management Manual Clear"
Description: "Airway management manual clear from the CDA clinical summary."
* insert AcsCdaProcedureCommon
* code = $SCT#232664002 "Airway Management Manual Clear"
* performedDateTime = "2016-06-14T11:52:00+12:00"
* note.text = "A note about Manual Clear"

Instance: acs-cda-proc-airway-suction
InstanceOf: AcsProcedure
Usage: #example
Title: "CDA Example Procedure - Airway Management Suction"
Description: "Airway suction from the CDA clinical summary."
* insert AcsCdaProcedureCommon
* code = $SCT#230040009 "Airway Management Suction"
* performedDateTime = "2016-06-14T11:53:00+12:00"
* note.text = "A note about Suction"

Instance: acs-cda-proc-airway-opa
InstanceOf: AcsProcedure
Usage: #example
Title: "CDA Example Procedure - Airway Management OPA"
Description: "OPA airway management from the CDA clinical summary."
* insert AcsCdaProcedureCommon
* code = $SCT#7443007 "Airway Management OPA"
* performedDateTime = "2016-06-14T11:54:00+12:00"
* outcome = $SCT#385671000 "Unsuccessful"
* note.text = "A note about OPA"

Instance: acs-cda-proc-airway-npa
InstanceOf: AcsProcedure
Usage: #example
Title: "CDA Example Procedure - Airway Management NPA"
Description: "NPA airway management from the CDA clinical summary."
* insert AcsCdaProcedureCommon
* code = $SCT#182692007 "Airway Management NPA"
* performedDateTime = "2016-06-14T11:55:00+12:00"
* outcome = $SCT#385671000 "Unsuccessful"
* note.text = "A note about NPA"

Instance: acs-cda-proc-airway-lma
InstanceOf: AcsProcedure
Usage: #example
Title: "CDA Example Procedure - Airway Management LMA"
Description: "LMA airway management from the CDA clinical summary."
* insert AcsCdaProcedureCommon
* code = $SCT#418613003 "Airway Management LMA"
* performedDateTime = "2016-06-14T11:56:00+12:00"
* outcome = $SCT#385671000 "Unsuccessful"
* note.text = "A note about LMA"

Instance: acs-cda-proc-airway-intubation
InstanceOf: AcsProcedure
Usage: #example
Title: "CDA Example Procedure - Airway Management Intubation"
Description: "Intubation airway management from the CDA clinical summary."
* insert AcsCdaProcedureCommon
* code = $SCT#112798008 "Airway Management Intubation"
* performedDateTime = "2016-06-14T11:57:00+12:00"
* outcome = $SCT#385671000 "Unsuccessful"
* note.text = "A note about Intubation"

Instance: acs-cda-proc-airway-cricothyroidotomy
InstanceOf: AcsProcedure
Usage: #example
Title: "CDA Example Procedure - Airway Management Cricothyroidotomy"
Description: "Cricothyroidotomy airway management from the CDA clinical summary."
* insert AcsCdaProcedureCommon
* code = $SCT#173067007 "Airway Management Cricothyroidotomy"
* performedDateTime = "2016-06-14T11:58:00+12:00"
* outcome = $SCT#385671000 "Unsuccessful"
* note.text = "A note about Cricothyroidotomy"

Instance: acs-cda-proc-airway-laryngoscopy
InstanceOf: AcsProcedure
Usage: #example
Title: "CDA Example Procedure - Airway Management Laryngoscopy"
Description: "Laryngoscopy airway management from the CDA clinical summary."
* insert AcsCdaProcedureCommon
* code = $SCT#28760000 "Airway Management Laryngoscopy"
* performedDateTime = "2016-06-14T11:59:00+12:00"
* outcome = $SCT#385671000 "Unsuccessful"
* note.text = "A note about Laryngoscopy"

Instance: acs-cda-proc-airway-other-device
InstanceOf: AcsProcedure
Usage: #example
Title: "CDA Example Procedure - Airway Management Other Device"
Description: "Other airway device intervention from the CDA clinical summary."
* insert AcsCdaProcedureCommon
* code = $SCT#397982008 "Airway Management Other Device"
* performedDateTime = "2016-06-14T12:00:00+12:00"
* note.text = "A note about Other Device"

Instance: acs-cda-proc-ventilation-manual
InstanceOf: AcsProcedure
Usage: #example
Title: "CDA Example Procedure - Ventilation Manual"
Description: "Manual ventilation from the CDA narrative clinical summary."
* insert AcsCdaProcedureCommon
* code.text = "Ventilation (Manual)"
* performedDateTime = "2016-06-14T12:01:00+12:00"
* note.text = "A note about Ventilation"

Instance: acs-cda-proc-cardioversion
InstanceOf: AcsProcedure
Usage: #example
Title: "CDA Example Procedure - Cardioversion"
Description: "Cardioversion from the CDA clinical summary."
* insert AcsCdaProcedureCommon
* code = $SCT#250980009 "Cardioversion"
* performedDateTime = "2016-06-14T12:01:00+12:00"
* note.text = "A note about Cardioversion; energy 360 J in the CDA structured entry. The CDA summary table also displays Cardioversion 25J at 12:07."

Instance: acs-cda-proc-catheter-troubleshooting
InstanceOf: AcsProcedure
Usage: #example
Title: "CDA Example Procedure - Catheter Troubleshooting"
Description: "Catheter troubleshooting from the CDA clinical summary."
* insert AcsCdaProcedureCommon
* code = $SCT#410253009 "Catheter troubleshooting"
* performedDateTime = "2016-06-14T12:02:00+12:00"
* outcome = $SCT#385671000 "Unsuccessful"
* note.text = "A note about Catheter troubleshooting"

Instance: acs-cda-proc-chest-decompression
InstanceOf: AcsProcedure
Usage: #example
Title: "CDA Example Procedure - Chest Decompression"
Description: "Chest decompression from the CDA clinical summary."
* insert AcsCdaProcedureCommon
* code = $SCT#367408005 "Chest decompression"
* performedDateTime = "2016-06-14T12:03:00+12:00"
* bodySite = $SCT#243939008 "Second intercostal space"
* bodySite.text = "Right second intercostal, midclavicular"
* outcome = $SCT#385671000 "Unsuccessful"
* note.text = "A note about Chest decompression"

Instance: acs-cda-proc-cpap
InstanceOf: AcsProcedure
Usage: #example
Title: "CDA Example Procedure - CPAP"
Description: "CPAP from the CDA narrative clinical summary."
* insert AcsCdaProcedureCommon
* code.text = "CPAP (5 cmH2O)"
* performedDateTime = "2016-06-14T12:03:00+12:00"
* note.text = "A note about CPAP"

Instance: acs-cda-proc-cpr
InstanceOf: AcsProcedure
Usage: #example
Title: "CDA Example Procedure - CPR"
Description: "CPR from the CDA clinical summary."
* insert AcsCdaProcedureCommon
* code = $SCT#89666000 "CPR"
* performedDateTime = "2016-06-14T12:03:00+12:00"
* note.text = "A note about CPR"

Instance: acs-cda-proc-defibrillation
InstanceOf: AcsProcedure
Usage: #example
Title: "CDA Example Procedure - Defibrillation"
Description: "Defibrillation from the CDA clinical summary."
* insert AcsCdaProcedureCommon
* code = $SCT#308842001 "Defibrillation"
* performedDateTime = "2016-06-14T12:05:00+12:00"
* note.text = "A note about Defibrillation; energy 360 J; professional defibrillator monitor."

Instance: acs-cda-proc-defibrillation-aed
InstanceOf: AcsProcedure
Usage: #example
Title: "CDA Example Procedure - Defibrillation AED"
Description: "AED defibrillation from the CDA clinical summary."
* insert AcsCdaProcedureCommon
* code = $SCT#308842001 "Defibrillation AED"
* performedDateTime = "2016-06-14T12:06:00+12:00"
* note.text = "A note about Defibrillation AED; method AED."

Instance: acs-cda-proc-io-insertion
InstanceOf: AcsProcedure
Usage: #example
Title: "CDA Example Procedure - IO Insertion"
Description: "IO insertion from the CDA clinical summary."
* insert AcsCdaProcedureCommon
* code = $SCT#430824005 "IO insertion"
* performedDateTime = "2016-06-14T12:07:00+12:00"
* bodySite.text = "Left tibial"
* outcome = $SCT#385671000 "Unsuccessful"
* note.text = "A note about IO insertion"

Instance: acs-cda-proc-iv-insertion
InstanceOf: AcsProcedure
Usage: #example
Title: "CDA Example Procedure - IV Insertion"
Description: "IV insertion from the CDA clinical summary."
* insert AcsCdaProcedureCommon
* code = $SCT#392231009 "IV insertion"
* performedDateTime = "2016-06-14T12:08:00+12:00"
* bodySite.text = "Right forearm"
* outcome = $SCT#385671000 "Unsuccessful"
* note.text = "A note about IV insertion"

Instance: acs-cda-proc-valsalva
InstanceOf: AcsProcedure
Usage: #example
Title: "CDA Example Procedure - Valsalva"
Description: "Valsalva intervention from the CDA narrative clinical summary."
* insert AcsCdaProcedureCommon
* code.text = "Valsalva"
* performedDateTime = "2016-06-14T12:09:00+12:00"
* note.text = "A note about Valsalva"

Instance: acs-cda-proc-limb-reduction-wrist
InstanceOf: AcsProcedure
Usage: #example
Title: "CDA Example Procedure - Limb Reduction Wrist"
Description: "Wrist limb reduction from the CDA clinical summary."
* insert AcsCdaProcedureCommon
* code = $SCT#430296009 "Limb reduction Wrist"
* performedDateTime = "2016-06-14T12:09:00+12:00"
* bodySite.text = "Left wrist"
* outcome = $SCT#385671000 "Unsuccessful"
* note.text = "A note about Limb reduction Wrist"

Instance: acs-cda-proc-limb-reduction-elbow
InstanceOf: AcsProcedure
Usage: #example
Title: "CDA Example Procedure - Limb Reduction Elbow"
Description: "Elbow limb reduction from the CDA clinical summary."
* insert AcsCdaProcedureCommon
* code = $SCT#430184005 "Limb reduction Elbow"
* performedDateTime = "2016-06-14T12:10:00+12:00"
* bodySite.text = "Right elbow"
* outcome = $SCT#385671000 "Unsuccessful"
* note.text = "A note about Limb reduction Elbow"

Instance: acs-cda-proc-limb-reduction-shoulder
InstanceOf: AcsProcedure
Usage: #example
Title: "CDA Example Procedure - Limb Reduction Shoulder"
Description: "Shoulder limb reduction from the CDA clinical summary."
* insert AcsCdaProcedureCommon
* code = $SCT#274450004 "Limb reduction Shoulder"
* performedDateTime = "2016-06-14T12:11:00+12:00"
* bodySite.text = "Left shoulder"
* outcome = $SCT#385671000 "Unsuccessful"
* note.text = "A note about Limb reduction Shoulder"

Instance: acs-cda-proc-limb-reduction-ankle
InstanceOf: AcsProcedure
Usage: #example
Title: "CDA Example Procedure - Limb Reduction Ankle"
Description: "Ankle limb reduction from the CDA clinical summary."
* insert AcsCdaProcedureCommon
* code = $SCT#274457001 "Limb reduction Ankle"
* performedDateTime = "2016-06-14T12:12:00+12:00"
* bodySite.text = "Right ankle"
* outcome = $SCT#385671000 "Unsuccessful"
* note.text = "A note about Limb reduction Ankle"

Instance: acs-cda-proc-limb-reduction-other
InstanceOf: AcsProcedure
Usage: #example
Title: "CDA Example Procedure - Limb Reduction Other"
Description: "Other limb reduction from the CDA clinical summary."
* insert AcsCdaProcedureCommon
* code = $SCT#287635001 "Limb reduction Other"
* performedDateTime = "2016-06-14T12:13:00+12:00"
* outcome = $SCT#385671000 "Unsuccessful"
* note.text = "A note about Limb reduction Other"

Instance: acs-cda-proc-pacing
InstanceOf: AcsProcedure
Usage: #example
Title: "CDA Example Procedure - Pacing"
Description: "Pacing from the CDA clinical summary."
* insert AcsCdaProcedureCommon
* code = $SCT#18590009 "Pacing"
* performedDateTime = "2016-06-14T12:14:00+12:00"
* outcome = $SCT#385671000 "Unsuccessful"
* note.text = "A note about Pacing"

Instance: acs-cda-proc-peep
InstanceOf: AcsProcedure
Usage: #example
Title: "CDA Example Procedure - PEEP"
Description: "PEEP from the CDA clinical summary."
* insert AcsCdaProcedureCommon
* code = $SCT#243164007 "PEEP"
* performedDateTime = "2016-06-14T12:15:00+12:00"
* note.text = "A note about PEEP; valve size 5. The CDA summary table displayed this at 12:02."

Instance: acs-cda-proc-position-recovery
InstanceOf: AcsProcedure
Usage: #example
Title: "CDA Example Procedure - Recovery Position"
Description: "Recovery positioning from the CDA clinical summary."
* insert AcsCdaProcedureCommon
* code = $SCT#444679006 "Recovery position"
* performedDateTime = "2016-06-14T12:16:00+12:00"
* note.text = "A note about Positioning Recovery"

Instance: acs-cda-proc-position-supine
InstanceOf: AcsProcedure
Usage: #example
Title: "CDA Example Procedure - Supine Position"
Description: "Supine positioning from the CDA clinical summary."
* insert AcsCdaProcedureCommon
* code = $SCT#229824005 "Supine position"
* performedDateTime = "2016-06-14T12:17:00+12:00"
* note.text = "A note about Positioning Supine"

Instance: acs-cda-proc-position-seated
InstanceOf: AcsProcedure
Usage: #example
Title: "CDA Example Procedure - Seated Position"
Description: "Seated positioning from the CDA clinical summary."
* insert AcsCdaProcedureCommon
* code = $SCT#59408004 "Seated position"
* performedDateTime = "2016-06-14T12:18:00+12:00"
* note.text = "A note about Positioning Seated"

Instance: acs-cda-proc-position-lateral
InstanceOf: AcsProcedure
Usage: #example
Title: "CDA Example Procedure - Lateral Position"
Description: "Lateral positioning from the CDA clinical summary."
* insert AcsCdaProcedureCommon
* code = $SCT#229824005 "Lateral position"
* performedDateTime = "2016-06-14T12:19:00+12:00"
* note.text = "A note about Positioning Lateral"

Instance: acs-cda-proc-position-semi-recumbent
InstanceOf: AcsProcedure
Usage: #example
Title: "CDA Example Procedure - Semi-recumbent Position"
Description: "Semi-recumbent positioning from the CDA clinical summary."
* insert AcsCdaProcedureCommon
* code = $SCT#225994009 "Semi-recumbent position"
* performedDateTime = "2016-06-14T12:20:00+12:00"
* note.text = "A note about Positioning Semi-recumbent"

Instance: acs-cda-proc-position-prone
InstanceOf: AcsProcedure
Usage: #example
Title: "CDA Example Procedure - Prone Position"
Description: "Prone positioning from the CDA clinical summary."
* insert AcsCdaProcedureCommon
* code = $SCT#431182000 "Prone position"
* performedDateTime = "2016-06-14T12:21:00+12:00"
* note.text = "A note about Positioning Prone"

Instance: acs-cda-proc-position-other
InstanceOf: AcsProcedure
Usage: #example
Title: "CDA Example Procedure - Other Positioning"
Description: "Other positioning from the CDA clinical summary."
* insert AcsCdaProcedureCommon
* code = $SCT#229824005 "Other positioning"
* performedDateTime = "2016-06-14T12:22:00+12:00"
* note.text = "A note about Positioning Other"

Instance: acs-cda-proc-rsi
InstanceOf: AcsProcedure
Usage: #example
Title: "CDA Example Procedure - RSI"
Description: "Rapid sequence induction from the CDA clinical summary."
* insert AcsCdaProcedureCommon
* code = $SCT#241689008 "RSI"
* performedDateTime = "2016-06-14T12:23:00+12:00"
* outcome = $SCT#385671000 "Unsuccessful"
* note.text = "A note about RSI. The CDA summary table displayed RSI at 12:04."

Instance: acs-cda-proc-splint-dressing
InstanceOf: AcsProcedure
Usage: #example
Title: "CDA Example Procedure - Splint Dressing"
Description: "Splint/dressing intervention from the CDA clinical summary."
* insert AcsCdaProcedureCommon
* code = $SCT#79321009 "Splint/dressing"
* performedDateTime = "2016-06-14T12:24:00+12:00"
* note.text = "A note about Splint/dressing"

Instance: acs-cda-proc-stomach-decompression
InstanceOf: AcsProcedure
Usage: #example
Title: "CDA Example Procedure - Stomach Decompression"
Description: "Stomach decompression from the CDA clinical summary."
* insert AcsCdaProcedureCommon
* code = $SCT#182515004 "Stomach decompression"
* performedDateTime = "2016-06-14T12:25:00+12:00"
* outcome = $SCT#385671000 "Unsuccessful"
* note.text = "A note about Stomach decompression"

Instance: acs-cda-proc-tourniquet
InstanceOf: AcsProcedure
Usage: #example
Title: "CDA Example Procedure - Tourniquet"
Description: "Tourniquet intervention from the CDA clinical summary."
* insert AcsCdaProcedureCommon
* code = $SCT#20655006 "Tourniquet"
* performedDateTime = "2016-06-14T12:26:00+12:00"
* bodySite.text = "Leg"
* outcome = $SCT#385671000 "Unsuccessful"
* note.text = "A note about Tourniquet"

// --- Complete CDA-derived Composition -------------------------------
Instance: acs-cda-composition
InstanceOf: AmbulanceCareSummaryComposition
Usage: #example
Title: "CDA Complete Ambulance Care Summary Composition"
Description: "Composition for a fuller FHIR recreation of the CDA ambulance care summary example."
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h2>Ambulance Care Summary - CDA complete recreation</h2><table><tbody><tr><th>Document identifier</th><td>1453821363387010</td></tr><tr><th>Status</th><td>Final</td></tr><tr><th>Type</th><td>Ambulance Care Summary (LOINC 74207-2)</td></tr><tr><th>Document date</th><td>2019-09-10 11:12 +12:00</td></tr><tr><th>Patient</th><td>Mr Bob Bobby Bobson; NHI ABC1235</td></tr><tr><th>Date of birth</th><td>1984-06-02</td></tr><tr><th>Gender / sex at birth</th><td>Male / Male</td></tr><tr><th>Patient contact details</th><td>(03) 444 7890 home; (03) 444 7654 work; (027) 7878 7878 mobile; bob@bobson.org.nz</td></tr><tr><th>Patient address</th><td>Bobs Big Building, 17 Bobson Boulevard, Baldrick, Boganville 6789, New Zealand</td></tr><tr><th>Encounter</th><td>0450-1-2016/06/14, 2016-06-14 11:13 to 12:42 +12:00</td></tr><tr><th>Author</th><td>Josephine Manu-Bloggs, Order of St John</td></tr><tr><th>Attending officers</th><td>Josephine Manu-Bloggs (100901); Bob (600821)</td></tr><tr><th>Custodian</th><td>Order of St John, HPI Organization G02780-A</td></tr><tr><th>Legal authenticator</th><td>Dr Rex Anthony Smith, HPI CPN 17AHVX, signed 2019-09-10 12:13 +12:00</td></tr><tr><th>Destination</th><td>Sunshine Hospital Emergency Department</td></tr></tbody></table></div>"
* identifier.system = "https://standards.digital.health.nz/ns/ambulance-care-summary-id"
* identifier.value = "1453821363387010"
* status = #final
* type = $LOINC#74207-2 "Ambulance Care Summary"
* subject = Reference(acs-cda-patient-bob)
* encounter = Reference(acs-cda-encounter)
* date = "2019-09-10T11:12:00+12:00"
* author = Reference(acs-cda-providerrole-josephine)
* title = "Ambulance Care Summary"
* custodian = Reference(acs-cda-org-stjohn)
* attester.mode = #legal
* attester.time = "2019-09-10T12:13:00+12:00"
* attester.party = Reference(acs-cda-providerrole-rex)

* section[encounter].title = "Incident / Encounter"
* section[encounter].code = $LOINC#46240-8 "History of encounters"
* section[encounter].text.status = #generated
* section[encounter].text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h3>Incident / Encounter</h3><table><tbody><tr><th>Master Incident Number</th><td>0450-1-2016/06/14</td></tr><tr><th>Encounter status</th><td>Finished</td></tr><tr><th>Encounter class</th><td>Emergency</td></tr><tr><th>Encounter type</th><td>Land ambulance</td></tr><tr><th>Encounter period</th><td>2016-06-14 11:13 to 12:42 +12:00</td></tr><tr><th>Incident location</th><td>MATAI RD/CAMPBELL RD 10 Miro Rd</td></tr><tr><th>Location type</th><td>Workplace</td></tr><tr><th>Unit call sign</th><td>MTWELL1</td></tr><tr><th>Time call received</th><td>2016-06-14 11:13 +12:00</td></tr><tr><th>Time unit dispatched</th><td>2016-06-14 11:14 +12:00</td></tr><tr><th>Time unit responded</th><td>2016-06-14 11:14 +12:00</td></tr><tr><th>Time unit arrived at scene</th><td>2016-06-14 11:28 +12:00</td></tr><tr><th>Time patient located</th><td>2016-06-14 11:30 +12:00</td></tr><tr><th>Patient status at scene</th><td>Immediate threat to life</td></tr><tr><th>Time unit departed with patient</th><td>2016-06-14 11:55 +12:00</td></tr><tr><th>Time unit arrived at destination</th><td>2016-06-14 12:07 +12:00</td></tr><tr><th>Final patient status</th><td>No threat to life</td></tr><tr><th>Disposition</th><td>Transport / treat and transport</td></tr><tr><th>Receiving facility</th><td>Sunshine Hospital Emergency Department</td></tr><tr><th>Referral pathway</th><td>GP Surgery Appointment</td></tr><tr><th>Disposition notes</th><td>Recommend GP appt to get more meds</td></tr><tr><th>Existing ACC claim number</th><td>XA12345</td></tr><tr><th>Time incident closed</th><td>2016-06-14 12:42 +12:00</td></tr><tr><th>Service provider</th><td>Order of St John</td></tr></tbody></table></div>"
* insert AcsCdaSectionEntry(encounter, Encounter, acs-cda-encounter)
* insert AcsCdaSectionEntry(encounter, Location, acs-cda-incident-location)
* insert AcsCdaSectionEntry(encounter, Observation, acs-cda-event-call-received)
* insert AcsCdaSectionEntry(encounter, Observation, acs-cda-event-unit-dispatched)
* insert AcsCdaSectionEntry(encounter, Observation, acs-cda-event-unit-responded)
* insert AcsCdaSectionEntry(encounter, Observation, acs-cda-event-arrived-scene)
* insert AcsCdaSectionEntry(encounter, Observation, acs-cda-event-patient-located)
* insert AcsCdaSectionEntry(encounter, Observation, acs-cda-event-departed-scene)
* insert AcsCdaSectionEntry(encounter, Observation, acs-cda-event-arrived-destination)
* insert AcsCdaSectionEntry(encounter, Observation, acs-cda-event-closed)
* insert AcsCdaSectionEntry(encounter, Observation, acs-cda-patient-status-scene)
* insert AcsCdaSectionEntry(encounter, Observation, acs-cda-patient-status-final)

* section[contacts].title = "Patient Contacts"
* section[contacts].code = AcsMetadataCS#section-patient-contacts "Patient contacts"
* section[contacts].text.status = #generated
* section[contacts].text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h3>Patient Contacts</h3><table><tbody><tr><th>Relationship</th><td>Next of kin</td></tr><tr><th>Name / description</th><td>Patient's mother</td></tr><tr><th>Phone</th><td>0211211212</td></tr><tr><th>Contact instruction</th><td>Please contact mother on 0211211212</td></tr></tbody></table></div>"
* insert AcsCdaSectionEntry(contacts, RelatedPerson, acs-cda-contact-mother)

* section[additionalDemographics].title = "Patient Additional Demographics"
* section[additionalDemographics].code = $LOINC#45970-1 "Patient Demographics"
* section[additionalDemographics].text.status = #generated
* section[additionalDemographics].text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h3>Patient Additional Demographics</h3><table><tbody><tr><th>Patient age</th><td>30 years</td></tr><tr><th>Patient age is estimated</th><td>No</td></tr></tbody></table></div>"
* insert AcsCdaSectionEntry(additionalDemographics, Observation, acs-cda-patient-age)

* section[socialHistory].title = "Smoking and Vaping"
* section[socialHistory].code = $LOINC#29762-2 "Social history"
* section[socialHistory].text.status = #generated
* section[socialHistory].text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h3>Smoking and Vaping</h3><table><tbody><tr><th>Smoking status</th><td>Ex-smoker, recorded 2016-06-14 11:30 +12:00</td></tr><tr><th>Vaping status</th><td>Not recorded in the CDA example</td></tr></tbody></table></div>"
* insert AcsCdaSectionEntry(socialHistory, Observation, acs-cda-smoking)

* section[problems].title = "Problems"
* section[problems].code = $LOINC#10154-3 "Chief complaint"
* section[problems].text.status = #generated
* section[problems].text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h3>Problems</h3><h4>Complaint History</h4><table><tbody><tr><th>Presenting complaint</th><td>Shortness of breath</td></tr><tr><th>Date and time of onset</th><td>2016-06-14 02:00 +12:00</td></tr><tr><th>History of incident</th><td>History line 1<br/>History line 2<br/>History line 3</td></tr></tbody></table><h4>Accident Details</h4><table><tbody><tr><th>Mechanism of injury</th><td>Chemical poisoning</td></tr><tr><th>Sports injury</th><td>Rugby Union</td></tr><tr><th>Vehicle diagram</th><td>vehicle.jpg</td></tr><tr><th>Vehicle type</th><td>Car</td></tr><tr><th>Patient characteristic</th><td>Driver</td></tr><tr><th>Estimated impact speed</th><td>150 km/h</td></tr><tr><th>Passenger compartment intrusion</th><td>Yes</td></tr><tr><th>Patient ejected</th><td>Yes</td></tr><tr><th>Rollover</th><td>Yes</td></tr><tr><th>End over end</th><td>Yes</td></tr><tr><th>Air bag deployed</th><td>Yes</td></tr><tr><th>Seatbelt or child restraint used</th><td>Yes</td></tr><tr><th>Helmet worn</th><td>Yes</td></tr><tr><th>Self-extricated</th><td>Yes</td></tr><tr><th>Patient trapped</th><td>Yes</td></tr></tbody></table><h4>Clinical Impression</h4><table><tbody><tr><th>Body diagrams</th><td>body-front.jpg; body-back.jpg</td></tr><tr><th>Primary clinical impression</th><td>Asthma</td></tr><tr><th>Secondary clinical impression</th><td>Generally unwell</td></tr><tr><th>Clinical impression notes</th><td>Clinical impression notes line 1<br/>Clinical impression notes line 2</td></tr></tbody></table></div>"
* insert AcsCdaSectionEntry(problems, Observation, acs-cda-presenting-complaint)
* insert AcsCdaSectionEntry(problems, Observation, acs-cda-history-of-incident)
* insert AcsCdaSectionEntry(problems, Condition, acs-cda-diagnosis-asthma)
* insert AcsCdaSectionEntry(problems, Condition, acs-cda-diagnosis-generally-unwell)
* insert AcsCdaSectionEntry(problems, Observation, acs-cda-accident-mechanism)
* insert AcsCdaSectionEntry(problems, Observation, acs-cda-accident-sport)
* insert AcsCdaSectionEntry(problems, Observation, acs-cda-accident-vehicle-type)
* insert AcsCdaSectionEntry(problems, Observation, acs-cda-accident-patient-characteristic)
* insert AcsCdaSectionEntry(problems, Observation, acs-cda-accident-impact-speed)
* insert AcsCdaSectionEntry(problems, Observation, acs-cda-accident-passenger-intrusion)
* insert AcsCdaSectionEntry(problems, Observation, acs-cda-accident-patient-ejected)
* insert AcsCdaSectionEntry(problems, Observation, acs-cda-accident-rollover)
* insert AcsCdaSectionEntry(problems, Observation, acs-cda-accident-end-over-end)
* insert AcsCdaSectionEntry(problems, Observation, acs-cda-accident-airbag)
* insert AcsCdaSectionEntry(problems, Observation, acs-cda-accident-seatbelt)
* insert AcsCdaSectionEntry(problems, Observation, acs-cda-accident-helmet)
* insert AcsCdaSectionEntry(problems, Observation, acs-cda-accident-self-extricated)
* insert AcsCdaSectionEntry(problems, Observation, acs-cda-accident-patient-trapped)

* section[primarySurvey].title = "Primary Survey"
* section[primarySurvey].code = AcsMetadataCS#section-primary-survey "Primary survey"
* section[primarySurvey].text.status = #generated
* section[primarySurvey].text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h3>Primary Survey</h3><table><tbody><tr><th>Patient status at scene</th><td>Immediate threat to life</td></tr><tr><th>Responsiveness</th><td>Alert</td></tr><tr><th>Airway</th><td>Patent (clear)</td></tr><tr><th>Breathing</th><td>Ineffective</td></tr><tr><th>Circulation</th><td>Compromised</td></tr><tr><th>Blood loss</th><td>Nil</td></tr></tbody></table></div>"
* insert AcsCdaSectionEntry(primarySurvey, Observation, acs-cda-primary-survey)

* section[strokeAssessments].title = "Stroke Assessments"
* section[strokeAssessments].code = AcsMetadataCS#section-stroke-assessments "Stroke assessments"
* section[strokeAssessments].text.status = #generated
* section[strokeAssessments].text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h3>Stroke Assessments</h3><h4>ABCD2 Stroke Risk Assessment - not possible</h4><table><tbody><tr><th>Assessment date and time</th><td>2016-06-14 11:00 +12:00</td></tr><tr><th>ABCD2 not possible</th><td>Patient refused</td></tr></tbody></table><h4>ABCD2 Stroke Risk Assessment - completed</h4><table><tbody><tr><th>Assessment date and time</th><td>2016-06-14 11:00 +12:00</td></tr><tr><th>Age 60 or older</th><td>No</td></tr><tr><th>Hypertensive</th><td>Yes</td></tr><tr><th>Clinical features</th><td>Speech disturbance without weakness</td></tr><tr><th>Duration of symptoms</th><td>&gt;= 60 min</td></tr><tr><th>Diabetes</th><td>No</td></tr><tr><th>ABCD2 score</th><td>3</td></tr></tbody></table><h4>FAST Stroke Test - not possible</h4><table><tbody><tr><th>Assessment date and time</th><td>2016-06-14 11:00 +12:00</td></tr><tr><th>FAST not possible</th><td>Patient refused</td></tr></tbody></table><h4>FAST Stroke Test - completed</h4><table><tbody><tr><th>Assessment date and time</th><td>2016-06-14 11:00 +12:00</td></tr><tr><th>Face</th><td>Right side droop</td></tr><tr><th>Face laterality</th><td>Right</td></tr><tr><th>Arms</th><td>Right side drift</td></tr><tr><th>Arms laterality</th><td>Right</td></tr><tr><th>Speech</th><td>Slurred</td></tr><tr><th>Date and time of onset</th><td>2016-06-14 09:35 +12:00</td></tr><tr><th>When last seen well</th><td>2016-06-13 17:30 +12:00</td></tr><tr><th>Patient found in this condition</th><td>Yes</td></tr><tr><th>Receiving hospital notified</th><td>Yes</td></tr></tbody></table></div>"
* insert AcsCdaSectionEntry(strokeAssessments, Observation, acs-cda-abcd2-refused)
* insert AcsCdaSectionEntry(strokeAssessments, Observation, acs-cda-abcd2-completed)
* insert AcsCdaSectionEntry(strokeAssessments, Observation, acs-cda-fast-refused)
* insert AcsCdaSectionEntry(strokeAssessments, Observation, acs-cda-fast-completed)

* section[fallsRisk].title = "Falls Risk Assessment"
* section[fallsRisk].code = AcsMetadataCS#section-falls-risk "Falls risk assessment"
* section[fallsRisk].text.status = #generated
* section[fallsRisk].text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h3>Falls Risk Assessment</h3><h4>Falls Risk Assessment - not possible</h4><table><tbody><tr><th>Assessment date and time</th><td>2016-06-14 11:00 +12:00</td></tr><tr><th>Falls risk assessment not possible</th><td>Patient refused</td></tr></tbody></table><h4>Falls Risk Assessment - completed</h4><table><tbody><tr><th>Assessment date and time</th><td>2016-06-14 11:00 +12:00</td></tr><tr><th>Fall frequency</th><td>Weekly</td></tr><tr><th>Avoids activities</th><td>Yes</td></tr><tr><th>Feet problem</th><td>Yes</td></tr><tr><th>Gait strength balance problem</th><td>Yes</td></tr><tr><th>Uses an aid</th><td>No</td></tr><tr><th>Dizziness</th><td>No</td></tr><tr><th>Cognitive impairment</th><td>No</td></tr><tr><th>Trip hazards</th><td>Yes</td></tr><tr><th>Home modifications required</th><td>Yes</td></tr><tr><th>Home modifications notes</th><td>Shower rail, handrail on front steps</td></tr><tr><th>Lives alone</th><td>Yes</td></tr><tr><th>Falls assessment notes</th><td>The house needs a tidy up there is stuff all over the floor</td></tr></tbody></table></div>"
* insert AcsCdaSectionEntry(fallsRisk, Observation, acs-cda-falls-refused)
* insert AcsCdaSectionEntry(fallsRisk, Observation, acs-cda-falls-completed)

* section[pastHistory].title = "Patient History"
* section[pastHistory].code = $LOINC#11348-0 "History of past illness"
* section[pastHistory].text.status = #generated
* section[pastHistory].text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h3>Patient History</h3><table><tbody><tr><th>Medical history notes</th><td>Medical history notes line 1<br/>Medical history notes line 2<br/>Medical history notes line 3</td></tr><tr><th>Last oral intake time</th><td>2016-06-14 11:00 +12:00</td></tr><tr><th>Last oral intake detail</th><td>Steak and cheese pie</td></tr></tbody></table></div>"
* insert AcsCdaSectionEntry(pastHistory, Condition, acs-cda-medical-history)
* insert AcsCdaSectionEntry(pastHistory, Observation, acs-cda-last-oral-intake)

* section[allergies].title = "Allergies and Intolerances"
* section[allergies].code = $LOINC#48765-2 "Allergies and adverse reactions"
* section[allergies].text.status = #generated
* section[allergies].text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h3>Allergies and Intolerances</h3><table><tbody><tr><th>Allergies</th><td>NKA</td></tr><tr><th>Structured code</th><td>No known allergy</td></tr></tbody></table></div>"
* insert AcsCdaSectionEntry(allergies, AllergyIntolerance, acs-cda-allergy-nka)

* section[medicationSummary].title = "Current Medications"
* section[medicationSummary].code = $LOINC#10160-0 "History of medication use"
* section[medicationSummary].text.status = #generated
* section[medicationSummary].text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h3>Current Medications</h3><table><tbody><tr><th>Medication notes</th><td>Ventolin, ipratropium</td></tr><tr><th>Information source</th><td>Patient self-report</td></tr></tbody></table></div>"
* insert AcsCdaSectionEntry(medicationSummary, MedicationStatement, acs-cda-current-medications)

* section[vitalSigns].title = "Measurements and Vital Signs"
* section[vitalSigns].code = $LOINC#8716-3 "Vital signs"
* section[vitalSigns].text.status = #generated
* section[vitalSigns].text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h3>Measurements and Vital Signs</h3><table><thead><tr><th>Date</th><th>Time</th><th>GCS</th><th>Heart rate</th><th>Resp rate</th><th>BP</th><th>SpO2</th><th>ECG</th><th>BGL</th><th>Cap refill</th><th>Temp</th><th>Pain</th><th>Pupils</th><th>ETCO2</th><th>Skin</th><th>PEFR</th></tr></thead><tbody><tr><td>2016-06-14</td><td>11:35</td><td>15</td><td>136 /min</td><td>48 /min</td><td>132/90 mmHg</td><td>95%</td><td>Atrial Flutter</td><td>4.0 mmol/L</td><td>P=2 sec; C=3 sec</td><td>38.6 degC</td><td>5</td><td>Left 5 mm reactive; Right 5 mm reactive</td><td>70 mmHg</td><td>Diaphoretic (sweaty)</td><td>92 L/min</td></tr><tr><td colspan='16'>A note about the observations. CDA structured ECG coded Atrial Fibrillation while the CDA narrative table displayed Atrial Flutter. CDA structured ETCO2 unit was %, while the clinical summary heading labelled ETCO2 as mmHg.</td></tr></tbody></table></div>"
* insert AcsCdaSectionEntry(vitalSigns, Observation, acs-cda-gcs)
* insert AcsCdaSectionEntry(vitalSigns, Observation, acs-cda-hr)
* insert AcsCdaSectionEntry(vitalSigns, Observation, acs-cda-rr)
* insert AcsCdaSectionEntry(vitalSigns, Observation, acs-cda-bp)
* insert AcsCdaSectionEntry(vitalSigns, Observation, acs-cda-spo2)
* insert AcsCdaSectionEntry(vitalSigns, Observation, acs-cda-ecg)
* insert AcsCdaSectionEntry(vitalSigns, Observation, acs-cda-bgl)
* insert AcsCdaSectionEntry(vitalSigns, Observation, acs-cda-caprefill-peripheral)
* insert AcsCdaSectionEntry(vitalSigns, Observation, acs-cda-caprefill-central)
* insert AcsCdaSectionEntry(vitalSigns, Observation, acs-cda-temp)
* insert AcsCdaSectionEntry(vitalSigns, Observation, acs-cda-pain)
* insert AcsCdaSectionEntry(vitalSigns, Observation, acs-cda-pupil-reaction-left)
* insert AcsCdaSectionEntry(vitalSigns, Observation, acs-cda-pupil-size-left)
* insert AcsCdaSectionEntry(vitalSigns, Observation, acs-cda-pupil-reaction-right)
* insert AcsCdaSectionEntry(vitalSigns, Observation, acs-cda-pupil-size-right)
* insert AcsCdaSectionEntry(vitalSigns, Observation, acs-cda-etco2)
* insert AcsCdaSectionEntry(vitalSigns, Observation, acs-cda-skin)
* insert AcsCdaSectionEntry(vitalSigns, Observation, acs-cda-pefr)

* section[medicationsAdministered].title = "Medications Administered or Supplied"
* section[medicationsAdministered].code = $LOINC#29549-3 "Medication administered"
* section[medicationsAdministered].text.status = #generated
* section[medicationsAdministered].text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h3>Medications Administered or Supplied</h3><table><thead><tr><th>Date</th><th>Time</th><th>Medication</th><th>Dose</th><th>Route</th><th>PRN</th><th>Notes</th></tr></thead><tbody><tr><td>2016-06-14</td><td>11:01</td><td>Adenosine</td><td>6 mg</td><td>Intravenous</td><td>No</td><td>A note about Adenosine</td></tr><tr><td>2016-06-14</td><td>11:02</td><td>Adrenaline (bolus)</td><td>0.1 mg</td><td>Intravenous</td><td>No</td><td>A note about Adrenaline (bolus)</td></tr><tr><td>2016-06-14</td><td>11:03</td><td>Adrenaline (infusion)</td><td>0.1 mg</td><td>Intravenous</td><td>No</td><td>A note about Adrenaline (infusion)</td></tr><tr><td>2016-06-14</td><td>11:04</td><td>Adrenaline (NEB)</td><td>5 mg</td><td>Nebuliser mask</td><td>No</td><td>A note about Adrenaline (NEB)</td></tr><tr><td>2016-06-14</td><td>11:05</td><td>Adrenaline (IM, IN)</td><td>0.3 mg</td><td>Intramuscular</td><td>No</td><td>A note about Adrenaline (IM, IN)</td></tr><tr><td>2016-06-14</td><td>11:06</td><td>Adrenaline (IV for arrest)</td><td>1 mg</td><td>Intravenous</td><td>No</td><td>A note about Adrenaline (IV for arrest)</td></tr><tr><td>2016-06-14</td><td>11:07</td><td>Amiodarone (IV for arrest)</td><td>300 mg</td><td>Intravenous</td><td>No</td><td>A note about Amiodarone (IV for arrest)</td></tr><tr><td>2016-06-14</td><td>11:08</td><td>Amiodarone (bolus)</td><td>300 mg</td><td>Intravenous</td><td>No</td><td>A note about Amiodarone (bolus)</td></tr><tr><td>2016-06-14</td><td>11:09</td><td>Amiodarone (infusion)</td><td>300 mg</td><td>Intravenous</td><td>No</td><td>A note about Amiodarone (infusion)</td></tr><tr><td>2016-06-14</td><td>11:10</td><td>Aspirin</td><td>300 mg</td><td>Per oral</td><td>No</td><td>A note about Aspirin</td></tr><tr><td>2016-06-14</td><td>11:11</td><td>Atropine</td><td>0.6 mg</td><td>Intravenous</td><td>No</td><td>A note about Atropine</td></tr><tr><td>2016-06-14</td><td>11:12</td><td>Calcium chloride</td><td>1 g</td><td>Intravenous</td><td>No</td><td>A note about Calcium chloride</td></tr><tr><td>2016-06-14</td><td>11:13</td><td>Ceftriaxone</td><td>2 g</td><td>Intravenous</td><td>No</td><td>A note about Ceftriaxone</td></tr><tr><td>2016-06-14</td><td>11:14</td><td>Clopidogrel</td><td>600 mg</td><td>Per oral</td><td>No</td><td>A note about Clopidogrel</td></tr><tr><td>2016-06-14</td><td>11:15</td><td>Entonox</td><td>Dose not recorded</td><td>Inhalation</td><td>Yes</td><td>A note about Entonox</td></tr><tr><td>2016-06-14</td><td>11:16</td><td>Fentanyl</td><td>10 mcg</td><td>Subcutaneous</td><td>No</td><td>A note about Fentanyl</td></tr><tr><td>2016-06-14</td><td>11:17</td><td>Glucagon</td><td>1 mg</td><td>Intramuscular</td><td>No</td><td>A note about Glucagon</td></tr><tr><td>2016-06-14</td><td>11:18</td><td>Oral Glucose (sachet)</td><td>10 g</td><td>Per oral</td><td>No</td><td>A note about Oral Glucose (sachet)</td></tr><tr><td>2016-06-14</td><td>11:19</td><td>10% Glucose</td><td>100 mL</td><td>Intravenous</td><td>No</td><td>A note about 10% Glucose</td></tr><tr><td>2016-06-14</td><td>11:20</td><td>GTN</td><td>0.4 mg</td><td>Sublingual</td><td>No</td><td>A note about GTN</td></tr><tr><td>2016-06-14</td><td>11:21</td><td>Ibuprofen</td><td>400 mg</td><td>Per oral</td><td>No</td><td>A note about Ibuprofen</td></tr><tr><td>2016-06-14</td><td>11:22</td><td>Ipratropium</td><td>500 mcg</td><td>Nebuliser mask</td><td>No</td><td>A note about Ipratropium</td></tr><tr><td>2016-06-14</td><td>11:23</td><td>Ipratropium (MDI)</td><td>1 puff</td><td>Inhalation</td><td>No</td><td>A note about Ipratropium (MDI)</td></tr><tr><td>2016-06-14</td><td>11:24</td><td>Ketamine</td><td>10 mg</td><td>Intravenous</td><td>No</td><td>A note about Ketamine</td></tr><tr><td>2016-06-14</td><td>11:25</td><td>Lignocaine</td><td>1 mL</td><td>Subcutaneous</td><td>No</td><td>A note about Lignocaine</td></tr><tr><td>2016-06-14</td><td>11:26</td><td>Lignocaine (SC for ring block)</td><td>1 mL</td><td>Subcutaneous</td><td>No</td><td>A note about Lignocaine (SC for ring block)</td></tr><tr><td>2016-06-14</td><td>11:27</td><td>Lignocaine (SC for cannulation)</td><td>0.1 mL</td><td>Subcutaneous</td><td>No</td><td>A note about Lignocaine (SC for cannulation)</td></tr><tr><td>2016-06-14</td><td>11:28</td><td>Loratadine</td><td>10 mg</td><td>Per oral</td><td>No</td><td>A note about Loratadine</td></tr><tr><td>2016-06-14</td><td>11:29</td><td>Methoxyflurane</td><td>3 mL</td><td>Inhalation</td><td>No</td><td>A note about Methoxyflurane</td></tr><tr><td>2016-06-14</td><td>11:30</td><td>Midazolam (IM)</td><td>5 mg</td><td>Intramuscular</td><td>No</td><td>A note about Midazolam (IM)</td></tr><tr><td>2016-06-14</td><td>11:31</td><td>Midazolam</td><td>0.5 mg</td><td>Intravenous</td><td>No</td><td>A note about Midazolam</td></tr><tr><td>2016-06-14</td><td>11:32</td><td>Morphine</td><td>1 mg</td><td>Intravenous</td><td>No</td><td>A note about Morphine</td></tr><tr><td>2016-06-14</td><td>11:33</td><td>Naloxone</td><td>0.1 mg</td><td>Intravenous</td><td>No</td><td>A note about Naloxone</td></tr><tr><td>2016-06-14</td><td>11:34</td><td>Ondansetron (injection)</td><td>4 mg</td><td>Intravenous</td><td>No</td><td>A note about Ondansetron (injection)</td></tr><tr><td>2016-06-14</td><td>11:35</td><td>Ondansetron (wafer)</td><td>4 mg</td><td>Per oral</td><td>No</td><td>A note about Ondansetron (wafer)</td></tr><tr><td>2016-06-14</td><td>11:36</td><td>Other (specify in Notes)</td><td>12.5 mg</td><td>Per oral</td><td>No</td><td>Patients own Quinapril</td></tr><tr><td>2016-06-14</td><td>11:37</td><td>Oxygen</td><td>1 L/min</td><td>Inhalation</td><td>No</td><td>A note about Oxygen</td></tr><tr><td>2016-06-14</td><td>11:38</td><td>Oxytocin</td><td>5 units</td><td>Intramuscular</td><td>No</td><td>A note about Oxytocin</td></tr><tr><td>2016-06-14</td><td>11:39</td><td>Paracetamol (tablet)</td><td>1000 mg</td><td>Per oral</td><td>No</td><td>A note about Paracetamol (tablet)</td></tr><tr><td>2016-06-14</td><td>11:40</td><td>Paracetamol (syrup)</td><td>1000 mg</td><td>Per oral</td><td>No</td><td>A note about Paracetamol (syrup)</td></tr><tr><td>2016-06-14</td><td>11:41</td><td>Prednisone</td><td>40 mg</td><td>Per oral</td><td>No</td><td>A note about Prednisone</td></tr><tr><td>2016-06-14</td><td>11:42</td><td>Rocuronium</td><td>50 mg</td><td>Intravenous</td><td>No</td><td>A note about Rocuronium</td></tr><tr><td>2016-06-14</td><td>11:43</td><td>Salbutamol</td><td>5 mg</td><td>Nebuliser mask</td><td>No</td><td>A note about Salbutamol</td></tr><tr><td>2016-06-14</td><td>11:44</td><td>Salbutamol (MDI)</td><td>1 puff</td><td>Inhalation</td><td>No</td><td>A note about Salbutamol (MDI)</td></tr><tr><td>2016-06-14</td><td>11:45</td><td>Salbutamol + Ipratropium MDI</td><td>1 puff</td><td>Inhalation</td><td>No</td><td>A note about Salbutamol + Ipratropium MDI</td></tr><tr><td>2016-06-14</td><td>11:46</td><td>Sodium bicarbonate</td><td>100 mL</td><td>Intravenous</td><td>No</td><td>A note about Sodium bicarbonate</td></tr><tr><td>2016-06-14</td><td>11:47</td><td>0.9% Sodium chloride</td><td>50 mL</td><td>Intravenous</td><td>No</td><td>A note about 0.9% Sodium chloride</td></tr><tr><td>2016-06-14</td><td>11:48</td><td>Suxamethonium</td><td>100 mg</td><td>Intravenous</td><td>No</td><td>A note about Suxamethonium</td></tr><tr><td>2016-06-14</td><td>11:49</td><td>Tramadol</td><td>50 mg</td><td>Per oral</td><td>No</td><td>A note about Tramadol</td></tr></tbody></table></div>"
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-adenosine)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-adrenaline-bolus)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-adrenaline-infusion)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-adrenaline-neb)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-adrenaline-im-in)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-adrenaline-arrest)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-amiodarone-arrest)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-amiodarone-bolus)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-amiodarone-infusion)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-aspirin)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-atropine)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-calcium-chloride)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-ceftriaxone)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-clopidogrel)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-entonox)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-fentanyl)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-glucagon)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-oral-glucose)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-glucose-10-percent)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-gtn)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-ibuprofen)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-ipratropium-neb)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-ipratropium-mdi)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-ketamine)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-lignocaine)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-lignocaine-ring-block)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-lignocaine-cannulation)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-loratadine)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-methoxyflurane)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-midazolam-im)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-midazolam-iv)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-morphine)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-naloxone)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-ondansetron-injection)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-ondansetron-wafer)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-other-quinapril)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-oxygen)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-oxytocin)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-paracetamol-tablet)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-paracetamol-syrup)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-prednisone)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-rocuronium)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-salbutamol-neb)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-salbutamol-mdi)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-salbutamol-ipratropium-mdi)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-sodium-bicarbonate)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-sodium-chloride)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-suxamethonium)
* insert AcsCdaSectionEntry(medicationsAdministered, MedicationAdministration, acs-cda-med-tramadol)

* section[procedures].title = "Procedures"
* section[procedures].code = $LOINC#47519-4 "History of procedures"
* section[procedures].text.status = #generated
* section[procedures].text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h3>Procedures</h3><table><thead><tr><th>Date</th><th>Time</th><th>Procedure</th><th>Detail / body site</th><th>Outcome</th><th>Notes</th></tr></thead><tbody><tr><td>2016-06-14</td><td>11:52</td><td>Airway Management Manual Clear</td><td>Airway</td><td>Not recorded</td><td>A note about Manual Clear</td></tr><tr><td>2016-06-14</td><td>11:53</td><td>Airway Management Suction</td><td>Airway</td><td>Not recorded</td><td>A note about Suction</td></tr><tr><td>2016-06-14</td><td>11:54</td><td>Airway Management OPA</td><td>Airway</td><td>Unsuccessful</td><td>A note about OPA</td></tr><tr><td>2016-06-14</td><td>11:55</td><td>Airway Management NPA</td><td>Airway</td><td>Unsuccessful</td><td>A note about NPA</td></tr><tr><td>2016-06-14</td><td>11:56</td><td>Airway Management LMA</td><td>Airway</td><td>Unsuccessful</td><td>A note about LMA</td></tr><tr><td>2016-06-14</td><td>11:57</td><td>Airway Management Intubation</td><td>Airway</td><td>Unsuccessful</td><td>A note about Intubation</td></tr><tr><td>2016-06-14</td><td>11:58</td><td>Airway Management Cricothyroidotomy</td><td>Airway</td><td>Unsuccessful</td><td>A note about Cricothyroidotomy</td></tr><tr><td>2016-06-14</td><td>11:59</td><td>Airway Management Laryngoscopy</td><td>Airway</td><td>Unsuccessful</td><td>A note about Laryngoscopy</td></tr><tr><td>2016-06-14</td><td>12:00</td><td>Airway Management Other Device</td><td>Airway</td><td>Not recorded</td><td>A note about Other Device</td></tr><tr><td>2016-06-14</td><td>12:01</td><td>Ventilation (Manual)</td><td>Manual ventilation</td><td>Not recorded</td><td>A note about Ventilation</td></tr><tr><td>2016-06-14</td><td>12:01</td><td>Cardioversion</td><td>Energy 360 J</td><td>Not recorded</td><td>A note about Cardioversion; CDA summary table also displays Cardioversion 25J at 12:07</td></tr><tr><td>2016-06-14</td><td>12:02</td><td>Catheter troubleshooting</td><td>Catheter</td><td>Unsuccessful</td><td>A note about Catheter troubleshooting</td></tr><tr><td>2016-06-14</td><td>12:03</td><td>Chest decompression</td><td>Right second intercostal, midclavicular</td><td>Unsuccessful</td><td>A note about Chest decompression</td></tr><tr><td>2016-06-14</td><td>12:03</td><td>CPAP</td><td>5 cmH2O</td><td>Not recorded</td><td>A note about CPAP</td></tr><tr><td>2016-06-14</td><td>12:03</td><td>CPR</td><td>Cardiac resuscitation</td><td>Not recorded</td><td>A note about CPR</td></tr><tr><td>2016-06-14</td><td>12:05</td><td>Defibrillation</td><td>Professional defibrillator monitor; 360 J</td><td>Not recorded</td><td>A note about Defibrillation</td></tr><tr><td>2016-06-14</td><td>12:06</td><td>Defibrillation AED</td><td>AED</td><td>Not recorded</td><td>A note about Defibrillation AED</td></tr><tr><td>2016-06-14</td><td>12:07</td><td>IO insertion</td><td>Left tibial</td><td>Unsuccessful</td><td>A note about IO insertion</td></tr><tr><td>2016-06-14</td><td>12:08</td><td>IV insertion</td><td>Right forearm</td><td>Unsuccessful</td><td>A note about IV insertion</td></tr><tr><td>2016-06-14</td><td>12:09</td><td>Valsalva</td><td>Valsalva manoeuvre</td><td>Not recorded</td><td>A note about Valsalva</td></tr><tr><td>2016-06-14</td><td>12:09</td><td>Limb reduction Wrist</td><td>Left wrist</td><td>Unsuccessful</td><td>A note about Limb reduction Wrist</td></tr><tr><td>2016-06-14</td><td>12:10</td><td>Limb reduction Elbow</td><td>Right elbow</td><td>Unsuccessful</td><td>A note about Limb reduction Elbow</td></tr><tr><td>2016-06-14</td><td>12:11</td><td>Limb reduction Shoulder</td><td>Left shoulder</td><td>Unsuccessful</td><td>A note about Limb reduction Shoulder</td></tr><tr><td>2016-06-14</td><td>12:12</td><td>Limb reduction Ankle</td><td>Right ankle</td><td>Unsuccessful</td><td>A note about Limb reduction Ankle</td></tr><tr><td>2016-06-14</td><td>12:13</td><td>Limb reduction Other</td><td>Other limb</td><td>Unsuccessful</td><td>A note about Limb reduction Other</td></tr><tr><td>2016-06-14</td><td>12:14</td><td>Pacing</td><td>Cardiac pacing</td><td>Unsuccessful</td><td>A note about Pacing</td></tr><tr><td>2016-06-14</td><td>12:15</td><td>PEEP</td><td>Valve size 5</td><td>Not recorded</td><td>A note about PEEP; CDA summary table displayed this at 12:02</td></tr><tr><td>2016-06-14</td><td>12:16</td><td>Positioning Recovery</td><td>Recovery position</td><td>Not recorded</td><td>A note about Positioning Recovery</td></tr><tr><td>2016-06-14</td><td>12:17</td><td>Positioning Supine</td><td>Supine position</td><td>Not recorded</td><td>A note about Positioning Supine</td></tr><tr><td>2016-06-14</td><td>12:18</td><td>Positioning Seated</td><td>Seated position</td><td>Not recorded</td><td>A note about Positioning Seated</td></tr><tr><td>2016-06-14</td><td>12:19</td><td>Positioning Lateral</td><td>Lateral position</td><td>Not recorded</td><td>A note about Positioning Lateral</td></tr><tr><td>2016-06-14</td><td>12:20</td><td>Positioning Semi-recumbent</td><td>Semi-recumbent position</td><td>Not recorded</td><td>A note about Positioning Semi-recumbent</td></tr><tr><td>2016-06-14</td><td>12:21</td><td>Positioning Prone</td><td>Prone position</td><td>Not recorded</td><td>A note about Positioning Prone</td></tr><tr><td>2016-06-14</td><td>12:22</td><td>Positioning Other</td><td>Other positioning</td><td>Not recorded</td><td>A note about Positioning Other</td></tr><tr><td>2016-06-14</td><td>12:23</td><td>RSI</td><td>Rapid sequence induction</td><td>Unsuccessful</td><td>A note about RSI; CDA summary table displayed RSI at 12:04</td></tr><tr><td>2016-06-14</td><td>12:24</td><td>Splint/dressing</td><td>Splint or dressing</td><td>Not recorded</td><td>A note about Splint/dressing</td></tr><tr><td>2016-06-14</td><td>12:25</td><td>Stomach decompression</td><td>Stomach decompression</td><td>Unsuccessful</td><td>A note about Stomach decompression</td></tr><tr><td>2016-06-14</td><td>12:26</td><td>Tourniquet</td><td>Leg</td><td>Unsuccessful</td><td>A note about Tourniquet</td></tr></tbody></table></div>"
* insert AcsCdaSectionEntry(procedures, Procedure, acs-cda-proc-airway-manual-clear)
* insert AcsCdaSectionEntry(procedures, Procedure, acs-cda-proc-airway-suction)
* insert AcsCdaSectionEntry(procedures, Procedure, acs-cda-proc-airway-opa)
* insert AcsCdaSectionEntry(procedures, Procedure, acs-cda-proc-airway-npa)
* insert AcsCdaSectionEntry(procedures, Procedure, acs-cda-proc-airway-lma)
* insert AcsCdaSectionEntry(procedures, Procedure, acs-cda-proc-airway-intubation)
* insert AcsCdaSectionEntry(procedures, Procedure, acs-cda-proc-airway-cricothyroidotomy)
* insert AcsCdaSectionEntry(procedures, Procedure, acs-cda-proc-airway-laryngoscopy)
* insert AcsCdaSectionEntry(procedures, Procedure, acs-cda-proc-airway-other-device)
* insert AcsCdaSectionEntry(procedures, Procedure, acs-cda-proc-ventilation-manual)
* insert AcsCdaSectionEntry(procedures, Procedure, acs-cda-proc-cardioversion)
* insert AcsCdaSectionEntry(procedures, Procedure, acs-cda-proc-catheter-troubleshooting)
* insert AcsCdaSectionEntry(procedures, Procedure, acs-cda-proc-chest-decompression)
* insert AcsCdaSectionEntry(procedures, Procedure, acs-cda-proc-cpap)
* insert AcsCdaSectionEntry(procedures, Procedure, acs-cda-proc-cpr)
* insert AcsCdaSectionEntry(procedures, Procedure, acs-cda-proc-defibrillation)
* insert AcsCdaSectionEntry(procedures, Procedure, acs-cda-proc-defibrillation-aed)
* insert AcsCdaSectionEntry(procedures, Procedure, acs-cda-proc-io-insertion)
* insert AcsCdaSectionEntry(procedures, Procedure, acs-cda-proc-iv-insertion)
* insert AcsCdaSectionEntry(procedures, Procedure, acs-cda-proc-valsalva)
* insert AcsCdaSectionEntry(procedures, Procedure, acs-cda-proc-limb-reduction-wrist)
* insert AcsCdaSectionEntry(procedures, Procedure, acs-cda-proc-limb-reduction-elbow)
* insert AcsCdaSectionEntry(procedures, Procedure, acs-cda-proc-limb-reduction-shoulder)
* insert AcsCdaSectionEntry(procedures, Procedure, acs-cda-proc-limb-reduction-ankle)
* insert AcsCdaSectionEntry(procedures, Procedure, acs-cda-proc-limb-reduction-other)
* insert AcsCdaSectionEntry(procedures, Procedure, acs-cda-proc-pacing)
* insert AcsCdaSectionEntry(procedures, Procedure, acs-cda-proc-peep)
* insert AcsCdaSectionEntry(procedures, Procedure, acs-cda-proc-position-recovery)
* insert AcsCdaSectionEntry(procedures, Procedure, acs-cda-proc-position-supine)
* insert AcsCdaSectionEntry(procedures, Procedure, acs-cda-proc-position-seated)
* insert AcsCdaSectionEntry(procedures, Procedure, acs-cda-proc-position-lateral)
* insert AcsCdaSectionEntry(procedures, Procedure, acs-cda-proc-position-semi-recumbent)
* insert AcsCdaSectionEntry(procedures, Procedure, acs-cda-proc-position-prone)
* insert AcsCdaSectionEntry(procedures, Procedure, acs-cda-proc-position-other)
* insert AcsCdaSectionEntry(procedures, Procedure, acs-cda-proc-rsi)
* insert AcsCdaSectionEntry(procedures, Procedure, acs-cda-proc-splint-dressing)
* insert AcsCdaSectionEntry(procedures, Procedure, acs-cda-proc-stomach-decompression)
* insert AcsCdaSectionEntry(procedures, Procedure, acs-cda-proc-tourniquet)

* section[refusal].title = "Transport/treatment Refusal"
* section[refusal].code = AcsMetadataCS#section-refusal "Transport/treatment refusal"
* section[refusal].text.status = #generated
* section[refusal].text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h3>Transport/treatment Refusal</h3><table><tbody><tr><th>Treatment required</th><td>Yes</td></tr><tr><th>Transport required</th><td>Yes</td></tr><tr><th>Consulted with</th><td>Patients mother</td></tr><tr><th>Reason for refusal</th><td>Doesnt like hospital</td></tr><tr><th>Consequences explained</th><td>Possible blindness, insanity and death</td></tr></tbody></table></div>"
* insert AcsCdaSectionEntry(refusal, Observation, acs-cda-refusal)

* section[competence].title = "Patient Competence"
* section[competence].code = AcsMetadataCS#section-competence "Patient competence"
* section[competence].text.status = #generated
* section[competence].text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h3>Patient Competence</h3><table><tbody><tr><th>Assessment date and time</th><td>2016-06-14 11:00 +12:00</td></tr><tr><th>Patient appears able to understand information provided to them on proposed treatments</th><td>Yes</td></tr><tr><th>Patient appears able to understand the consequences of their decisions</th><td>Yes</td></tr><tr><th>Patient appears able to remember information given to them</th><td>Yes</td></tr><tr><th>Patient has attempted or expressed serious thoughts of self-harm</th><td>No</td></tr></tbody></table></div>"
* insert AcsCdaSectionEntry(competence, Observation, acs-cda-competence)

* section[carePlan].title = "Care Plan"
* section[carePlan].code = $LOINC#18776-5 "Plan of care"
* section[carePlan].text.status = #generated
* section[carePlan].text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h3>Care Plan</h3><table><tbody><tr><th>Advice to Patient</th><td>Per asthma leaflet<br/>Recommend ask Housing NZ to remove privet bush</td></tr><tr><th>Advice to GP</th><td>Pt states stressors at home which seem to precipitate asthma attacks<br/>Also note flowering privet bush outside front door see photo</td></tr><tr><th>Referral pathway</th><td>GP Surgery Appointment</td></tr><tr><th>Referral reason / notes</th><td>Recommend GP appt to get more meds</td></tr></tbody></table></div>"
* insert AcsCdaSectionEntry(carePlan, CarePlan, acs-cda-careplan)
* insert AcsCdaSectionEntry(carePlan, ServiceRequest, acs-cda-referral-gp)

* section[clinicalImages].title = "Clinical Images"
* section[clinicalImages].code = AcsMetadataCS#section-clinical-images "Clinical images"
* section[clinicalImages].text.status = #generated
* section[clinicalImages].text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h3>Clinical Images</h3><table><thead><tr><th>Image</th><th>Reference</th><th>Body site / context</th><th>Note</th></tr></thead><tbody><tr><td>Vehicle diagram</td><td>vehicle.jpg</td><td>Road traffic accident details</td><td>Vehicle diagram</td></tr><tr><td>Body diagram front</td><td>body-front.jpg</td><td>Body front</td><td>Body diagram (front)</td></tr><tr><td>Body diagram back</td><td>body-back.jpg</td><td>Body back</td><td>Body diagram (back)</td></tr><tr><td>Photo 1</td><td>image-01.jpg</td><td>Clinical image</td><td>Photo 1</td></tr><tr><td>Photo 2</td><td>image-02.jpg</td><td>Clinical image</td><td>Photo 2</td></tr></tbody></table></div>"
* insert AcsCdaSectionEntry(clinicalImages, Media, acs-cda-image-vehicle)
* insert AcsCdaSectionEntry(clinicalImages, Media, acs-cda-image-body-front)
* insert AcsCdaSectionEntry(clinicalImages, Media, acs-cda-image-body-back)
* insert AcsCdaSectionEntry(clinicalImages, Media, acs-cda-image-01)
* insert AcsCdaSectionEntry(clinicalImages, Media, acs-cda-image-02)

// --- Complete CDA-derived document Bundle ---------------------------
Instance: AmbulanceCareSummaryCdaCompleteExample
InstanceOf: AmbulanceCareSummaryBundle
Usage: #example
Title: "Complete CDA Recreation Ambulance Care Summary Document"
Description: "A second worked FHIR document example attempting to fully recreate the CDA ambulance care summary example."
* identifier.system = "https://standards.digital.health.nz/ns/ambulance-care-summary-id"
* identifier.value = "1453821363387010"
* type = #document
* timestamp = "2019-09-10T11:12:00+12:00"
* insert AcsCdaBundleEntry(Composition, acs-cda-composition)
* insert AcsCdaBundleEntry(Patient, acs-cda-patient-bob)
* insert AcsCdaBundleEntry(Observation, acs-cda-patient-age)
* insert AcsCdaBundleEntry(RelatedPerson, acs-cda-contact-mother)
* insert AcsCdaBundleEntry(Practitioner, acs-cda-clinician-josephine)
* insert AcsCdaBundleEntry(Practitioner, acs-cda-clinician-bob)
* insert AcsCdaBundleEntry(Practitioner, acs-cda-medical-director-rex)
* insert AcsCdaBundleEntry(Organization, acs-cda-org-stjohn)
* insert AcsCdaBundleEntry(PractitionerRole, acs-cda-providerrole-josephine)
* insert AcsCdaBundleEntry(PractitionerRole, acs-cda-providerrole-bob)
* insert AcsCdaBundleEntry(PractitionerRole, acs-cda-providerrole-rex)
* insert AcsCdaBundleEntry(Location, acs-cda-facility-sunshine)
* insert AcsCdaBundleEntry(Location, acs-cda-incident-location)
* insert AcsCdaBundleEntry(Encounter, acs-cda-encounter)
* insert AcsCdaBundleEntry(Observation, acs-cda-event-call-received)
* insert AcsCdaBundleEntry(Observation, acs-cda-event-unit-dispatched)
* insert AcsCdaBundleEntry(Observation, acs-cda-event-unit-responded)
* insert AcsCdaBundleEntry(Observation, acs-cda-event-arrived-scene)
* insert AcsCdaBundleEntry(Observation, acs-cda-event-patient-located)
* insert AcsCdaBundleEntry(Observation, acs-cda-event-departed-scene)
* insert AcsCdaBundleEntry(Observation, acs-cda-event-arrived-destination)
* insert AcsCdaBundleEntry(Observation, acs-cda-event-closed)
* insert AcsCdaBundleEntry(Observation, acs-cda-patient-status-scene)
* insert AcsCdaBundleEntry(Observation, acs-cda-patient-status-final)
* insert AcsCdaBundleEntry(Observation, acs-cda-smoking)
* insert AcsCdaBundleEntry(Observation, acs-cda-presenting-complaint)
* insert AcsCdaBundleEntry(Observation, acs-cda-history-of-incident)
* insert AcsCdaBundleEntry(Observation, acs-cda-accident-mechanism)
* insert AcsCdaBundleEntry(Observation, acs-cda-accident-sport)
* insert AcsCdaBundleEntry(Observation, acs-cda-accident-vehicle-type)
* insert AcsCdaBundleEntry(Observation, acs-cda-accident-patient-characteristic)
* insert AcsCdaBundleEntry(Observation, acs-cda-accident-impact-speed)
* insert AcsCdaBundleEntry(Observation, acs-cda-accident-passenger-intrusion)
* insert AcsCdaBundleEntry(Observation, acs-cda-accident-patient-ejected)
* insert AcsCdaBundleEntry(Observation, acs-cda-accident-rollover)
* insert AcsCdaBundleEntry(Observation, acs-cda-accident-end-over-end)
* insert AcsCdaBundleEntry(Observation, acs-cda-accident-airbag)
* insert AcsCdaBundleEntry(Observation, acs-cda-accident-seatbelt)
* insert AcsCdaBundleEntry(Observation, acs-cda-accident-helmet)
* insert AcsCdaBundleEntry(Observation, acs-cda-accident-self-extricated)
* insert AcsCdaBundleEntry(Observation, acs-cda-accident-patient-trapped)
* insert AcsCdaBundleEntry(Condition, acs-cda-diagnosis-asthma)
* insert AcsCdaBundleEntry(Condition, acs-cda-diagnosis-generally-unwell)
* insert AcsCdaBundleEntry(Observation, acs-cda-primary-survey)
* insert AcsCdaBundleEntry(Observation, acs-cda-abcd2-refused)
* insert AcsCdaBundleEntry(Observation, acs-cda-abcd2-completed)
* insert AcsCdaBundleEntry(Observation, acs-cda-fast-refused)
* insert AcsCdaBundleEntry(Observation, acs-cda-fast-completed)
* insert AcsCdaBundleEntry(Observation, acs-cda-falls-refused)
* insert AcsCdaBundleEntry(Observation, acs-cda-falls-completed)
* insert AcsCdaBundleEntry(Observation, acs-cda-refusal)
* insert AcsCdaBundleEntry(Observation, acs-cda-competence)
* insert AcsCdaBundleEntry(Observation, acs-cda-gcs)
* insert AcsCdaBundleEntry(Observation, acs-cda-hr)
* insert AcsCdaBundleEntry(Observation, acs-cda-rr)
* insert AcsCdaBundleEntry(Observation, acs-cda-bp)
* insert AcsCdaBundleEntry(Observation, acs-cda-spo2)
* insert AcsCdaBundleEntry(Observation, acs-cda-ecg)
* insert AcsCdaBundleEntry(Observation, acs-cda-bgl)
* insert AcsCdaBundleEntry(Observation, acs-cda-caprefill-peripheral)
* insert AcsCdaBundleEntry(Observation, acs-cda-caprefill-central)
* insert AcsCdaBundleEntry(Observation, acs-cda-temp)
* insert AcsCdaBundleEntry(Observation, acs-cda-pain)
* insert AcsCdaBundleEntry(Observation, acs-cda-pupil-reaction-left)
* insert AcsCdaBundleEntry(Observation, acs-cda-pupil-size-left)
* insert AcsCdaBundleEntry(Observation, acs-cda-pupil-reaction-right)
* insert AcsCdaBundleEntry(Observation, acs-cda-pupil-size-right)
* insert AcsCdaBundleEntry(Observation, acs-cda-etco2)
* insert AcsCdaBundleEntry(Observation, acs-cda-skin)
* insert AcsCdaBundleEntry(Observation, acs-cda-pefr)
* insert AcsCdaBundleEntry(Condition, acs-cda-medical-history)
* insert AcsCdaBundleEntry(MedicationStatement, acs-cda-current-medications)
* insert AcsCdaBundleEntry(AllergyIntolerance, acs-cda-allergy-nka)
* insert AcsCdaBundleEntry(Observation, acs-cda-last-oral-intake)
* insert AcsCdaBundleEntry(CarePlan, acs-cda-careplan)
* insert AcsCdaBundleEntry(ServiceRequest, acs-cda-referral-gp)
* insert AcsCdaBundleEntry(Media, acs-cda-image-vehicle)
* insert AcsCdaBundleEntry(Media, acs-cda-image-body-front)
* insert AcsCdaBundleEntry(Media, acs-cda-image-body-back)
* insert AcsCdaBundleEntry(Media, acs-cda-image-01)
* insert AcsCdaBundleEntry(Media, acs-cda-image-02)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-adenosine)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-adrenaline-bolus)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-adrenaline-infusion)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-adrenaline-neb)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-adrenaline-im-in)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-adrenaline-arrest)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-amiodarone-arrest)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-amiodarone-bolus)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-amiodarone-infusion)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-aspirin)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-atropine)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-calcium-chloride)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-ceftriaxone)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-clopidogrel)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-entonox)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-fentanyl)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-glucagon)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-oral-glucose)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-glucose-10-percent)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-gtn)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-ibuprofen)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-ipratropium-neb)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-ipratropium-mdi)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-ketamine)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-lignocaine)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-lignocaine-ring-block)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-lignocaine-cannulation)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-loratadine)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-methoxyflurane)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-midazolam-im)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-midazolam-iv)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-morphine)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-naloxone)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-ondansetron-injection)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-ondansetron-wafer)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-other-quinapril)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-oxygen)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-oxytocin)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-paracetamol-tablet)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-paracetamol-syrup)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-prednisone)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-rocuronium)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-salbutamol-neb)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-salbutamol-mdi)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-salbutamol-ipratropium-mdi)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-sodium-bicarbonate)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-sodium-chloride)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-suxamethonium)
* insert AcsCdaBundleEntry(MedicationAdministration, acs-cda-med-tramadol)
* insert AcsCdaBundleEntry(Procedure, acs-cda-proc-airway-manual-clear)
* insert AcsCdaBundleEntry(Procedure, acs-cda-proc-airway-suction)
* insert AcsCdaBundleEntry(Procedure, acs-cda-proc-airway-opa)
* insert AcsCdaBundleEntry(Procedure, acs-cda-proc-airway-npa)
* insert AcsCdaBundleEntry(Procedure, acs-cda-proc-airway-lma)
* insert AcsCdaBundleEntry(Procedure, acs-cda-proc-airway-intubation)
* insert AcsCdaBundleEntry(Procedure, acs-cda-proc-airway-cricothyroidotomy)
* insert AcsCdaBundleEntry(Procedure, acs-cda-proc-airway-laryngoscopy)
* insert AcsCdaBundleEntry(Procedure, acs-cda-proc-airway-other-device)
* insert AcsCdaBundleEntry(Procedure, acs-cda-proc-ventilation-manual)
* insert AcsCdaBundleEntry(Procedure, acs-cda-proc-cardioversion)
* insert AcsCdaBundleEntry(Procedure, acs-cda-proc-catheter-troubleshooting)
* insert AcsCdaBundleEntry(Procedure, acs-cda-proc-chest-decompression)
* insert AcsCdaBundleEntry(Procedure, acs-cda-proc-cpap)
* insert AcsCdaBundleEntry(Procedure, acs-cda-proc-cpr)
* insert AcsCdaBundleEntry(Procedure, acs-cda-proc-defibrillation)
* insert AcsCdaBundleEntry(Procedure, acs-cda-proc-defibrillation-aed)
* insert AcsCdaBundleEntry(Procedure, acs-cda-proc-io-insertion)
* insert AcsCdaBundleEntry(Procedure, acs-cda-proc-iv-insertion)
* insert AcsCdaBundleEntry(Procedure, acs-cda-proc-valsalva)
* insert AcsCdaBundleEntry(Procedure, acs-cda-proc-limb-reduction-wrist)
* insert AcsCdaBundleEntry(Procedure, acs-cda-proc-limb-reduction-elbow)
* insert AcsCdaBundleEntry(Procedure, acs-cda-proc-limb-reduction-shoulder)
* insert AcsCdaBundleEntry(Procedure, acs-cda-proc-limb-reduction-ankle)
* insert AcsCdaBundleEntry(Procedure, acs-cda-proc-limb-reduction-other)
* insert AcsCdaBundleEntry(Procedure, acs-cda-proc-pacing)
* insert AcsCdaBundleEntry(Procedure, acs-cda-proc-peep)
* insert AcsCdaBundleEntry(Procedure, acs-cda-proc-position-recovery)
* insert AcsCdaBundleEntry(Procedure, acs-cda-proc-position-supine)
* insert AcsCdaBundleEntry(Procedure, acs-cda-proc-position-seated)
* insert AcsCdaBundleEntry(Procedure, acs-cda-proc-position-lateral)
* insert AcsCdaBundleEntry(Procedure, acs-cda-proc-position-semi-recumbent)
* insert AcsCdaBundleEntry(Procedure, acs-cda-proc-position-prone)
* insert AcsCdaBundleEntry(Procedure, acs-cda-proc-position-other)
* insert AcsCdaBundleEntry(Procedure, acs-cda-proc-rsi)
* insert AcsCdaBundleEntry(Procedure, acs-cda-proc-splint-dressing)
* insert AcsCdaBundleEntry(Procedure, acs-cda-proc-stomach-decompression)
* insert AcsCdaBundleEntry(Procedure, acs-cda-proc-tourniquet)
