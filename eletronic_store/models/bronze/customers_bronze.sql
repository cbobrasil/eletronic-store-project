{{ config(
    materialized='table'
) }}

SELECT
    customer_id,
    name,
    email,
    phone,
    address,
    CAST(registration_date AS DATE) AS registration_date
FROM 
    {{ ref('customers') }}
