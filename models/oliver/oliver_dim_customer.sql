{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}


select
customer_id as customer_key,
customer_id as customerid,
first_name as firstname,
last_name as lastname,
email as custemail,
phone_number as custphonenumber,
state
FROM {{ source('oliver_landing', 'customer') }}