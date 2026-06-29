// =====================================================================
// Provider actors - HISO 10052:2026 §1.8.5 Health care provider info
// =====================================================================

Profile: AmbulanceClinician
Parent: $NzPractitioner
Id: ambulance-clinician
Title: "Ambulance Clinician"
Description: "A practitioner who provides clinical services on behalf of an ambulance operator (paramedic, doctor, nurse, or a person with delegated authority to practice). Based on NZ Base NzPractitioner."
* identifier MS
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier contains
    hpiCpn 0..1 MS and
    paramedicCouncil 0..1 MS
* identifier[hpiCpn].system = $hpi-person
* identifier[hpiCpn] ^short = "HPI Common Person Number (CPN)"
* identifier[paramedicCouncil].system = $paramedic-council
* identifier[paramedicCouncil] ^short = "Paramedic Council registration number"
* name 1..* MS


Profile: AmbulanceServiceProviderRole
Parent: $NzPractitionerRole
Id: ambulance-service-provider-role
Title: "Ambulance Service Provider Role"
Description: "The role of an ambulance clinician acting for an ambulance operator. Based on NZ Base NzPractitionerRole."
* practitioner 1..1 MS
* practitioner only Reference(AmbulanceClinician)
* organization 1..1 MS
* organization only Reference(AmbulanceServiceOrganization)
* code MS
* code ^short = "Qualification / role of the clinician (e.g. paramedic)"


Profile: AmbulanceServiceOrganization
Parent: $NzOrganization
Id: ambulance-service-organization
Title: "Ambulance Service Organization"
Description: "An organisation that provides road or air ambulance services in New Zealand (ambulance operator), or another provider organisation. Based on NZ Base NzOrganization."
* identifier MS
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier contains hpiOrg 0..1 MS
* identifier[hpiOrg].system = $hpi-org
* identifier[hpiOrg] ^short = "HPI Organisation identifier (includes check digit)"
* name 1..1 MS


Profile: ReceivingFacility
Parent: $NzLocation
Id: receiving-facility
Title: "Receiving Facility"
Description: "The facility (e.g. a hospital emergency department) a transported patient was taken to (HISO 10052:2026 §2.3 Receiving facility). Based on NZ Base NzLocation."
* identifier MS
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier contains hpiFacility 0..1 MS
* identifier[hpiFacility].system = $hpi-facility
* identifier[hpiFacility] ^short = "HPI Facility identifier (includes check digit)"
* name 1..1 MS
