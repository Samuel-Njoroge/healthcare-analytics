{{
    config(
        materialized='table'
    )
}}

SELECT 
    Id AS provider_id,
    ORGANIZATION AS organization_id,
    NAME AS name,
    GENDER AS gender,
    SPECIALITY AS speciality,
    ADDRESS AS address,
    CITY AS city,
    STATE AS state,
    ZIP AS zip_code,
    LAT AS latitude, 
    LON AS longitude,
    UTILIZATION AS utilization
FROM healthcare.raw.providers