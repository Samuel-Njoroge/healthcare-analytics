{{
    config(
        materialized='table'
    )
}}

SELECT 
    p.patient_id,
    c.care_plan_id,
    c.encounter_id,
    c.start_date,
    c.end_date,
    p.birth_date,
    p.death_date,
    p.social_security_number,
    p.drivers_license,
    p.passport,
    p.first_name,
    p.last_name,
    p.maiden,
    p.marital_status,
    p.race,
    p.ethnicity,
    p.gender,
    p.birthplace,
    p.address,
    p.city,
    p.state,
    p.county,
    p.zip_code,
    p.latitude, 
    p.longitude,
    p.healthcare_expenses,
    p.healthcare_coverage,
    c.code AS care_plan_code,
    c.reason_code
FROM ref {{ ('stg_patients') }} p  
LEFT JOIN {{ ('stg_care_plans') }} c
    ON p.patient_id = c.patient_id 