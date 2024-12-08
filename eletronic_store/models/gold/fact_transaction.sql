{{ config(
    materialized='table'
) }}

SELECT
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
    SUM(ti.subtotal) AS transaction_total,
    COUNT(ti.item_id) AS total_items
FROM 
    {{ ref('transactions_items_silver') }} ti
JOIN 
    {{ ref('products_silver') }} p 
    ON ti.product_id = p.product_id
JOIN 
    {{ ref('suppliers_silver') }} s 
    ON p.supplier_id = s.supplier_id
JOIN 
    {{ ref('transactions_silver') }} t 
    ON ti.transaction_id = t.transaction_id
JOIN 
    {{ ref('customers_silver') }} c 
    ON t.customer_id = c.customer_id
GROUP BY 
    ti.transaction_id, 
    ti.product_id, 
    p.name, 
    p.category, 
    p.price, 
    p.supplier_id, 
    s.supplier_name, 
    t.customer_id, 
    c.name, 
    c.email, 
    c.phone, 
    c.address, 
    t.transaction_date
