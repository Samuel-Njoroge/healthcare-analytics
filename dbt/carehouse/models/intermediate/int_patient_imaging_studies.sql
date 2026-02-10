{{
    config(
        materialized='table'
    )
}}

SELECT
    p.patient_id,
    i.encounter_id,
    i.imaging_id,
    i.imaging_date,
    p.birth_date,
    p.gender,
    p.race,
    p.ethnicity,
    p.city,
    p.state,
    p.zip_code,
    p.healthcare_expenses,
    p.healthcare_coverage,
    i.series_unique_identifier,
    i.bodysite_code,
    i.bodysite_description,
    i.modality_code,
    i.modality_description,
    i.instance_unique_identifier,
    i.sop_code,
    i.sop_description,
    i.procedure_code
FROM {{ ref('stg_patients') }} p
LEFT JOIN {{ ref('stg_imaging_studies') }} i
    ON p.patient_id = i.patient_id
