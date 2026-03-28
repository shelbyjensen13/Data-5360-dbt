
{{ config(
    materialized = 'table',
    schema = 'ECOESSENTIALS_DW_SOURCE'
) }}

SELECT
    EMAILEVENTID as Time_Key, -- Or whichever ID you are using for the Time PK
    -- Snowflake's HOUR/MINUTE functions to break down the timestamp
    HOUR(SENDTIMESTAMP) as Hour,
    MINUTE(SENDTIMESTAMP) as Minute,
    SECOND(SENDTIMESTAMP) as Second
FROM {{ source('salesforce_landing', 'MARKETINGEMAILS') }}