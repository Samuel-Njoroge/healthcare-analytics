{{
    config(
        materialized='table'
    )
}}

SELECT 
    Id AS patient_id,
    BIRTHDATE birth_date,
    DEATHDATE AS death_date,
    SSN AS social_security_number,
    DRIVERS AS drivers_license,
    PASSPORT AS passport,
    PREFIX AS prefix,
    FIRST AS first_name,
    LAST AS last_name,
    SUFFIX AS suffix,
    MAIDEN AS maiden,
    MARITAL AS marital_status,
    RACE AS race,
    ETHNICITY AS ethnicity,
    GENDER AS gender,
    BIRTHPLACE AS birthplace,
    ADDRESS AS address,
    CITY AS city,
    STATE AS state,
    COUNTY AS county,
    ZIP AS zip_code,
    LAT AS latitude, 
    LON AS longitude,
    HEALTHCARE_EXPENSES AS healthcare_expenses,
    HEALTHCARE_COVERAGE AS healthcare_coverage
FROM healthcare.raw.patients