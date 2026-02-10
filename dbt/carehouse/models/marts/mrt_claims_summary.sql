{{
    config(
        materialized='table'
    )
}}

SELECT
    claim_id,
    patient_id,
    provider_id,
    department_id,
    patient_department_id,
    current_illness_date,
    service_date,
    first_diagnosis,
    second_diagnosis,
    third_diagnosis,
    fourth_diagnosis,
    fifth_diagnosis,
    sixth_diagnosis,
    seventh_diagnosis,
    eighth_diagnosis,
    COUNT(DISTINCT claim_transaction_id) AS transaction_count,
    SUM(transaction_amount) AS total_transaction_amount,
    SUM(payments) AS total_payments,
    SUM(adjustments) AS total_adjustments,
    SUM(transfers) AS total_transfers,
    SUM(outstanding) AS total_outstanding
FROM {{ ref('int_patient_claims') }}
GROUP BY
    claim_id,
    patient_id,
    provider_id,
    department_id,
    patient_department_id,
    current_illness_date,
    service_date,
    first_diagnosis,
    second_diagnosis,
    third_diagnosis,
    fourth_diagnosis,
    fifth_diagnosis,
    sixth_diagnosis,
    seventh_diagnosis,
    eighth_diagnosis
