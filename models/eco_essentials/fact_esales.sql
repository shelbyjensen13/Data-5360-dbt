{{ config(
    materialized = 'table',
    schema = 'ECOESSENTIALS_DW_SOURCE'
    )
}}

SELECT
    {{ dbt_utils.generate_surrogate_key(['ol.ORDER_LINE_ID']) }} as SALES_FACT_KEY,
    c.CUSTOMER_KEY,
    p.PRODUCT_KEY,
    ol.QUANTITY,
    s_p.PRICE,
    (ol.QUANTITY * s_p.PRICE) - ol.DISCOUNT as SALE_AMOUNT
FROM {{source('ecoessentials_landing', 'ORDER_LINE')}} ol
LEFT JOIN {{source('ecoessentials_landing', 'ORDER')}} o ON ol.ORDER_ID = o.ORDER_ID
LEFT JOIN {{ref('dim_ecustomer')}} c ON o.customer_id = c.customer_id
LEFT JOIN {{source('ecoessentials_landing', 'PRODUCT')}} s_p ON ol.product_id = s_p.product_id
LEFT JOIN {{ref('dim_product')}} p ON p.product_id = ol.product_id