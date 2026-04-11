{{ config(
    materialized = 'table',
    schema = 'ECOESSENTIALS_DW_SOURCE'
) }}

SELECT
    {{ dbt_utils.generate_surrogate_key(['EMAILID']) }} as EMAIL_KEY, 
    EMAILID,
    EMAILNAME
FROM {{ source('salesforce_landing', 'MARKETINGEMAILS') }}
GROUP BY 1, 2, 3