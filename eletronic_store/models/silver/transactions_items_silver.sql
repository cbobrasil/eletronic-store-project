{{ config(
    materialized='table'
) }}

SELECT
    md5(cast(item_id as string)) as  transaction_item_id,
    transaction_id,
    product_id,
    quantity,
    unit_price,
    subtotal
FROM 
    {{ ref('transactions_items_bronze') }}
