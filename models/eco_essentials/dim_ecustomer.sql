{{ config(
    materialized = 'table',
    schema = 'ECOESSENTIALS_DW_SOURCE'
    )
}}

WITH customers AS (
    SELECT * FROM {{ source('ecoessentials_landing', 'customer') }}
),

marketing_emails AS (
    SELECT DISTINCT
        NULLIF(customerid, 'NULL') AS CUSTOMER_ID,
        subscriberfirstname,
        subscriberid,
        subscriberlastname,
        subscriberemail
    FROM {{ source('DT_salesforce_emails', 'marketingemails') }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key([
        'COALESCE(c.customer_email, m.subscriberemail)',
        'COALESCE(c.customer_first_name, m.subscriberfirstname)',
        'COALESCE(c.customer_last_name, m.subscriberlastname)'
    ]) }} AS CUSTOMER_KEY,
    COALESCE(c.customer_id, TRY_CAST(m.customerid AS NUMBER)) AS CUSTOMER_ID,
    COALESCE(c.customer_first_name, m.subscriberfirstname) AS CUSTOMER_FIRST_NAME
    COALESCE(c.customer_last_name, m.subscriberlastname) AS CUSTOMER_LAST_NAME,
    COALESCE(c.customer_email, m.subscriberemail) AS CUSTOMER_EMAIL,
    c.CUSTOMER_ADDRESS,
    c.CUSTOMER_CITY,
    c.CUSTOMER_STATE,
    c.CUSTOMER_ZIP,
    c.CUSTOMER_COUNTRY,
    CASE
        WHEN m.subscriberid IS NOT NULL THEN TRUE
        ELSE FALSE
    END AS IS_SUBSCRIBER
FROM customers c
FULL OUTER JOIN marketing_emails m
    ON c.customer_id = m.customerid