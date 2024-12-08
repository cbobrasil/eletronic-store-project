{{ config(
    materialized='table'
) }}

SELECT
    product_id,
    name AS product_name,
    category AS product_category,
    price AS product_price,
    stock
FROM 
    {{ ref('products_silver') }}
