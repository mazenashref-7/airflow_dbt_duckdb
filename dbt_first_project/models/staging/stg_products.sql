{{ config(materialized='view',schema='staging') }}

SELECT
    product AS product_name,
    series,
    sales_price
FROM {{ source('ods', 'raw_products') }}
