{{ config(
    materialized = 'table',
    schema = 'ECOESSENTIALS_DW_SOURCE'
    )
}}

SELECT
    {{ dbt_utils.generate_surrogate_key(['PRODUCT_ID']) }} as PRODUCT_KEY,
    PRODUCT_ID,
    PRODUCT_NAME,
    PRICE,
    PRODUCT_TYPE
FROM {{ source('ecoessentials_landing', 'PRODUCT') }}