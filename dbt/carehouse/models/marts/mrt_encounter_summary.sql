{{
    config(
        materialized='table'
    )
}}

WITH conditions AS (
    SELECT
        encounter_id,
        COUNT(*) AS condition_count
    FROM {{ ref('stg_conditions') }}
    GROUP BY encounter_id
),
procedures AS (
    SELECT
        encounter_id,
        COUNT(*) AS procedure_count,
        SUM(base_cost) AS total_procedure_cost
    FROM {{ ref('stg_procedures') }}
    GROUP BY encounter_id
),
medications AS (
    SELECT
        encounter_id,
        COUNT(*) AS medication_count,
        SUM(total_cost) AS total_medication_cost,
        SUM(payer_coverage) AS total_medication_payer_coverage
    FROM {{ ref('stg_medications') }}
    GROUP BY encounter_id
),
observations AS (
    SELECT
        encounter_id,
        COUNT(*) AS observation_count
    FROM {{ ref('stg_observations') }}
    GROUP BY encounter_id
),
immunizations AS (
    SELECT
        encounter_id,
        COUNT(*) AS immunization_count,
        SUM(base_cost) AS total_immunization_cost
    FROM {{ ref('stg_immunizations') }}
    GROUP BY encounter_id
),
devices AS (
    SELECT
        encounter_id,
        COUNT(*) AS device_count
    FROM {{ ref('stg_devices') }}
    GROUP BY encounter_id
),
imaging AS (
    SELECT
        encounter_id,
        COUNT(*) AS imaging_study_count
    FROM {{ ref('stg_imaging_studies') }}
    GROUP BY encounter_id
),
supplies AS (
    SELECT
        encounter_id,
        COUNT(*) AS supply_count,
        SUM(quantity) AS total_supply_quantity
    FROM {{ ref('stg_supplies') }}
    GROUP BY encounter_id
),
allergies AS (
    SELECT
        encounter_id,
        COUNT(*) AS allergy_count
    FROM {{ ref('stg_allergies') }}
    GROUP BY encounter_id
)
SELECT
    e.encounter_id,
    e.patient_id,
    e.organization_id,
    e.provider_id,
    e.payer_id,
    e.start_date,
    e.end_date,
    e.encounter_class,
    e.code,
    e.description,
    e.base_encounter_cost,
    e.total_claim_cost,
    e.payer_coverage,
    e.reason_code,
    e.reason_description,
    p.birth_date,
    p.gender,
    p.race,
    p.ethnicity,
    p.city,
    p.state,
    p.zip_code,
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
    COALESCE(a.allergy_count, 0) AS allergy_count
FROM {{ ref('stg_encounters') }} e
LEFT JOIN {{ ref('stg_patients') }} p
    ON e.patient_id = p.patient_id
LEFT JOIN conditions c
    ON e.encounter_id = c.encounter_id
LEFT JOIN procedures pr
    ON e.encounter_id = pr.encounter_id
LEFT JOIN medications m
    ON e.encounter_id = m.encounter_id
LEFT JOIN observations o
    ON e.encounter_id = o.encounter_id
LEFT JOIN immunizations i
    ON e.encounter_id = i.encounter_id
LEFT JOIN devices d
    ON e.encounter_id = d.encounter_id
LEFT JOIN imaging im
    ON e.encounter_id = im.encounter_id
LEFT JOIN supplies s
    ON e.encounter_id = s.encounter_id
LEFT JOIN allergies a
    ON e.encounter_id = a.encounter_id
