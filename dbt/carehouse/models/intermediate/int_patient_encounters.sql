{{
    config(
        materialized='table'
    )
}}

SELECT 
    p.patient_id,
    e.encounter_id,
    e.start_date,
    e.end_date,
    e.organization_id,
    e.provider_id,
    e.payer_id,
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
    e.encounter_class,
    e.code,
    e.description,
    e.base_encounter_cost,
    e.total_claim_cost,
    e.payer_coverage,
    e.reason_code,
    e.reason_description    
FROM {{ ref('stg_patients') }} p  
LEFT JOIN {{ ref('stg_encounters') }} e
    ON p.patient_id = e.patient_id 
