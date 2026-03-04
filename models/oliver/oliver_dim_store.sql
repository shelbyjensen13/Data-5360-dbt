{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}


select
store_id as store_key,
city as store_city,
state as store_state,
street as store_street,
store_id as storeid,
store_name as storename

FROM {{ source('oliver_landing', 'store') }}