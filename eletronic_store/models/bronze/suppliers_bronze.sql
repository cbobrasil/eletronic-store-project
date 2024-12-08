{{ config(
    materialized='table'
) }}

SELECT
    supplier_id,
    name AS supplier_name,
    contact_email,
    phone,
    address
FROM 
    {{ ref('suppliers') }}
