{{ config(materialized = 'table', schema = 'marts') }}
SELECT sp.opportunity_id,
    st.sales_agent_key,
    dp.product_key,
    sa.account_key,
    sp.deal_stage,
    sp.engage_date,
    sp.close_date,
    sp.close_value
FROM {{ ref('stg_sales_pipeline') }} as sp
    LEFT JOIN {{ ref('dim_sales_teams') }} AS st ON sp.sales_agent = st.sales_agent
    LEFT JOIN {{ ref('dim_products') }} AS dp ON sp.product_name = dp.product_name
    LEFT JOIN {{ ref('dim_accounts') }} AS sa ON sp.account = sa.account