{{ config(
    materialized='table'
) }}

SELECT
    product_id,
    name,
    category,
    price,
    stock,
    supplier_id
FROM 
    {{ ref('products_bronze') }}
