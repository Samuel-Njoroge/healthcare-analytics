{{
    config(
        materialized='table'
    )
}}

WITH encounters AS (
    SELECT
        patient_id,
        COUNT(DISTINCT encounter_id) AS encounter_count,
        MIN(start_date) AS first_encounter_date,
        MAX(end_date) AS last_encounter_date,
        SUM(base_encounter_cost) AS total_base_encounter_cost,
        SUM(total_claim_cost) AS total_encounter_claim_cost,
        SUM(payer_coverage) AS total_encounter_payer_coverage
    FROM {{ ref('int_patient_encounters') }}
    GROUP BY patient_id
),
care_plans AS (
    SELECT
        patient_id,
        COUNT(DISTINCT care_plan_id) AS care_plan_count
    FROM {{ ref('int_patient_care_plans') }}
    GROUP BY patient_id
),
conditions AS (
    SELECT
        patient_id,
        COUNT(*) AS condition_count
    FROM {{ ref('int_patient_conditions') }}
    GROUP BY patient_id
),
procedures AS (
    SELECT
        patient_id,
        COUNT(*) AS procedure_count,
        SUM(base_cost) AS total_procedure_cost
    FROM {{ ref('int_patient_procedures') }}
    GROUP BY patient_id
),
medications AS (
    SELECT
        patient_id,
        COUNT(*) AS medication_count,
        SUM(total_cost) AS total_medication_cost,
        SUM(payer_coverage) AS total_medication_payer_coverage
    FROM {{ ref('int_patient_medications') }}
    GROUP BY patient_id
),
observations AS (
    SELECT
        patient_id,
        COUNT(*) AS observation_count
    FROM {{ ref('int_patient_observations') }}
    GROUP BY patient_id
),
immunizations AS (
    SELECT
        patient_id,
        COUNT(*) AS immunization_count,
        SUM(base_cost) AS total_immunization_cost
    FROM {{ ref('int_patient_immunizations') }}
    GROUP BY patient_id
),
devices AS (
    SELECT
        patient_id,
        COUNT(*) AS device_count
    FROM {{ ref('int_patient_devices') }}
    GROUP BY patient_id
),
imaging AS (
    SELECT
        patient_id,
        COUNT(*) AS imaging_study_count
    FROM {{ ref('int_patient_imaging_studies') }}
    GROUP BY patient_id
),
supplies AS (
    SELECT
        patient_id,
        COUNT(*) AS supply_count,
        SUM(quantity) AS total_supply_quantity
    FROM {{ ref('int_patient_supplies') }}
    GROUP BY patient_id
),
claims AS (
    SELECT
        patient_id,
        COUNT(DISTINCT claim_id) AS claim_count,
        SUM(transaction_amount) AS total_claim_amount,
        SUM(payments) AS total_claim_payments,
        SUM(adjustments) AS total_claim_adjustments,
        SUM(transfers) AS total_claim_transfers,
        SUM(outstanding) AS total_claim_outstanding
    FROM {{ ref('int_patient_claims') }}
    GROUP BY patient_id
),
allergies AS (
    SELECT
        patient_id,
        COUNT(*) AS allergy_count
    FROM {{ ref('stg_allergies') }}
    GROUP BY patient_id
)
SELECT
    p.patient_id,
    p.birth_date,
    p.death_date,
    p.gender,
    p.race,
    p.ethnicity,
    p.city,
    p.state,
    p.zip_code,
    p.healthcare_expenses,
    p.healthcare_coverage,
    COALESCE(e.encounter_count, 0) AS encounter_count,
    e.first_encounter_date,
    e.last_encounter_date,
    COALESCE(e.total_base_encounter_cost, 0) AS total_base_encounter_cost,
    COALESCE(e.total_encounter_claim_cost, 0) AS total_encounter_claim_cost,
    COALESCE(e.total_encounter_payer_coverage, 0) AS total_encounter_payer_coverage,
    COALESCE(cp.care_plan_count, 0) AS care_plan_count,
    COALESCE(c.condition_count, 0) AS condition_count,
    COALESCE(pr.procedure_count, 0) AS procedure_count,
    COALESCE(pr.total_procedure_cost, 0) AS total_procedure_cost,
    COALESCE(m.medication_count, 0) AS medication_count,
    COALESCE(m.total_medication_cost, 0) AS total_medication_cost,
    COALESCE(m.total_medication_payer_coverage, 0) AS total_medication_payer_coverage,
    COALESCE(o.observation_count, 0) AS observation_count,
    COALESCE(i.immunization_count, 0) AS immunization_count,
    COALESCE(i.total_immunization_cost, 0) AS total_immunization_cost,
    COALESCE(d.device_count, 0) AS device_count,
    COALESCE(im.imaging_study_count, 0) AS imaging_study_count,
    COALESCE(s.supply_count, 0) AS supply_count,
    COALESCE(s.total_supply_quantity, 0) AS total_supply_quantity,
    COALESCE(cl.claim_count, 0) AS claim_count,
    COALESCE(cl.total_claim_amount, 0) AS total_claim_amount,
    COALESCE(cl.total_claim_payments, 0) AS total_claim_payments,
    COALESCE(cl.total_claim_adjustments, 0) AS total_claim_adjustments,
    COALESCE(cl.total_claim_transfers, 0) AS total_claim_transfers,
    COALESCE(cl.total_claim_outstanding, 0) AS total_claim_outstanding,
    COALESCE(a.allergy_count, 0) AS allergy_count
FROM {{ ref('stg_patients') }} p
LEFT JOIN encounters e
    ON p.patient_id = e.patient_id
LEFT JOIN care_plans cp
    ON p.patient_id = cp.patient_id
LEFT JOIN conditions c
    ON p.patient_id = c.patient_id
LEFT JOIN procedures pr
    ON p.patient_id = pr.patient_id
LEFT JOIN medications m
    ON p.patient_id = m.patient_id
LEFT JOIN observations o
    ON p.patient_id = o.patient_id
LEFT JOIN immunizations i
    ON p.patient_id = i.patient_id
LEFT JOIN devices d
    ON p.patient_id = d.patient_id
LEFT JOIN imaging im
    ON p.patient_id = im.patient_id
LEFT JOIN supplies s
    ON p.patient_id = s.patient_id
LEFT JOIN claims cl
    ON p.patient_id = cl.patient_id
LEFT JOIN allergies a
    ON p.patient_id = a.patient_id
