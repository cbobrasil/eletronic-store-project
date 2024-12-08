{{ config(
    materialized='table'
) }}

SELECT
    supplier_id,
    supplier_name,
    contact_email AS supplier_email,
    phone AS supplier_phone,
    address AS supplier_address
FROM 
    {{ ref('suppliers_silver') }}
