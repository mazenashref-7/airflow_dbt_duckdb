{{ config(materialized='view',schema='staging') }}




WITH source AS (
    SELECT 
        TRIM(account) AS account,
        TRIM(sector) AS sector,
        year_established,
        revenue,
        employees,
        TRIM(office_location) AS office_location,
        subsidiary_of
    FROM {{ source('ods', 'raw_accounts') }}
)

SELECT *
FROM source