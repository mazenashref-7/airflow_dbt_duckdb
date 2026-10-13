{{config(materialized='table',schema='marts')}}

SELECT 
    ROW_NUMBER() OVER (ORDER BY sales_agent) AS sales_agent_key,
    sales_agent,
    manager,
    regional_office
FROM {{ ref('stg_sales_teams') }}