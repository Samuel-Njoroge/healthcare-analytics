{{
    config(
        materialized='table'
    )
}}

WITH encounters AS (
    SELECT
        payer_id,
        COUNT(DISTINCT encounter_id) AS encounter_count,
        COUNT(DISTINCT patient_id) AS patient_count,
        SUM(base_encounter_cost) AS total_base_encounter_cost,
        SUM(total_claim_cost) AS total_encounter_claim_cost,
        SUM(payer_coverage) AS total_payer_coverage
    FROM {{ ref('stg_encounters') }}
    GROUP BY payer_id
),
medications AS (
    SELECT
        payer_id,
        COUNT(*) AS medication_count,
        SUM(total_cost) AS total_medication_cost,
        SUM(payer_coverage) AS total_medication_payer_coverage
    FROM {{ ref('stg_medications') }}
    GROUP BY payer_id
),
member_transitions AS (
    SELECT
        payer_id,
        COUNT(DISTINCT member_id) AS member_count,
        COUNT(DISTINCT patient_id) AS patient_member_count
    FROM {{ ref('stg_payer_transitions') }}
    GROUP BY payer_id
)
SELECT
    py.payer_id,
    py.payer_name,
    py.address,
    py.city,
    py.state_headquarter,
    py.zip_code,
    py.phone_number,
    py.amount_covered,
    py.amount_uncovered,
    py.revenue,
    py.covered_encounters,
    py.uncovered_encounters,
    py.covered_medications,
    py.uncovered_medications,
    py.covered_procedures,
    py.uncovered_procedures,
    py.covered_immunizations,
    py.uncovered_immunizations,
    py.unique_customers,
    py.average_quality_of_life,
    py.member_months,
    COALESCE(e.encounter_count, 0) AS encounter_count,
    COALESCE(e.patient_count, 0) AS patient_count,
    COALESCE(e.total_base_encounter_cost, 0) AS total_base_encounter_cost,
    COALESCE(e.total_encounter_claim_cost, 0) AS total_encounter_claim_cost,
    COALESCE(e.total_payer_coverage, 0) AS total_payer_coverage,
    COALESCE(m.medication_count, 0) AS medication_count,
    COALESCE(m.total_medication_cost, 0) AS total_medication_cost,
    COALESCE(m.total_medication_payer_coverage, 0) AS total_medication_payer_coverage,
    COALESCE(mt.member_count, 0) AS member_count,
    COALESCE(mt.patient_member_count, 0) AS patient_member_count
FROM {{ ref('stg_payers') }} py
LEFT JOIN encounters e
    ON py.payer_id = e.payer_id
LEFT JOIN medications m
    ON py.payer_id = m.payer_id
LEFT JOIN member_transitions mt
    ON py.payer_id = mt.payer_id
