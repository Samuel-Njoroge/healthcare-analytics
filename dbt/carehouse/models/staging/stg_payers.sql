{{
    config(
        materialized='table'
    )
}}

SELECT 
    Id AS payer_id,
    NAME AS payer_name,
    ADDRESS AS address,
    CITY AS city,
    STATE_HEADQUARTERED AS state_headquarter,
    ZIP AS zip_code,
    PHONE AS phone_number,
    AMOUNT_COVERED AS amount_covered,
    AMOUNT_UNCOVERED AS amount_uncovered,
    REVENUE AS revenue,
    COVERED_ENCOUNTERS AS covered_encounters,
    UNCOVERED_ENCOUNTERS AS uncovered_encounters,
    COVERED_MEDICATIONS AS covered_medications,
    UNCOVERED_MEDICATIONS AS uncovered_medications,
    COVERED_PROCEDURES AS covered_procedures,
    UNCOVERED_PROCEDURES AS uncovered_procedures,
    COVERED_IMMUNIZATIONS AS covered_immunizations,
    UNCOVERED_IMMUNIZATIONS AS uncovered_immunizations,
    UNIQUE_CUSTOMERS AS unique_customers,
    QOLS_AVG AS average_quality_of_life,
    MEMBER_MONTHS AS member_months
FROM healthcare.raw.payers