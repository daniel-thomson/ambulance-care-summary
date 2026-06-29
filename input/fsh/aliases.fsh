// =====================================================================
// Common aliases used across the Ambulance Care Summary IG
// =====================================================================

// Terminology systems
Alias: $SCT          = http://snomed.info/sct
Alias: $LOINC        = http://loinc.org
Alias: $UCUM         = http://unitsofmeasure.org
Alias: $ICD10        = http://hl7.org/fhir/sid/icd-10
Alias: $absent       = http://terminology.hl7.org/CodeSystem/data-absent-reason
Alias: $obs-category = http://terminology.hl7.org/CodeSystem/observation-category
Alias: $cond-category = http://terminology.hl7.org/CodeSystem/condition-category
Alias: $cond-ver     = http://terminology.hl7.org/CodeSystem/condition-ver-status
Alias: $cond-clinical = http://terminology.hl7.org/CodeSystem/condition-clinical
Alias: $allerg-clinical = http://terminology.hl7.org/CodeSystem/allergyintolerance-clinical
Alias: $allerg-verification = http://terminology.hl7.org/CodeSystem/allergyintolerance-verification
Alias: $v3-ActCode   = http://terminology.hl7.org/CodeSystem/v3-ActCode
Alias: $v3-ActClass  = http://terminology.hl7.org/CodeSystem/v3-ActClass
Alias: $v3-RoleCode  = http://terminology.hl7.org/CodeSystem/v3-RoleCode
Alias: $v2-0203      = http://terminology.hl7.org/CodeSystem/v2-0203

// NZ identifier namespaces (from NZ Base NamingSystems)
Alias: $nhi          = https://standards.digital.health.nz/ns/nhi-id
Alias: $hpi-person   = https://standards.digital.health.nz/ns/hpi-person-id
Alias: $hpi-org      = https://standards.digital.health.nz/ns/hpi-organisation-id
Alias: $hpi-facility = https://standards.digital.health.nz/ns/hpi-facility-id
Alias: $paramedic-council = https://standards.digital.health.nz/ns/paramedic-council-id
Alias: $acc-claim    = https://standards.digital.health.nz/ns/acc-claim-number

// NZ Base profiles (parents where they exist)
Alias: $NzPatient            = http://hl7.org.nz/fhir/StructureDefinition/NzPatient
Alias: $NzPractitioner       = http://hl7.org.nz/fhir/StructureDefinition/NzPractitioner
Alias: $NzPractitionerRole   = http://hl7.org.nz/fhir/StructureDefinition/NzPractitionerRole
Alias: $NzOrganization       = http://hl7.org.nz/fhir/StructureDefinition/NzOrganization
Alias: $NzLocation           = http://hl7.org.nz/fhir/StructureDefinition/NzLocation
Alias: $NzRelatedPerson      = http://hl7.org.nz/fhir/StructureDefinition/NzRelatedPerson
Alias: $NzCondition          = http://hl7.org.nz/fhir/StructureDefinition/NzCondition
Alias: $NzMedicationStatement = http://hl7.org.nz/fhir/StructureDefinition/NzMedicationStatement
Alias: $NzMedicationDispense  = http://hl7.org.nz/fhir/StructureDefinition/NzMedicationDispense

// NZ Base extensions reused here
Alias: $nz-sex-at-birth = http://hl7.org.nz/fhir/StructureDefinition/sex-at-birth
Alias: $nz-ethnicity    = http://hl7.org.nz/fhir/StructureDefinition/nz-ethnicity
Alias: $nz-death-date   = http://hl7.org.nz/fhir/StructureDefinition/death-date
