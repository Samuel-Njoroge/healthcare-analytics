{{
    config(
        materialized='table'
    )
}}

SELECT 
    START AS start_date,
    STOP AS end_date,
    PATIENT AS patient_id,
    ENCOUNTER AS encounter_id,
    CODE AS code,
    DESCRIPTION AS description
FROM healthcare.raw.conditions