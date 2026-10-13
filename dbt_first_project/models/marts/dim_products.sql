{{ config(materialized = 'table', schema = 'marts') }}
SELECT 
    ROW_NUMBER() OVER (ORDER BY product_name) AS product_key,
    product_name,
    series,
    sales_price
FROM {{ ref('stg_products') }}