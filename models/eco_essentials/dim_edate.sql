{{ config(
    materialized = 'table',
    schema = 'ECOESSENTIALS_DW_SOURCE'
    )
}}

SELECT
    DISTINCT
    {{ dbt_utils.generate_surrogate_key(["TO_CHAR(EVENTTIMESTAMP, 'YYYYMMDD')"]) }} as DATE_KEY,
    TO_CHAR(EVENTTIMESTAMP, 'YYYYMMDD') as DATE_ID,
    CAST(EVENTTIMESTAMP AS DATE) as FULL_DATE,
    DAYOFWEEK(EVENTTIMESTAMP) as DAY_OF_WEEK,
    MONTH(EVENTTIMESTAMP) as MONTH,
    YEAR(EVENTTIMESTAMP) as YEAR
FROM {{ source('salesforce_landing', 'MARKETINGEMAILS') }}