{{
    config(
        materialized='table'
    )
}}

SELECT
    pt.patient_id,
    pt.member_id,
    pt.start_year,
    pt.end_year,
    pt.payer_id,
    pt.secondary_payer_id,
    pt.ownership,
    pt.owner_name,
    p.birth_date,
    p.gender,
    p.race,
    p.ethnicity,
    p.city,
    p.state,
    p.zip_code,
    p.healthcare_expenses,
    p.healthcare_coverage,
    py.payer_name,
    py.state_headquarter,
    py.amount_covered,
    py.amount_uncovered,
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
    py.member_months
FROM {{ ref('stg_payer_transitions') }} pt
LEFT JOIN {{ ref('stg_patients') }} p
    ON pt.patient_id = p.patient_id
LEFT JOIN {{ ref('stg_payers') }} py
    ON pt.payer_id = py.payer_id
