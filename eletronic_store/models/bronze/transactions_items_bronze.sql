{{ config(
    materialized='table'
) }}

SELECT
    item_id,
    transaction_id,
    product_id,
    quantity,
    CAST(unit_price AS FLOAT64) AS unit_price,
    CAST(subtotal AS FLOAT64) AS subtotal
FROM 
    {{ ref('transaction_items') }}
