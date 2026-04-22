{{ config(
    materialized = 'table',
    schema = 'ECOESSENTIALS_DW_SOURCE'
    )
}}

WITH events AS (
    SELECT DISTINCT EVENTTYPE
    FROM {{ source('dt_salesforce_emails', 'marketingemails') }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['EVENTTYPE']) }} AS EVENT_KEY,
    eventtype AS event_type
FROM events