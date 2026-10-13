{{ config(materialized='view',schema='meta') }}

with sorces as (
SELECT
    "Table" AS table_name,
    "Field" AS field_name,
    "Description" AS description_name
FROM {{ source('ods', 'raw_data_dictionary') }}
)

select *
from sorces