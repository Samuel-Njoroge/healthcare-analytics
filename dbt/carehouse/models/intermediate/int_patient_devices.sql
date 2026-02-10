{{
    config(
        materialized='table'
    )
}}

SELECT
    p.patient_id,
    d.encounter_id,
    d.start_date,
    d.end_date,
    p.birth_date,
    p.gender,
    p.race,
    p.ethnicity,
    p.city,
    p.state,
    p.zip_code,
    p.healthcare_expenses,
    p.healthcare_coverage,
    d.code AS device_code,
    d.description AS device_description,
    d.unique_device_identifier
FROM {{ ref('stg_patients') }} p
LEFT JOIN {{ ref('stg_devices') }} d
    ON p.patient_id = d.patient_id
