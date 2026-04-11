{{ config(
    materialized = 'table',
    schema = 'ECOESSENTIALS_DW_SOURCE'
    )
}}

SELECT
{{ dbt_utils.generate_surrogate_key(['CAMPAIGN_ID']) }} as CAMPAIGN_KEY,
CAMPAIGN_ID,
CAMPAIGN_NAME,
CAMPAIGN_DISCOUNT
FROM {{source("ecoessentials_landing", 'PROMOTIONAL_CAMPAIGN')}}