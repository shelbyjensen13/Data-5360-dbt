{{ config(
    materialized = 'table',
    schema = 'ECOESSENTIALS_DW_SOURCE'
) }}

SELECT
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
JOIN {{ ref('dim_edate') }} d on d.date_id=m.eventtimestamp
JOIN {{ ref('dim_etime') }} t on m.sendtimestamp = t.time_of_day
