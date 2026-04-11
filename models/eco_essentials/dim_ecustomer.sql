{{ config(
    materialized = 'table',
    schema = 'ECOESSENTIALS_DW_SOURCE'
) }}

WITH eco_customers AS (
    SELECT
        CUSTOMER_ID,
        CUSTOMER_FIRST_NAME,
        CUSTOMER_LAST_NAME,
        CUSTOMER_PHONE,
        CUSTOMER_ADDRESS,
        CUSTOMER_CITY,
        CUSTOMER_STATE,
        CUSTOMER_ZIP,
        CUSTOMER_COUNTRY,
        CUSTOMER_EMAIL,
        'ECO' AS SOURCE_SYSTEM,
        'CUSTOMER' AS CUSTOMER_TYPE
    FROM {{ source("ecoessentials_landing", "CUSTOMER") }}
),

sf_subscribers AS (
    SELECT DISTINCT
        SUBSCRIBERID AS CUSTOMER_ID,
        SUBSCRIBERFIRSTNAME AS CUSTOMER_FIRST_NAME,
        SUBSCRIBERLASTNAME AS CUSTOMER_LAST_NAME,
        NULL AS CUSTOMER_PHONE,
        NULL AS CUSTOMER_ADDRESS,
        NULL AS CUSTOMER_CITY,
        NULL AS CUSTOMER_STATE,
        NULL AS CUSTOMER_ZIP,
        NULL AS CUSTOMER_COUNTRY,
        SUBSCRIBEREMAIL AS CUSTOMER_EMAIL,
        'SALESFORCE' AS SOURCE_SYSTEM,
        'SUBSCRIBER' AS CUSTOMER_TYPE
    FROM {{ source("salesforce_landing", "MARKETINGEMAILS") }}
    WHERE SUBSCRIBEREMAIL IS NOT NULL
),

merged AS (
    -- Keep all real customers
    SELECT * FROM eco_customers

    UNION ALL

    -- Add subscribers only if email not already in customers
    SELECT s.*
    FROM sf_subscribers s
    WHERE NOT EXISTS (
        SELECT 1
        FROM eco_customers c
        WHERE TRIM(LOWER(c.CUSTOMER_EMAIL)) = TRIM(LOWER(s.CUSTOMER_EMAIL))
    )
)

SELECT
    {{ dbt_utils.generate_surrogate_key([
        "CASE 
            WHEN CUSTOMER_EMAIL IS NOT NULL AND TRIM(CUSTOMER_EMAIL) != '' 
                THEN TRIM(LOWER(CUSTOMER_EMAIL))
            ELSE CONCAT(SOURCE_SYSTEM, '_', CUSTOMER_ID)
         END"
    ]) }} AS CUSTOMER_KEY,

    CUSTOMER_ID,
    CUSTOMER_FIRST_NAME,
    CUSTOMER_LAST_NAME,
    CUSTOMER_PHONE,
    CUSTOMER_ADDRESS,
    CUSTOMER_CITY,
    CUSTOMER_STATE,
    CUSTOMER_ZIP,
    CUSTOMER_COUNTRY,
    CUSTOMER_EMAIL,
    CUSTOMER_TYPE

FROM merged
