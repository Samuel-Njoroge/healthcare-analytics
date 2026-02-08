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
    DESCRIPTION AS description,
    BASE_COST AS base_cost,
    REASONCODE AS reason_code,
    REASONDESCRIPTION AS reason_description
FROM healthcare.raw.procedures 