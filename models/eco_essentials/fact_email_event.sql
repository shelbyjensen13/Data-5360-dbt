{{ config(
    materialized = 'table',
    schema = 'ECOESSENTIALS_DW_SOURCE'
) }}

SELECT DISTINCT
    {{ dbt_utils.generate_surrogate_key(['m.EMAILEVENTID']) }} as EMAIL_EVENT_KEY,
    c.CUSTOMER_KEY,
    e.EMAIL_KEY,
    p.CAMPAIGN_KEY,
    d.DATE_KEY,
    t.TIME_KEY,
    m.EVENTTYPE
FROM {{ source('salesforce_landing', 'MARKETINGEMAILS') }} m
JOIN {{ ref('dim_ecustomer') }} c ON m.subscriberemail = c.customer_email
JOIN {{ ref('dim_eemail') }} e ON m.EMAILID = e.EMAILID
JOIN {{ ref('dim_campaign') }} p on m.campaignid = p.campaign_id
JOIN {{ ref('dim_edate') }} d ON d.date_id = CAST(m.eventtimestamp AS DATE)
JOIN {{ ref('dim_etime') }} t on m.sendtimestamp = t.time_of_day



-- {{ config(
--     materialized = 'table',
--     schema = 'ECOESSENTIALS_DW_SOURCE'
--     )
-- }}

-- WITH marketing_emails AS (
--     SELECT * FROM {{ source('dt_salesforce_emails', 'marketingemails') }}
-- ),

-- dim_campaign AS (
--     SELECT * FROM {{ ref('dim_campaign') }}
-- ),

-- dim_etime AS (
--     SELECT * FROM {{ ref('dim_etime') }}
-- ),

-- dim_customer AS (
--     SELECT * FROM {{ ref('dim_ecustomer') }}
-- ),

-- dim_date AS (
--     SELECT * FROM {{ ref('dim_edate') }}
-- ),

-- dim_event_type AS (
--     SELECT * FROM {{ ref('dim_event_type') }}
-- ),

-- dim_email AS (
--     SELECT * FROM {{ ref('dim_eemail') }}
-- )

-- SELECT
--     dc.campaign_key,
--     det.email_timestamp_key,
--     dcust.cust_key,
--     dd.date_key,
--     de.event_key,
--     dem.email_key
-- FROM marketing_emails me
-- JOIN dim_campaign dc
--     ON me.campaignid = dc.campaign_id
-- JOIN dim_email_timestamp det
--     ON me.eventtimestamp = det.event_timestamp
-- JOIN dim_customer dcust
--     ON me.subscriberemail = dcust.customer_email
-- JOIN dim_date dd
--     ON CAST(me.eventtimestamp AS DATE) = dd.date
-- JOIN dim_event de
--     ON me.eventtype = de.event_type
-- JOIN dim_email dem
--     ON me.subscriberemail = dem.email_address