{{
    config(
        materialized='table'
    )
}}

SELECT 
    p.provider_id,
    o.organization_id,
    p.name AS provider_name,
    p.speciality,
    o.organization_name,
    o.address AS organization_address,
    o.city AS organization_city,
    o.phone_number AS organization_phone_number,
    o.revenue AS organization_revenue
FROM {{ ref('stg_providers') }} p  
LEFT JOIN {{ ref('stg_organizations') }} o
    ON p.organization_id = o.organization_id 
