{{ config(
    materialized='table'
) }}

SELECT
    supplier_id,
    UPPER(supplier_name) AS supplier_name,
    contact_email,
    phone,
    address
FROM 
    {{ ref('suppliers_bronze') }}
