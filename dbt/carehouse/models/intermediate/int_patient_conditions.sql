{{
    config(
        materialized='table'
    )
}}

SELECT
    p.patient_id,
    c.encounter_id,
    c.start_date,
    c.end_date,
    p.birth_date,
    p.gender,
    p.race,
    p.ethnicity,
    p.city,
    p.state,
    p.zip_code,
    p.healthcare_expenses,
    p.healthcare_coverage,
    c.code AS condition_code,
    c.description AS condition_description
FROM {{ ref('stg_patients') }} p
LEFT JOIN {{ ref('stg_conditions') }} c
    ON p.patient_id = c.patient_id
