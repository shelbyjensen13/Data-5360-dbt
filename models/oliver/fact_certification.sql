{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
)}}

select
    cu.employee_key,
    a.date_key,
    c.certification_cost,
    c.certification_name,
from {{ ref('stg_employee_certifications') }} c
inner join {{ ref('oliver_dim_employee') }} cu
    on c.employee_id = cu.employee_key
inner join {{ ref('oliver_dim_date') }} a
    on c.certification_awarded_date = a.date_day