SELECT
    {{ dbt_utils.generate_surrogate_key(['ol.ORDER_LINE_ID']) }} as SALES_FACT_KEY,
    {{ dbt_utils.generate_surrogate_key(['o.CUSTOMER_ID']) }} as CUSTOMER_KEY,
    {{ dbt_utils.generate_surrogate_key(['ol.PRODUCT_ID']) }} as PRODUCT_KEY,
    ol.QUANTITY,
    (ol.QUANTITY * p.PRICE) - ol.DISCOUNT as SALE_AMOUNT
FROM {{ source('ecoessentials_landing', 'ORDER_LINE') }} ol
JOIN {{ source('ecoessentials_landing', 'ORDER') }} o ON ol.ORDER_ID = o.ORDER_ID
LEFT JOIN {{ ref('dim_product') }} p ON ol.PRODUCT_ID = p.PRODUCT_ID