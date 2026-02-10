{{
    config(
        materialized='table'
    )
}}

WITH encounters AS (
    SELECT
        provider_id,
        COUNT(DISTINCT encounter_id) AS encounter_count,
        COUNT(DISTINCT patient_id) AS patient_count,
        SUM(base_encounter_cost) AS total_base_encounter_cost,
        SUM(total_claim_cost) AS total_encounter_claim_cost,
        SUM(payer_coverage) AS total_payer_coverage
    FROM {{ ref('int_patient_encounters') }}
    GROUP BY provider_id
),
claims AS (
    SELECT
        provider_id,
        COUNT(DISTINCT claim_id) AS claim_count,
        SUM(transaction_amount) AS total_claim_amount,
        SUM(payments) AS total_claim_payments,
        SUM(adjustments) AS total_claim_adjustments,
        SUM(transfers) AS total_claim_transfers,
        SUM(outstanding) AS total_claim_outstanding
    FROM {{ ref('int_patient_claims') }}
    GROUP BY provider_id
)
SELECT
    pr.provider_id,
    pr.organization_id,
    pr.name AS provider_name,
    pr.speciality,
    pr.gender,
    pr.city,
    pr.state,
    pr.utilization,
    COALESCE(e.encounter_count, 0) AS encounter_count,
    COALESCE(e.patient_count, 0) AS patient_count,
    COALESCE(e.total_base_encounter_cost, 0) AS total_base_encounter_cost,
    COALESCE(e.total_encounter_claim_cost, 0) AS total_encounter_claim_cost,
    COALESCE(e.total_payer_coverage, 0) AS total_payer_coverage,
    COALESCE(c.claim_count, 0) AS claim_count,
    COALESCE(c.total_claim_amount, 0) AS total_claim_amount,
    COALESCE(c.total_claim_payments, 0) AS total_claim_payments,
    COALESCE(c.total_claim_adjustments, 0) AS total_claim_adjustments,
    COALESCE(c.total_claim_transfers, 0) AS total_claim_transfers,
    COALESCE(c.total_claim_outstanding, 0) AS total_claim_outstanding
FROM {{ ref('stg_providers') }} pr
LEFT JOIN encounters e
    ON pr.provider_id = e.provider_id
LEFT JOIN claims c
    ON pr.provider_id = c.provider_id
