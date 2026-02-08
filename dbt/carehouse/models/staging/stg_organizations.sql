{{
    config(
        materialized='table'
    )
}}

SELECT 
    Id AS organization_id,
    NAME AS organization_name,
    ADDRESS AS address,
    CITY AS city,
    STATE AS state,
    ZIP AS zip_code,
    LAT AS latitude,
    LON AS longitude,
    PHONE AS phone_number,
    REVENUE AS revenue,
    UTILIZATION AS utilization
FROM healthcare.raw.organizations