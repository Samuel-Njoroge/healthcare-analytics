{{
    config(
        materialized='table'
    )
}}

SELECT 
    Id AS care_plan_id,
    START AS start_date,
    STOP AS end_date,
    PATIENT AS patient_id,
    ENCOUNTER AS encounter_id,
    CODE AS code,
    DESCRIPTION AS description,
    REASONCODE AS reason_code,
    REASONDESCRIPTION AS reason_description
FROM healthcare.raw.care_plans