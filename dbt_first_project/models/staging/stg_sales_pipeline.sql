{{ config(materialized = 'view', schema = 'staging') }} WITH source AS (
    SELECT opportunity_id,
        sales_agent,
        CASE
            WHEN product = 'GTXPro' THEN 'GTX Pro'
            ELSE product
        END AS product_name,
        account,
        deal_stage,
        engage_date,
        close_date,
        close_value
    FROM {{ source('ods', 'raw_sales_pipeline') }}
)
SELECT *
FROM source