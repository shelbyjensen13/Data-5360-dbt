{{ config(
    materialized = 'table',
    schema = 'ECOESSENTIALS_DW_SOURCE'
    )
}}

WITH marketing_emails AS (
    SELECT * FROM {{ source('salesforce_landing', 'MARKETINGEMAILS') }}
),

dim_campaign AS (
    SELECT * FROM {{ ref('dim_campaign') }}
),

dim_email_timestamp AS (
    SELECT * FROM {{ ref('dim_email_timestamp') }}
),

dim_customer AS (
    SELECT * FROM {{ ref('dim_ecustomer') }}
),

dim_date AS (
    SELECT * FROM {{ ref('dim_edate') }}
),

dim_event AS (
    SELECT * FROM {{ ref('dim_eventtype') }}
),

dim_email AS (
    SELECT * FROM {{ ref('dim_eemail') }}
)

SELECT
    dc.CAMPAIGN_KEY, -- done
    et.EMAIL_TIMESTAMP_KEY, -- done
    dcust.CUSTOMER_KEY, -- done
    dd.DATE_KEY, -- MAYBE
    de.EVENT_KEY, -- done
    e.EMAIL_KEY
FROM marketing_emails me

JOIN dim_campaign dc ON me.campaignid = dc.campaign_id

JOIN dim_email_timestamp et ON me.eventtimestamp = et.event_timestamp

JOIN dim_customer dcust ON me.subscriberemail = dcust.customer_email

JOIN dim_date dd ON CAST(me.eventtimestamp AS DATE) = dd.date

JOIN dim_event de ON me.eventtype = de.event_type

JOIN dim_email e ON me.subscriberemail = e.email_address