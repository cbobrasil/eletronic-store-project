{{ config(
    materialized='table'
) }}

SELECT
    transaction_id,
    customer_id,
    transaction_date,
    total_amount
FROM 
    {{ ref('transactions_bronze') }}
