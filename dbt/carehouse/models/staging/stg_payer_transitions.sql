{{
    config(
        materialized='table'
    )
}}

SELECT 
    START_YEAR AS start_year,
    END_YEAR AS end_year,
    PATIENT AS patient_id,
    MEMBERID AS member_id,
    PAYER AS payer_id,
    SECONDARY_PAYER AS secondary_payer_id,
    OWNERSHIP AS ownership,
    OWNERNAME AS owner_name
FROM healthcare.raw.payer_transitions