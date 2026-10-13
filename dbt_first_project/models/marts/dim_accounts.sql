{{ config(materialized='table',schema='marts') }}

WITH accounts AS (

    SELECT
        ROW_NUMBER() OVER (ORDER BY account) AS account_key,
        account,
        sector,
        year_established,
        revenue,
        employees,
        office_location,
        subsidiary_of
    FROM {{ ref('stg_accounts') }}

)

SELECT *
FROM accounts