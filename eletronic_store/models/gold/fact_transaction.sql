{{ config(
    materialized='table'
) }}

SELECT
    ti.transaction_item_id,
    ti.transaction_id,
    ti.product_id,
    p.name AS product_name,
    p.category AS product_category,
    p.price AS product_price,
    p.supplier_id,
    s.supplier_name,
    t.customer_id,
    c.name AS customer_name,
    c.email AS customer_email,
    c.phone AS customer_phone,
    c.address AS customer_address,
    t.transaction_date,
    ti.quantity AS total_items,
    ti.subtotal AS transaction_total
FROM 
    {{ ref('transactions_items_silver') }} ti
left join
    {{ ref('products_silver') }} p on ti.product_id = p.product_id
left join 
    {{ ref('suppliers_silver') }} s on p.supplier_id = s.supplier_id
join 
    {{ ref('transactions_silver') }} t on ti.transaction_id = t.transaction_id
left join 
    {{ ref('customers_silver') }} c on t.customer_id = c.customer_id
