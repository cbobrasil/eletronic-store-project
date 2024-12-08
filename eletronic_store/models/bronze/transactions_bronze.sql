{{ config(
    materialized='table'
) }}

SELECT
    transaction_id,
    customer_id,
    CAST(transaction_date AS DATE) AS transaction_date,
    CAST(total_amount AS FLOAT64) AS total_amount
FROM 
    {{ ref('transactions') }}
