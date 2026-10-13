{{config(materialized='view',schema='staging')}}

WITH source AS (

SELECT
    TRIM(sales_agent) AS sales_agent,
    TRIM(manager) AS manager,
    TRIM(regional_office) AS regional_office
FROM {{ source('ods', 'raw_sales_teams') }}
)

SELECT *
FROM source