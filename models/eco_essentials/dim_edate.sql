{{ config(
    materialized = 'table',
    schema = 'ECOESSENTIALS_DW_SOURCE'
    )
}}

SELECT
    DISTINCT
    -- Create the Date_Key (Format: 20260327)
    TO_CHAR(EVENTTIMESTAMP, 'YYYYMMDD') as Date_Key,
    -- Create Full_Date
    CAST(EVENTTIMESTAMP AS DATE) as Full_Date,
    -- Get Day of Week (1-7)
    DAYOFWEEK(EVENTTIMESTAMP) as DayOfWeek,
    -- Get Month (1-12)
    MONTH(EVENTTIMESTAMP) as Month,
    -- Get Year
    YEAR(EVENTTIMESTAMP) as Year
FROM {{ source('salesforce_landing', 'MARKETINGEMAILS') }}