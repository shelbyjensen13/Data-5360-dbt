{{ config(
    materialized = 'table',
    schema = 'ECOESSENTIALS_DW_SOURCE'
) }}

WITH emails AS (
    SELECT DISTINCT subscriberemail
    FROM {{ source('salesforce_landing', 'MARKETINGEMAILS') }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['subscriberemail']) }} AS EMAIL_KEY,
    subscriberemail AS email_address
FROM emails