{{ config(
    materialized = 'table',
    schema = 'ECOESSENTIALS_DW_SOURCE'
) }}

SELECT
    EMAILID as Email_Key, -- Renaming to match your PK in the diagram
    EMAILID,
    EMAILNAME
FROM {{ source('salesforce_landing', 'MARKETINGEMAILS') }}