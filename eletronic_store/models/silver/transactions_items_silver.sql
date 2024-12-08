{{ config(
    materialized='table'
) }}

SELECT
    item_id,
    transaction_id,
    product_id,
    quantity,
    unit_price,
    subtotal
FROM 
    {{ ref('transactions_items_bronze') }}
