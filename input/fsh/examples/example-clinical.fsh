// =====================================================================
// Worked example - encounter and clinical content
// =====================================================================

Instance: acs-encounter
InstanceOf: AmbulanceEncounter
Usage: #example
Title: "Example Encounter - Incident 0450-1-2016/06/14"
Description: "Example ambulance encounter (incident)."
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h2>Ambulance encounter: 0450-1-2016/06/14</h2><table><tbody><tr><th>Status</th><td>Finished</td></tr><tr><th>Class</th><td>Emergency</td></tr><tr><th>Encounter type</th><td>Land ambulance</td></tr><tr><th>Patient</th><td>Bob Bobson</td></tr><tr><th>Attending clinician</th><td>Josephine Manu-Bloggs, paramedic</td></tr><tr><th>Period</th><td>2016-06-14 11:13 to 12:42 +12:00</td></tr><tr><th>Diagnosis</th><td>Asthma</td></tr><tr><th>Disposition</th><td>Treat and transport</td></tr><tr><th>Destination</th><td>Sunshine Hospital Emergency Department</td></tr><tr><th>Service provider</th><td>Order of St John</td></tr></tbody></table></div>"
* identifier[masterIncidentNumber].system = "https://standards.digital.health.nz/ns/ambulance-master-incident-number"
* identifier[masterIncidentNumber].value = "0450-1-2016/06/14"
* status = #finished
* class = $v3-ActCode#EMER "emergency"
* type = AcsEncounterTypeCS#land-ambulance
* subject = Reference(acs-patient-bob)
* participant.individual = Reference(acs-providerrole-josephine)
* period.start = "2016-06-14T11:13:00+12:00"
* period.end = "2016-06-14T12:42:00+12:00"
* diagnosis.condition = Reference(acs-diagnosis-asthma)
* hospitalization.dischargeDisposition = AcsDispositionCS#treat-and-transport
* hospitalization.destination = Reference(acs-facility-sunshine)
* serviceProvider = Reference(acs-org-stjohn)

Instance: acs-presenting-complaint
InstanceOf: AcsPresentingComplaint
Usage: #example
Title: "Example Presenting Complaint - Breathing difficulty"
Description: "Example presenting complaint coded with MPDS."
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h2>Presenting complaint</h2><table><tbody><tr><th>Status</th><td>Final</td></tr><tr><th>Code</th><td>Chief complaint (LOINC 67570-2)</td></tr><tr><th>Patient</th><td>Bob Bobson</td></tr><tr><th>Encounter</th><td>0450-1-2016/06/14</td></tr><tr><th>Effective time</th><td>2016-06-14 02:00 +12:00</td></tr><tr><th>Complaint</th><td>Severe respiratory distress (MPDS 6D1)</td></tr></tbody></table></div>"
* status = #final
* code = $LOINC#67570-2 "Chief complaint"
* subject = Reference(acs-patient-bob)
* encounter = Reference(acs-encounter)
* effectiveDateTime = "2016-06-14T02:00:00+12:00"
* valueCodeableConcept = MpdsCS#6D1 "Severe respiratory distress"

Instance: acs-diagnosis-asthma
InstanceOf: AcsEncounterDiagnosis
Usage: #example
Title: "Example Encounter Diagnosis - Asthma"
Description: "Example clinical impression / encounter diagnosis."
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h2>Encounter diagnosis: Asthma</h2><table><tbody><tr><th>Clinical status</th><td>Active</td></tr><tr><th>Category</th><td>Encounter diagnosis</td></tr><tr><th>Diagnosis</th><td>Asthma (SNOMED CT 195967001)</td></tr><tr><th>Patient</th><td>Bob Bobson</td></tr><tr><th>Encounter</th><td>0450-1-2016/06/14</td></tr></tbody></table></div>"
* clinicalStatus = $cond-clinical#active
* category = $cond-category#encounter-diagnosis
* code = $SCT#195967001 "Asthma"
* subject = Reference(acs-patient-bob)
* encounter = Reference(acs-encounter)

Instance: acs-smoking
InstanceOf: AcsSmokingStatus
Usage: #example
Title: "Example Smoking Status"
Description: "Example smoking status."
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h2>Smoking status</h2><table><tbody><tr><th>Status</th><td>Final</td></tr><tr><th>Category</th><td>Social history</td></tr><tr><th>Code</th><td>Tobacco smoking status (LOINC 72166-2)</td></tr><tr><th>Patient</th><td>Bob Bobson</td></tr><tr><th>Effective time</th><td>2016-06-14 11:30 +12:00</td></tr><tr><th>Value</th><td>Ex-smoker (SNOMED CT 8517006)</td></tr></tbody></table></div>"
* status = #final
* category = $obs-category#social-history
* code = $LOINC#72166-2 "Tobacco smoking status"
* subject = Reference(acs-patient-bob)
* effectiveDateTime = "2016-06-14T11:30:00+12:00"
* valueCodeableConcept = $SCT#8517006 "Ex-smoker"

Instance: acs-patient-status
InstanceOf: AcsPatientStatus
Usage: #example
Title: "Example Patient Status"
Description: "Example patient status (threat to life)."
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h2>Patient status</h2><table><tbody><tr><th>Status</th><td>Final</td></tr><tr><th>Category</th><td>Vital signs</td></tr><tr><th>Code</th><td>Clinical status of patient (SNOMED CT 410536001)</td></tr><tr><th>Patient</th><td>Bob Bobson</td></tr><tr><th>Encounter</th><td>0450-1-2016/06/14</td></tr><tr><th>Effective time</th><td>2016-06-14 11:30 +12:00</td></tr><tr><th>Value</th><td>Immediate threat to life</td></tr></tbody></table></div>"
* status = #final
* category = $obs-category#vital-signs
* code = $SCT#410536001 "Clinical status of patient (observable entity)"
* subject = Reference(acs-patient-bob)
* encounter = Reference(acs-encounter)
* effectiveDateTime = "2016-06-14T11:30:00+12:00"
* valueCodeableConcept = AcsPatientStatusCS#immediate-threat

// --- Vital signs (recorded 11:35) ------------------------------------
Instance: acs-hr
InstanceOf: AcsHeartRate
Usage: #example
Title: "Example Heart Rate"
Description: "Example heart rate."
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h2>Heart rate</h2><table><tbody><tr><th>Status</th><td>Final</td></tr><tr><th>Category</th><td>Vital signs</td></tr><tr><th>Code</th><td>Heart rate (LOINC 8867-4)</td></tr><tr><th>Patient</th><td>Bob Bobson</td></tr><tr><th>Encounter</th><td>0450-1-2016/06/14</td></tr><tr><th>Effective time</th><td>2016-06-14 11:35 +12:00</td></tr><tr><th>Value</th><td>136 /min</td></tr></tbody></table></div>"
* status = #final
* category = $obs-category#vital-signs
* code = $LOINC#8867-4 "Heart rate"
* subject = Reference(acs-patient-bob)
* encounter = Reference(acs-encounter)
* effectiveDateTime = "2016-06-14T11:35:00+12:00"
* valueQuantity = 136 '/min'

Instance: acs-rr
InstanceOf: AcsRespiratoryRate
Usage: #example
Title: "Example Respiratory Rate"
Description: "Example respiratory rate."
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h2>Respiratory rate</h2><table><tbody><tr><th>Status</th><td>Final</td></tr><tr><th>Category</th><td>Vital signs</td></tr><tr><th>Code</th><td>Respiratory rate (LOINC 9279-1)</td></tr><tr><th>Patient</th><td>Bob Bobson</td></tr><tr><th>Encounter</th><td>0450-1-2016/06/14</td></tr><tr><th>Effective time</th><td>2016-06-14 11:35 +12:00</td></tr><tr><th>Value</th><td>48 /min</td></tr></tbody></table></div>"
* status = #final
* category = $obs-category#vital-signs
* code = $LOINC#9279-1 "Respiratory rate"
* subject = Reference(acs-patient-bob)
* encounter = Reference(acs-encounter)
* effectiveDateTime = "2016-06-14T11:35:00+12:00"
* valueQuantity = 48 '/min'

Instance: acs-bp
InstanceOf: AcsBloodPressure
Usage: #example
Title: "Example Blood Pressure"
Description: "Example blood pressure."
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h2>Blood pressure</h2><table><tbody><tr><th>Status</th><td>Final</td></tr><tr><th>Category</th><td>Vital signs</td></tr><tr><th>Code</th><td>Blood pressure panel (LOINC 85354-9)</td></tr><tr><th>Patient</th><td>Bob Bobson</td></tr><tr><th>Encounter</th><td>0450-1-2016/06/14</td></tr><tr><th>Effective time</th><td>2016-06-14 11:35 +12:00</td></tr><tr><th>Systolic</th><td>132 mm[Hg] (LOINC 8480-6)</td></tr><tr><th>Diastolic</th><td>90 mm[Hg] (LOINC 8462-4)</td></tr></tbody></table></div>"
* status = #final
* category = $obs-category#vital-signs
* code = $LOINC#85354-9 "Blood pressure panel"
* subject = Reference(acs-patient-bob)
* encounter = Reference(acs-encounter)
* effectiveDateTime = "2016-06-14T11:35:00+12:00"
* component[systolic].code = $LOINC#8480-6 "Systolic blood pressure"
* component[systolic].valueQuantity = 132 'mm[Hg]'
* component[diastolic].code = $LOINC#8462-4 "Diastolic blood pressure"
* component[diastolic].valueQuantity = 90 'mm[Hg]'

Instance: acs-spo2
InstanceOf: AcsOxygenSaturation
Usage: #example
Title: "Example Oxygen Saturation"
Description: "Example SpO2."
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h2>Oxygen saturation</h2><table><tbody><tr><th>Status</th><td>Final</td></tr><tr><th>Category</th><td>Vital signs</td></tr><tr><th>Code</th><td>Oxygen saturation in arterial blood by pulse oximetry (LOINC 59408-5)</td></tr><tr><th>Patient</th><td>Bob Bobson</td></tr><tr><th>Encounter</th><td>0450-1-2016/06/14</td></tr><tr><th>Effective time</th><td>2016-06-14 11:35 +12:00</td></tr><tr><th>Value</th><td>95 %</td></tr></tbody></table></div>"
* status = #final
* category = $obs-category#vital-signs
* code = $LOINC#59408-5 "Oxygen saturation in Arterial blood by Pulse oximetry"
* subject = Reference(acs-patient-bob)
* encounter = Reference(acs-encounter)
* effectiveDateTime = "2016-06-14T11:35:00+12:00"
* valueQuantity = 95 '%'

Instance: acs-temp
InstanceOf: AcsBodyTemperature
Usage: #example
Title: "Example Body Temperature"
Description: "Example temperature."
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h2>Body temperature</h2><table><tbody><tr><th>Status</th><td>Final</td></tr><tr><th>Category</th><td>Vital signs</td></tr><tr><th>Code</th><td>Body temperature (LOINC 8310-5)</td></tr><tr><th>Patient</th><td>Bob Bobson</td></tr><tr><th>Encounter</th><td>0450-1-2016/06/14</td></tr><tr><th>Effective time</th><td>2016-06-14 11:35 +12:00</td></tr><tr><th>Value</th><td>38.6 Cel</td></tr></tbody></table></div>"
* status = #final
* category = $obs-category#vital-signs
* code = $LOINC#8310-5 "Body temperature"
* subject = Reference(acs-patient-bob)
* encounter = Reference(acs-encounter)
* effectiveDateTime = "2016-06-14T11:35:00+12:00"
* valueQuantity = 38.6 'Cel'

Instance: acs-bgl
InstanceOf: AcsBloodGlucose
Usage: #example
Title: "Example Blood Glucose Level"
Description: "Example BGL."
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h2>Blood glucose level</h2><table><tbody><tr><th>Status</th><td>Final</td></tr><tr><th>Category</th><td>Vital signs</td></tr><tr><th>Code</th><td>Glucose in blood (LOINC 15074-8)</td></tr><tr><th>Patient</th><td>Bob Bobson</td></tr><tr><th>Encounter</th><td>0450-1-2016/06/14</td></tr><tr><th>Effective time</th><td>2016-06-14 11:35 +12:00</td></tr><tr><th>Value</th><td>4.0 mmol/L</td></tr></tbody></table></div>"
* status = #final
* category = $obs-category#vital-signs
* code = $LOINC#15074-8 "Glucose [Moles/volume] in Blood"
* subject = Reference(acs-patient-bob)
* encounter = Reference(acs-encounter)
* effectiveDateTime = "2016-06-14T11:35:00+12:00"
* valueQuantity = 4.0 'mmol/L'

Instance: acs-gcs
InstanceOf: AcsGlasgowComaScore
Usage: #example
Title: "Example Glasgow Coma Score"
Description: "Example GCS total."
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h2>Glasgow coma score total</h2><table><tbody><tr><th>Status</th><td>Final</td></tr><tr><th>Category</th><td>Vital signs</td></tr><tr><th>Code</th><td>Glasgow coma score total (LOINC 9269-2)</td></tr><tr><th>Patient</th><td>Bob Bobson</td></tr><tr><th>Encounter</th><td>0450-1-2016/06/14</td></tr><tr><th>Effective time</th><td>2016-06-14 11:35 +12:00</td></tr><tr><th>Value</th><td>15 {score}</td></tr></tbody></table></div>"
* status = #final
* category = $obs-category#vital-signs
* code = $LOINC#9269-2 "Glasgow coma score total"
* subject = Reference(acs-patient-bob)
* encounter = Reference(acs-encounter)
* effectiveDateTime = "2016-06-14T11:35:00+12:00"
* valueQuantity = 15 '{score}'

Instance: acs-pain
InstanceOf: AcsPainScore
Usage: #example
Title: "Example Pain Score"
Description: "Example pain score."
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h2>Pain score</h2><table><tbody><tr><th>Status</th><td>Final</td></tr><tr><th>Category</th><td>Vital signs</td></tr><tr><th>Code</th><td>Pain severity 0-10 verbal numeric rating (LOINC 72514-3)</td></tr><tr><th>Patient</th><td>Bob Bobson</td></tr><tr><th>Encounter</th><td>0450-1-2016/06/14</td></tr><tr><th>Effective time</th><td>2016-06-14 11:35 +12:00</td></tr><tr><th>Value</th><td>5 {score}</td></tr></tbody></table></div>"
* status = #final
* category = $obs-category#vital-signs
* code = $LOINC#72514-3 "Pain severity - 0-10 verbal numeric rating [Score] - Reported"
* subject = Reference(acs-patient-bob)
* encounter = Reference(acs-encounter)
* effectiveDateTime = "2016-06-14T11:35:00+12:00"
* valueQuantity = 5 '{score}'

Instance: acs-ecg
InstanceOf: AcsEcgInterpretation
Usage: #example
Title: "Example ECG Interpretation"
Description: "Example ECG interpretation."
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h2>ECG interpretation</h2><table><tbody><tr><th>Status</th><td>Final</td></tr><tr><th>Category</th><td>Vital signs</td></tr><tr><th>Code</th><td>Heart rate rhythm (LOINC 8884-9)</td></tr><tr><th>Patient</th><td>Bob Bobson</td></tr><tr><th>Encounter</th><td>0450-1-2016/06/14</td></tr><tr><th>Effective time</th><td>2016-06-14 11:35 +12:00</td></tr><tr><th>Value</th><td>Atrial flutter</td></tr></tbody></table></div>"
* status = #final
* category = $obs-category#vital-signs
* code = $LOINC#8884-9 "Heart rate rhythm"
* subject = Reference(acs-patient-bob)
* encounter = Reference(acs-encounter)
* effectiveDateTime = "2016-06-14T11:35:00+12:00"
* valueCodeableConcept = AcsEcgInterpretationCS#aflutter

Instance: acs-skin
InstanceOf: AcsSkinCondition
Usage: #example
Title: "Example Skin Condition"
Description: "Example skin condition."
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h2>Skin condition</h2><table><tbody><tr><th>Status</th><td>Final</td></tr><tr><th>Category</th><td>Vital signs</td></tr><tr><th>Code</th><td>General skin examination (SNOMED CT 225544001)</td></tr><tr><th>Patient</th><td>Bob Bobson</td></tr><tr><th>Encounter</th><td>0450-1-2016/06/14</td></tr><tr><th>Effective time</th><td>2016-06-14 11:35 +12:00</td></tr><tr><th>Value</th><td>Diaphoretic (sweaty)</td></tr></tbody></table></div>"
* status = #final
* category = $obs-category#vital-signs
* code = $SCT#225544001 "General skin examination"
* subject = Reference(acs-patient-bob)
* encounter = Reference(acs-encounter)
* effectiveDateTime = "2016-06-14T11:35:00+12:00"
* valueCodeableConcept = AcsSkinConditionCS#diaphoretic

// --- Medication administered -----------------------------------------
Instance: acs-medadmin-adenosine
InstanceOf: AcsMedicationAdministration
Usage: #example
Title: "Example Medication Administration - Adenosine 6mg IV"
Description: "Example medication administration."
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h2>Medication administration: Adenosine</h2><table><tbody><tr><th>Status</th><td>Completed</td></tr><tr><th>Medication</th><td>Adenosine</td></tr><tr><th>Patient</th><td>Bob Bobson</td></tr><tr><th>Encounter</th><td>0450-1-2016/06/14</td></tr><tr><th>Effective time</th><td>2016-06-14 11:36 +12:00</td></tr><tr><th>Performer</th><td>Josephine Manu-Bloggs, paramedic</td></tr><tr><th>Route</th><td>Intravenous route</td></tr><tr><th>Dose</th><td>6 mg</td></tr><tr><th>Note</th><td>A note about Adenosine</td></tr></tbody></table></div>"
* status = #completed
* medicationCodeableConcept.text = "Adenosine"
* subject = Reference(acs-patient-bob)
* context = Reference(acs-encounter)
* effectiveDateTime = "2016-06-14T11:36:00+12:00"
* performer.actor = Reference(acs-providerrole-josephine)
* dosage.route = AcsRouteCS#iv
* dosage.dose = 6 'mg'
* note.text = "A note about Adenosine"

// --- Procedures ------------------------------------------------------
Instance: acs-proc-airway
InstanceOf: AcsProcedure
Usage: #example
Title: "Example Procedure - Airway manual clear"
Description: "Example procedure (airway management - manual clear)."
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h2>Procedure: Manual clearance of airway</h2><table><tbody><tr><th>Status</th><td>Completed</td></tr><tr><th>Code</th><td>Manual clearance of airway (SNOMED CT 241689008)</td></tr><tr><th>Patient</th><td>Bob Bobson</td></tr><tr><th>Encounter</th><td>0450-1-2016/06/14</td></tr><tr><th>Performed</th><td>2016-06-14 12:00 +12:00</td></tr><tr><th>Performer</th><td>Josephine Manu-Bloggs, paramedic</td></tr><tr><th>Note</th><td>A note about Airway Management</td></tr></tbody></table></div>"
* status = #completed
* code = $SCT#241689008 "Manual clearance of airway"
* subject = Reference(acs-patient-bob)
* encounter = Reference(acs-encounter)
* performedDateTime = "2016-06-14T12:00:00+12:00"
* performer.actor = Reference(acs-providerrole-josephine)
* note.text = "A note about Airway Management"

Instance: acs-proc-defib
InstanceOf: AcsProcedure
Usage: #example
Title: "Example Procedure - Defibrillation"
Description: "Example procedure (defibrillation)."
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h2>Procedure: Cardiac defibrillation</h2><table><tbody><tr><th>Status</th><td>Completed</td></tr><tr><th>Code</th><td>Cardiac defibrillation (SNOMED CT 429500007)</td></tr><tr><th>Patient</th><td>Bob Bobson</td></tr><tr><th>Encounter</th><td>0450-1-2016/06/14</td></tr><tr><th>Performed</th><td>2016-06-14 12:06 +12:00</td></tr><tr><th>Performer</th><td>Josephine Manu-Bloggs, paramedic</td></tr><tr><th>Outcome</th><td>Successful (SNOMED CT 385669000)</td></tr></tbody></table></div>"
* status = #completed
* code = $SCT#429500007 "Cardiac defibrillation"
* subject = Reference(acs-patient-bob)
* encounter = Reference(acs-encounter)
* performedDateTime = "2016-06-14T12:06:00+12:00"
* performer.actor = Reference(acs-providerrole-josephine)
* outcome = $SCT#385669000 "Successful"

// --- Care plan -------------------------------------------------------
Instance: acs-careplan
InstanceOf: AcsCarePlan
Usage: #example
Title: "Example Care Plan"
Description: "Example care plan with advice to the patient's GP."
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h2>Care plan</h2><table><tbody><tr><th>Status</th><td>Active</td></tr><tr><th>Intent</th><td>Plan</td></tr><tr><th>Patient</th><td>Bob Bobson</td></tr><tr><th>Encounter</th><td>0450-1-2016/06/14</td></tr><tr><th>Description</th><td>Recommend GP appointment to review medication.</td></tr><tr><th>Note</th><td>Recommend GP appt to get more meds</td></tr></tbody></table></div>"
* status = #active
* intent = #plan
* subject = Reference(acs-patient-bob)
* encounter = Reference(acs-encounter)
* description = "Recommend GP appointment to review medication."
* note.text = "Recommend GP appt to get more meds"
