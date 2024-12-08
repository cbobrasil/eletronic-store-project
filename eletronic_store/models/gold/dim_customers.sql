{{ config(
    materialized='table'
) }}

SELECT
    customer_id,
    name AS customer_name,
    email AS customer_email,
    phone AS customer_phone,
    address AS customer_address,
    registration_date
FROM 
    {{ ref('customers_silver') }}
