{{
    config(
        materialized='table'
    )
}}

SELECT
    p.patient_id,
    o.encounter_id,
    o.observation_date,
    p.birth_date,
    p.gender,
    p.race,
    p.ethnicity,
    p.city,
    p.state,
    p.zip_code,
    p.healthcare_expenses,
    p.healthcare_coverage,
    o.category,
    o.code AS observation_code,
    o.description AS observation_description,
    o.value AS observation_value,
    o.units,
    o.type AS observation_type
FROM {{ ref('stg_patients') }} p
LEFT JOIN {{ ref('stg_observations') }} o
    ON p.patient_id = o.patient_id
