{{
    config(
        materialized='table'
    )
}}

SELECT 
    Id AS claim_id,
    PATIENTID AS patient_id,
    PROVIDERID AS provider_id,
    PRIMARYPATIENTINSURANCEID AS primary_patient_insurance_id,
    SECONDARYPATIENTINSURANCEID AS secondary_patient_insurance_id,
    DEPARTMENTID AS department_id,
    PATIENTDEPARTMENTID AS patient_department_id,
    DIAGNOSIS1 AS first_diagnosis,
    DIAGNOSIS2 AS second_diagnosis,
    DIAGNOSIS3 AS third_diagnosis,
    DIAGNOSIS4 AS fourth_diagnosis,
    DIAGNOSIS5 AS fifth_diagnosis,
    DIAGNOSIS6 AS sixth_diagnosis,
    DIAGNOSIS7 AS seventh_diagnosis,
    DIAGNOSIS8 AS eighth_diagnosis,
    REFERRINGPROVIDERID AS referring_provider_id,
    APPOINTMENTID AS appointment_id,
    CURRENTILLNESSDATE AS current_illness_date,
    SERVICEDATE AS service_date,
    SUPERVISINGPROVIDERID AS supervising_provider_id,
    STATUS1 AS first_status,
    STATUS2 AS second_status,
    STATUSP AS status_p,
    OUTSTANDING1 AS first_outstanding,
    OUTSTANDING2 AS second_outstanding,
    OUTSTANDINGP AS outstanding_p,
    LASTBILLEDDATE1 AS last_billed_date_first,
    LASTBILLEDDATE2 AS last_billed_date_second,
    LASTBILLEDDATEP AS last_billed_date_p,
    HEALTHCARECLAIMTYPEID1 AS healthcare_claim_type_1,
    HEALTHCARECLAIMTYPEID2 AS healthcare_claim_type_2 
FROM healthcare.raw.claims