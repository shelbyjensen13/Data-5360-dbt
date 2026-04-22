{{ config(
    materialized = 'table',
    schema = 'ECOESSENTIALS_DW_SOURCE'
    )
}}

WITH date_try AS (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('2020-01-01' as date)",
        end_date="cast('2030-12-31' as date)"
    ) }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['date_day']) }} AS DATE_KEY,
    date_day AS DATE,
    EXTRACT(day FROM date_day) AS DAY,
    EXTRACT(month FROM date_day) AS MONTH,
    EXTRACT(year FROM date_day) AS YEAR
FROM date_try