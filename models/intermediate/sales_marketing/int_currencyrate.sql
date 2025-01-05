{{ config(materialized='table') }}

with 
    cr as (
        select *
        from {{ ref('stg_currencyrate') }}
    ),
    c as (
        select *
        from {{ ref('stg_currency') }}
    ),    
    joined as (
        select  
        cr.currency_rate_id,
        c.currency_code,
        cr.from_currency_code,
        cr.to_currency_code,
        cr.average_rate,
        cr.end_of_day_rate,
        c.name as name_currency
        

        from cr 
        join c 
        on cr.to_currency_code = c.currency_code 
        

    ),
    metrics as (
        select 
            *,
        avg(average_rate) as average_rate_currency,
        avg(end_of_day_rate) as closing_rate_currency,
        avg(end_of_day_rate - average_rate) as difference_closing_average_rate,
        stddev(average_rate) as exchange_rate_volatility,
        max(average_rate) - min(average_rate) as rates_variation,        
        count(currency_rate_id) as volume_registered_fees
        from joined
        group by all

                
    )
select * 
from metrics
