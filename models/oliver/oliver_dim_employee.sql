{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}


select
employee_id as employee_key,
employee_id as employeeid,
first_name as employeefirstname,
last_name as employeelastname,
email as empemail,
phone_number as empphonenumber,
position,
hire_date
FROM {{ source('oliver_landing', 'employee') }}