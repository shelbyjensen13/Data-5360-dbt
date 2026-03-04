{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}


select
    e.employee_key,
    c.customer_key,
    p.product_key,
    d.date_key,
    s.store_key,
    ol.unit_price,
    ol.quantity,
    ol.unit_price*ol.quantity as dollars_sold
FROM {{source('oliver_landing', 'orderline') }} ol 
INNER JOIN {{ source('oliver_landing', 'orders') }} o ON ol.order_id = o.order_id
INNER JOIN {{ ref('oliver_dim_employee') }} e ON e.employeeid = o.employee_id 
INNER JOIN {{ ref('oliver_dim_customer') }} c ON c.customerid = o.customer_id 
INNER JOIN {{ ref('oliver_dim_product') }} p ON p.productid = ol.product_id
INNER JOIN {{ ref('oliver_dim_date') }} d ON d.date_day = o.order_date
INNER JOIN {{ ref('oliver_dim_store') }} s ON s.storeid = o.store_id
