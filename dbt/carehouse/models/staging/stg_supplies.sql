{{
    config(
        materialized='table'
    )
}}

SELECT 
    DATE AS supply_date,
    PATIENT AS patient_id,
    ENCOUNTER AS encounter_id,
    CODE AS code,
    DESCRIPTION AS description,
    QUANTITY AS quantity
FROM healthcare.raw.supplies