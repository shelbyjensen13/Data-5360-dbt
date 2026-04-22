{{ config(
    materialized = 'table',
    schema = 'ECOESSENTIALS_DW_SOURCE'
) }}

WITH email_timestamps AS (
    SELECT DISTINCT eventtimestamp
    FROM {{ source('salesforce_landing', 'MARKETINGEMAILS') }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['eventtimestamp']) }} AS EMAIL_TIMESTAMP_KEY,
    eventtimestamp AS event_timestamp
FROM email_timestamps