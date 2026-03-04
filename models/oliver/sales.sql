
  {{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}


SELECT
c.firstname as customer_first_name,
c.lastname as customer_last_name,
d.date_day,
s.storename,
p.productname,
e.employeefirstname,
e.employeelastname,
f.dollars_sold
FROM {{ ref('fact_sales') }} f

LEFT JOIN {{ ref('oliver_dim_customer') }} c
    ON f.customer_key = c.customer_key

LEFT JOIN {{ ref('oliver_dim_employee') }} e
    ON f.employee_key = e.employee_key

LEFT JOIN {{ ref('oliver_dim_store') }} s
    ON f.store_key = s.store_key

LEFT JOIN {{ ref('oliver_dim_product') }} p
    ON f.product_key = p.product_key

LEFT JOIN {{ ref('oliver_dim_date') }} d
    ON f.date_key = d.date_key

