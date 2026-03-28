{{ config(
    materialized = 'table',
    schema = 'ECOESSENTIALS_DW_SOURCE'
    )
}}

SELECT
CAMPAIGN_ID as CAMPAIGN_KEY,
CAMPAIGN_ID,
CAMPAIGN_NAME,
CAMPAIGN_DISCOUNT
FROM {{source("ecoessentials_landing", 'PROMOTIONAL_CAMPAIGN')}}