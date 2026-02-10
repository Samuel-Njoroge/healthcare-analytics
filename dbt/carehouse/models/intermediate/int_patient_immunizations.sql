{{
    config(
        materialized='table'
    )
}}

SELECT
    p.patient_id,
    i.encounter_id,
    i.immunization_date,
    p.birth_date,
    p.gender,
    p.race,
    p.ethnicity,
    p.city,
    p.state,
    p.zip_code,
    p.healthcare_expenses,
    p.healthcare_coverage,
    i.code AS immunization_code,
    i.description AS immunization_description,
    i.base_cost
FROM {{ ref('stg_patients') }} p
LEFT JOIN {{ ref('stg_immunizations') }} i
    ON p.patient_id = i.patient_id
