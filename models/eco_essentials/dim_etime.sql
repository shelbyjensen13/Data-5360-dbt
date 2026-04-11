
{{ config(
    materialized = 'table',
    schema = 'ECOESSENTIALS_DW_SOURCE'
) }}

SELECT
    {{ dbt_utils.generate_surrogate_key(["TO_CHAR(SENDTIMESTAMP, 'HH24:MI:SS')"]) }} as TIME_KEY,
    TO_CHAR(SENDTIMESTAMP, 'HH24:MI:SS') as TIME_OF_DAY,
    HOUR(EVENTTIMESTAMP) as HOUR,
    MINUTE(EVENTTIMESTAMP) as MINUTE,
    SECOND(EVENTTIMESTAMP) as SECOND
FROM {{ source('salesforce_landing', 'MARKETINGEMAILS') }}
