{{ config(
    materialized='table'
) }}

SELECT
    product_id,
    name,
    category,
    CAST(price AS FLOAT64) AS price,
    stock,
    supplier_id
FROM 
    {{ ref('products') }}
