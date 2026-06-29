// =====================================================================
// Worked example - Composition and document Bundle
// =====================================================================

Instance: acs-composition
InstanceOf: AmbulanceCareSummaryComposition
Usage: #example
Title: "Example Ambulance Care Summary Composition"
Description: "Example composition structuring the ambulance care summary document."
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h2>Ambulance Care Summary</h2><table><tbody><tr><th>Document identifier</th><td>1453821363387010</td></tr><tr><th>Status</th><td>Final</td></tr><tr><th>Type</th><td>Ambulance Care Summary (LOINC 74207-2)</td></tr><tr><th>Patient</th><td>Bob Bobson</td></tr><tr><th>Encounter</th><td>0450-1-2016/06/14</td></tr><tr><th>Date</th><td>2016-06-14 12:42 +12:00</td></tr><tr><th>Author</th><td>Josephine Manu-Bloggs at Order of St John</td></tr><tr><th>Custodian</th><td>Order of St John</td></tr></tbody></table><p>The document includes incident details, smoking status, presenting problems, vital signs, medication administered, procedures, and follow-up care plan.</p></div>"
* identifier.system = "https://standards.digital.health.nz/ns/ambulance-care-summary-id"
* identifier.value = "1453821363387010"
* status = #final
* type = $LOINC#74207-2 "Ambulance Care Summary"
* subject = Reference(acs-patient-bob)
* encounter = Reference(acs-encounter)
* date = "2016-06-14T12:42:00+12:00"
* author = Reference(acs-providerrole-josephine)
* title = "Ambulance Care Summary"
* custodian = Reference(acs-org-stjohn)

* section[encounter].title = "Incident / Encounter"
* section[encounter].code = $LOINC#46240-8 "History of encounters"
* section[encounter].text.status = #generated
* section[encounter].text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h3>Incident / Encounter</h3><table><tbody><tr><th>Incident</th><td>0450-1-2016/06/14</td></tr><tr><th>Type</th><td>Land ambulance emergency encounter</td></tr><tr><th>Period</th><td>2016-06-14 11:13 to 12:42 +12:00</td></tr><tr><th>Patient status</th><td>Immediate threat to life at 11:30 +12:00</td></tr><tr><th>Disposition</th><td>Treat and transport to Sunshine Hospital Emergency Department</td></tr></tbody></table></div>"
* section[encounter].entry[0].reference = "https://example.org/fhir/Encounter/acs-encounter"
* section[encounter].entry[1].reference = "https://example.org/fhir/Observation/acs-patient-status"

* section[socialHistory].title = "Smoking and Vaping"
* section[socialHistory].code = $LOINC#29762-2 "Social history"
* section[socialHistory].text.status = #generated
* section[socialHistory].text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h3>Smoking and Vaping</h3><table><tbody><tr><th>Smoking status</th><td>Ex-smoker recorded at 2016-06-14 11:30 +12:00</td></tr><tr><th>Vaping status</th><td>No vaping status example recorded</td></tr></tbody></table></div>"
* section[socialHistory].entry[0].reference = "https://example.org/fhir/Observation/acs-smoking"

* section[problems].title = "Problems"
* section[problems].code = $LOINC#10154-3 "Chief complaint"
* section[problems].text.status = #generated
* section[problems].text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h3>Problems</h3><table><tbody><tr><th>Presenting complaint</th><td>Severe respiratory distress (MPDS 6D1)</td></tr><tr><th>Encounter diagnosis</th><td>Asthma (SNOMED CT 195967001), active</td></tr></tbody></table></div>"
* section[problems].entry[0].reference = "https://example.org/fhir/Observation/acs-presenting-complaint"
* section[problems].entry[1].reference = "https://example.org/fhir/Condition/acs-diagnosis-asthma"

* section[vitalSigns].title = "Measurements and Vital Signs"
* section[vitalSigns].code = $LOINC#8716-3 "Vital signs"
* section[vitalSigns].text.status = #generated
* section[vitalSigns].text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h3>Measurements and Vital Signs</h3><table><tbody><tr><th>Recorded time</th><td>2016-06-14 11:35 +12:00</td></tr><tr><th>Heart rate</th><td>136 /min</td></tr><tr><th>Respiratory rate</th><td>48 /min</td></tr><tr><th>Blood pressure</th><td>132/90 mm[Hg]</td></tr><tr><th>SpO2</th><td>95 %</td></tr><tr><th>Body temperature</th><td>38.6 Cel</td></tr><tr><th>Blood glucose</th><td>4.0 mmol/L</td></tr><tr><th>Glasgow coma score</th><td>15 {score}</td></tr><tr><th>Pain score</th><td>5 {score}</td></tr><tr><th>ECG interpretation</th><td>Atrial flutter</td></tr><tr><th>Skin condition</th><td>Diaphoretic (sweaty)</td></tr></tbody></table></div>"
* section[vitalSigns].entry[0].reference = "https://example.org/fhir/Observation/acs-hr"
* section[vitalSigns].entry[1].reference = "https://example.org/fhir/Observation/acs-rr"
* section[vitalSigns].entry[2].reference = "https://example.org/fhir/Observation/acs-bp"
* section[vitalSigns].entry[3].reference = "https://example.org/fhir/Observation/acs-spo2"
* section[vitalSigns].entry[4].reference = "https://example.org/fhir/Observation/acs-temp"
* section[vitalSigns].entry[5].reference = "https://example.org/fhir/Observation/acs-bgl"
* section[vitalSigns].entry[6].reference = "https://example.org/fhir/Observation/acs-gcs"
* section[vitalSigns].entry[7].reference = "https://example.org/fhir/Observation/acs-pain"
* section[vitalSigns].entry[8].reference = "https://example.org/fhir/Observation/acs-ecg"
* section[vitalSigns].entry[9].reference = "https://example.org/fhir/Observation/acs-skin"

* section[medicationsAdministered].title = "Medications Administered or Supplied"
* section[medicationsAdministered].code = $LOINC#29549-3 "Medication administered"
* section[medicationsAdministered].text.status = #generated
* section[medicationsAdministered].text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h3>Medications Administered or Supplied</h3><table><tbody><tr><th>Medication</th><td>Adenosine</td></tr><tr><th>Time</th><td>2016-06-14 11:36 +12:00</td></tr><tr><th>Dose and route</th><td>6 mg by intravenous route</td></tr><tr><th>Performer</th><td>Josephine Manu-Bloggs, paramedic</td></tr></tbody></table></div>"
* section[medicationsAdministered].entry[0].reference = "https://example.org/fhir/MedicationAdministration/acs-medadmin-adenosine"

* section[procedures].title = "Procedures"
* section[procedures].code = $LOINC#47519-4 "History of procedures"
* section[procedures].text.status = #generated
* section[procedures].text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h3>Procedures</h3><table><tbody><tr><th>12:00 +12:00</th><td>Manual clearance of airway by Josephine Manu-Bloggs</td></tr><tr><th>12:06 +12:00</th><td>Cardiac defibrillation by Josephine Manu-Bloggs; outcome successful</td></tr></tbody></table></div>"
* section[procedures].entry[0].reference = "https://example.org/fhir/Procedure/acs-proc-airway"
* section[procedures].entry[1].reference = "https://example.org/fhir/Procedure/acs-proc-defib"

* section[carePlan].title = "Care Plan"
* section[carePlan].code = $LOINC#18776-5 "Plan of care"
* section[carePlan].text.status = #generated
* section[carePlan].text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h3>Care Plan</h3><table><tbody><tr><th>Status</th><td>Active</td></tr><tr><th>Intent</th><td>Plan</td></tr><tr><th>Advice</th><td>Recommend GP appointment to review medication.</td></tr><tr><th>Note</th><td>Recommend GP appt to get more meds</td></tr></tbody></table></div>"
* section[carePlan].entry[0].reference = "https://example.org/fhir/CarePlan/acs-careplan"


Instance: AmbulanceCareSummaryExample
InstanceOf: AmbulanceCareSummaryBundle
Usage: #example
Title: "Example Ambulance Care Summary Document"
Description: "A complete worked example of an Ambulance Care Summary FHIR document, derived from the reference CDA example."
* identifier.system = "https://standards.digital.health.nz/ns/ambulance-care-summary-id"
* identifier.value = "1453821363387010"
* type = #document
* timestamp = "2016-06-14T12:42:00+12:00"
* entry[+].fullUrl = "https://example.org/fhir/Composition/acs-composition"
* entry[=].resource = acs-composition
* entry[+].fullUrl = "https://example.org/fhir/Patient/acs-patient-bob"
* entry[=].resource = acs-patient-bob
* entry[+].fullUrl = "https://example.org/fhir/Practitioner/acs-clinician-josephine"
* entry[=].resource = acs-clinician-josephine
* entry[+].fullUrl = "https://example.org/fhir/PractitionerRole/acs-providerrole-josephine"
* entry[=].resource = acs-providerrole-josephine
* entry[+].fullUrl = "https://example.org/fhir/Organization/acs-org-stjohn"
* entry[=].resource = acs-org-stjohn
* entry[+].fullUrl = "https://example.org/fhir/Location/acs-facility-sunshine"
* entry[=].resource = acs-facility-sunshine
* entry[+].fullUrl = "https://example.org/fhir/Encounter/acs-encounter"
* entry[=].resource = acs-encounter
* entry[+].fullUrl = "https://example.org/fhir/Observation/acs-presenting-complaint"
* entry[=].resource = acs-presenting-complaint
* entry[+].fullUrl = "https://example.org/fhir/Condition/acs-diagnosis-asthma"
* entry[=].resource = acs-diagnosis-asthma
* entry[+].fullUrl = "https://example.org/fhir/Observation/acs-smoking"
* entry[=].resource = acs-smoking
* entry[+].fullUrl = "https://example.org/fhir/Observation/acs-patient-status"
* entry[=].resource = acs-patient-status
* entry[+].fullUrl = "https://example.org/fhir/Observation/acs-hr"
* entry[=].resource = acs-hr
* entry[+].fullUrl = "https://example.org/fhir/Observation/acs-rr"
* entry[=].resource = acs-rr
* entry[+].fullUrl = "https://example.org/fhir/Observation/acs-bp"
* entry[=].resource = acs-bp
* entry[+].fullUrl = "https://example.org/fhir/Observation/acs-spo2"
* entry[=].resource = acs-spo2
* entry[+].fullUrl = "https://example.org/fhir/Observation/acs-temp"
* entry[=].resource = acs-temp
* entry[+].fullUrl = "https://example.org/fhir/Observation/acs-bgl"
* entry[=].resource = acs-bgl
* entry[+].fullUrl = "https://example.org/fhir/Observation/acs-gcs"
* entry[=].resource = acs-gcs
* entry[+].fullUrl = "https://example.org/fhir/Observation/acs-pain"
* entry[=].resource = acs-pain
* entry[+].fullUrl = "https://example.org/fhir/Observation/acs-ecg"
* entry[=].resource = acs-ecg
* entry[+].fullUrl = "https://example.org/fhir/Observation/acs-skin"
* entry[=].resource = acs-skin
* entry[+].fullUrl = "https://example.org/fhir/MedicationAdministration/acs-medadmin-adenosine"
* entry[=].resource = acs-medadmin-adenosine
* entry[+].fullUrl = "https://example.org/fhir/Procedure/acs-proc-airway"
* entry[=].resource = acs-proc-airway
* entry[+].fullUrl = "https://example.org/fhir/Procedure/acs-proc-defib"
* entry[=].resource = acs-proc-defib
* entry[+].fullUrl = "https://example.org/fhir/CarePlan/acs-careplan"
* entry[=].resource = acs-careplan
