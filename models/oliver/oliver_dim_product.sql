{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}


select
product_id as product_key,
product_id as productid,
description,
product_name as productname

FROM {{ source('oliver_landing', 'product') }}