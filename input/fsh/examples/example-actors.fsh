// =====================================================================
// Worked example - provider actors
// Data derived from reference-material/ambulanceCareSummaryCDAExample.xml
// =====================================================================

Instance: acs-patient-bob
InstanceOf: AmbulanceCareSummaryPatient
Usage: #example
Title: "Example Patient - Bob Bobson"
Description: "Example ambulance care summary patient."
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h2>Patient: Bob Bobson</h2><table><tbody><tr><th>Identifier</th><td>NHI ABC1235</td></tr><tr><th>Name</th><td>Mr Bob Bobby Bobson</td></tr><tr><th>Gender</th><td>Male</td></tr><tr><th>Sex at birth</th><td>Male</td></tr><tr><th>Date of birth</th><td>1984-06-02</td></tr><tr><th>Phone</th><td>(03) 444 7890 home; (027) 7878 7878 mobile</td></tr><tr><th>Email</th><td>bob@bobson.org.nz</td></tr><tr><th>Address</th><td>Bobs Big Building, 17 Bobson Boulevard, Boganville 6789, New Zealand</td></tr></tbody></table></div>"
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
* telecom[1].value = "(027) 7878 7878"
* telecom[1].use = #mobile
* telecom[2].system = #email
* telecom[2].value = "bob@bobson.org.nz"
* address.use = #home
* address.line[0] = "Bobs Big Building"
* address.line[1] = "17 Bobson Boulevard"
* address.district = "Baldrick"
* address.city = "Boganville"
* address.postalCode = "6789"
* address.country = "New Zealand"

Instance: acs-clinician-josephine
InstanceOf: AmbulanceClinician
Usage: #example
Title: "Example Clinician - Josephine Manu-Bloggs"
Description: "Example attending ambulance clinician (paramedic)."
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h2>Clinician: Josephine Manu-Bloggs</h2><table><tbody><tr><th>Role in example</th><td>Attending ambulance clinician</td></tr><tr><th>Identifier</th><td>Paramedic Council Register Number 100901</td></tr><tr><th>Name</th><td>Josephine Manu-Bloggs</td></tr></tbody></table></div>"
* identifier[paramedicCouncil].system = $paramedic-council
* identifier[paramedicCouncil].value = "100901"
* name.use = #official
* name.given = "Josephine"
* name.family = "Manu-Bloggs"

Instance: acs-org-stjohn
InstanceOf: AmbulanceServiceOrganization
Usage: #example
Title: "Example Ambulance Operator - Order of St John"
Description: "Example ambulance operator organisation."
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h2>Ambulance operator: Order of St John</h2><table><tbody><tr><th>Identifier</th><td>HPI Organisation G02780-A</td></tr><tr><th>Name</th><td>Order of St John</td></tr><tr><th>Phone</th><td>+6495791015 work</td></tr></tbody></table></div>"
* identifier[hpiOrg].system = $hpi-org
* identifier[hpiOrg].value = "G02780-A"
* name = "Order of St John"
* telecom.system = #phone
* telecom.value = "+6495791015"
* telecom.use = #work

Instance: acs-providerrole-josephine
InstanceOf: AmbulanceServiceProviderRole
Usage: #example
Title: "Example Provider Role - Josephine at St John"
Description: "Example role linking the attending clinician to the ambulance operator."
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h2>Provider role: Josephine Manu-Bloggs at Order of St John</h2><table><tbody><tr><th>Practitioner</th><td>Josephine Manu-Bloggs</td></tr><tr><th>Organization</th><td>Order of St John</td></tr><tr><th>Role code</th><td>Paramedic (SNOMED CT 397897005)</td></tr></tbody></table></div>"
* practitioner = Reference(acs-clinician-josephine)
* organization = Reference(acs-org-stjohn)
* code = $SCT#397897005 "Paramedic"

Instance: acs-facility-sunshine
InstanceOf: ReceivingFacility
Usage: #example
Title: "Example Receiving Facility - Sunshine Hospital ED"
Description: "Example receiving facility (hospital emergency department)."
* text.status = #generated
* text.div = "<div xmlns='http://www.w3.org/1999/xhtml'><h2>Receiving facility: Sunshine Hospital Emergency Department</h2><table><tbody><tr><th>Status</th><td>Active</td></tr><tr><th>Name</th><td>Sunshine Hospital Emergency Department</td></tr><tr><th>Role in example</th><td>Receiving emergency department for the transported patient</td></tr></tbody></table></div>"
* name = "Sunshine Hospital Emergency Department"
* status = #active
