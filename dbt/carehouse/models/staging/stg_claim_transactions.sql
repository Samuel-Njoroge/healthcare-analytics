{{
    config(
        materialized='table'
    )
}}

SELECT 
    ID AS claim_transaction_id,
    CLAIMID AS claim_id,
    CHARGEID AS charge_id,
    PATIENTID AS patient_id,
    TYPE AS type,
    AMOUNT AS amount,
    METHOD AS method,
    FROMDATE AS start_date,
    TODATE AS end_date,
    PLACEOFSERVICE AS place_of_service,
    PROCEDURECODE AS procedure_code,
    MODIFIER1 AS first_modifier,
    MODIFIER2 AS second_modifier,
    DIAGNOSISREF1 AS first_diagnosis_reference,
    DIAGNOSISREF2 AS second_diagnosis_reference,
    DIAGNOSISREF3 AS third_diagnosis_reference,
    DIAGNOSISREF4 AS fourth_diagnosis_reference,
    UNITS AS units,
    DEPARTMENTID AS department_id,
    NOTES AS notes,
    UNITAMOUNT AS unit_amount,
    TRANSFEROUTID AS transfer_out_id,
    TRANSFERTYPE AS transfer_type,
    PAYMENTS AS payments,
    ADJUSTMENTS AS adjustments,
    TRANSFERS AS transfers,
    OUTSTANDING AS outstanding,
    APPOINTMENTID AS appointment_id,
    LINENOTE AS line_note,
    PATIENTINSURANCEID AS patient_insurance_id,
    FEESCHEDULEID AS fee_scheduled_id, 
    PROVIDERID AS provider_id,
    SUPERVISINGPROVIDERID AS supervising_provider_id
FROM healthcare.raw.claim_transactions