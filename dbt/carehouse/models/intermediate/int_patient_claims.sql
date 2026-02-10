{{
    config(
        materialized='table'
    )
}}

SELECT
    c.claim_id,
    t.claim_transaction_id,
    c.patient_id,
    c.provider_id,
    c.department_id,
    c.patient_department_id,
    c.current_illness_date,
    c.service_date,
    c.first_diagnosis,
    c.second_diagnosis,
    c.third_diagnosis,
    c.fourth_diagnosis,
    c.fifth_diagnosis,
    c.sixth_diagnosis,
    c.seventh_diagnosis,
    c.eighth_diagnosis,
    t.type AS transaction_type,
    t.amount AS transaction_amount,
    t.method AS transaction_method,
    t.start_date AS transaction_start_date,
    t.end_date AS transaction_end_date,
    t.place_of_service,
    t.procedure_code,
    t.first_modifier,
    t.second_modifier,
    t.first_diagnosis_reference,
    t.second_diagnosis_reference,
    t.third_diagnosis_reference,
    t.fourth_diagnosis_reference,
    t.units,
    t.unit_amount,
    t.payments,
    t.adjustments,
    t.transfers,
    t.outstanding,
    p.birth_date,
    p.gender,
    p.race,
    p.ethnicity,
    p.city,
    p.state,
    p.zip_code,
    p.healthcare_expenses,
    p.healthcare_coverage,
    pr.name AS provider_name,
    pr.speciality AS provider_speciality,
    pr.city AS provider_city,
    pr.state AS provider_state
FROM {{ ref('stg_claims') }} c
LEFT JOIN {{ ref('stg_claim_transactions') }} t
    ON c.claim_id = t.claim_id
LEFT JOIN {{ ref('stg_patients') }} p
    ON c.patient_id = p.patient_id
LEFT JOIN {{ ref('stg_providers') }} pr
    ON c.provider_id = pr.provider_id
