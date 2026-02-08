{{
    config(
        materialized='table'
    )
}}

SELECT 
    Id AS imaging_id,
    DATE AS imaging_date,
    PATIENT AS patient_id,
    ENCOUNTER AS encounter_id,
    SERIES_UID AS series_unique_identifier,
    BODYSITE_CODE AS bodysite_code,
    BODYSITE_DESCRIPTION AS bodysite_description,
    MODALITY_CODE AS modality_code,
    MODALITY_DESCRIPTION AS modality_description,
    INSTANCE_UID AS instance_unique_identifier,
    SOP_CODE AS sop_code,
    SOP_DESCRIPTION AS sop_description,
    PROCEDURE_CODE AS procedure_code
FROM healthcare.raw.imaging_studies