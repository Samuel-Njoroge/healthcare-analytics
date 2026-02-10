{{
    config(
        materialized='table'
    )
}}

SELECT
    p.patient_id,
    s.encounter_id,
    s.supply_date,
    p.birth_date,
    p.gender,
    p.race,
    p.ethnicity,
    p.city,
    p.state,
    p.zip_code,
    p.healthcare_expenses,
    p.healthcare_coverage,
    s.code AS supply_code,
    s.description AS supply_description,
    s.quantity
FROM {{ ref('stg_patients') }} p
LEFT JOIN {{ ref('stg_supplies') }} s
    ON p.patient_id = s.patient_id
