{{ config(
    materialized='table'
) }}

SELECT
    customer_id,
    UPPER(name) AS name,
    email,
    phone,
    address,
    registration_date
FROM 
    {{ ref('customers_bronze') }}
