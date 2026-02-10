{{
    config(
        materialized='table'
    )
}}

SELECT
    p.patient_id,
    m.encounter_id,
    m.payer_id,
    m.start_date,
    m.end_date,
    p.birth_date,
    p.gender,
    p.race,
    p.ethnicity,
    p.city,
    p.state,
    p.zip_code,
    p.healthcare_expenses,
    p.healthcare_coverage,
    m.code AS medication_code,
    m.description AS medication_description,
    m.base_cost,
    m.payer_coverage,
    m.dispenses,
    m.total_cost,
    m.reason_code,
    m.reason_description
FROM {{ ref('stg_patients') }} p
LEFT JOIN {{ ref('stg_medications') }} m
    ON p.patient_id = m.patient_id
