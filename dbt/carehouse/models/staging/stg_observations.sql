{{
    config(
        materialized='table'
    )
}}

SELECT 
    DATE AS observation_date,
    PATIENT AS patient_id,
    ENCOUNTER AS encounter_id,
    CATEGORY AS category,
    CODE AS code,
    DESCRIPTION AS description,
    VALUE AS value,
    UNITS AS units,
    TYPE AS type
FROM healthcare.raw.observations