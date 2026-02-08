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
    SYSTEM AS system,
    DESCRIPTION AS description,
    TYPE AS type,
    CATEGORY AS category,
    REACTION1 AS first_reaction,
    DESCRIPTION1 AS first_description,
    SEVERITY1 AS first_severity,
    REACTION2 AS second_reaction,
    DESCRIPTION2 AS second_description,
    SEVERITY2 AS second_severity
FROM healthcare.raw.allergies