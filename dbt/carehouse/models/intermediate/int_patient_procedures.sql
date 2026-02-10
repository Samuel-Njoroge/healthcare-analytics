{{
    config(
        materialized='table'
    )
}}

SELECT
    p.patient_id,
    pr.encounter_id,
    pr.start_date,
    pr.end_date,
    p.birth_date,
    p.gender,
    p.race,
    p.ethnicity,
    p.city,
    p.state,
    p.zip_code,
    p.healthcare_expenses,
    p.healthcare_coverage,
    pr.code AS procedure_code,
    pr.description AS procedure_description,
    pr.base_cost,
    pr.reason_code,
    pr.reason_description
FROM {{ ref('stg_patients') }} p
LEFT JOIN {{ ref('stg_procedures') }} pr
    ON p.patient_id = pr.patient_id
