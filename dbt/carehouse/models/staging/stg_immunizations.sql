{{
    config(
        materialized='table'
    )
}}

SELECT 
    DATE AS immunization_date,
    PATIENT AS patient_id,
    ENCOUNTER AS encounter_id,
    CODE AS code,
    DESCRIPTION AS description,
    BASE_COST AS base_cost
FROM healthcare.raw.immunizations