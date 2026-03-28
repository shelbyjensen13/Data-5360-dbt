{{ config(
    materialized = 'table',
    schema = 'ECOESSENTIALS_DW_SOURCE'
) }}

SELECT
    m.EMAILEVENTID as EVENT_KEY,
    c.CUSTOMER_KEY,
    e.Email_Key, -- Matches the key in dim_eemail
    TO_CHAR(m.EVENTTIMESTAMP, 'YYYYMMDD') as DATE_KEY,
    m.EVENTTYPE
FROM {{ source('salesforce_landing', 'MARKETINGEMAILS') }} m
JOIN {{ ref('dim_ecustomer') }} c 
    ON m.SUBSCRIBEREMAIL = c.CUSTOMER_EMAIL
JOIN {{ ref('dim_eemail') }} e
    ON m.EMAILID = e.Email_Key