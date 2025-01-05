{{ config(materialized='table') }}
with
    sop as (
        select *
        from {{ ref('stg_specialofferproduct') }}
    ),
        so as (
        select *
        from {{ ref('stg_specialoffer') }}
    )
    , joined as (
        select 
        sop.special_offer_id,
        sop.product_id,
        so.description,
        so.discount_pct,
        so.offer_type,
        so.category,
        so.start_date,
        so.end_date,
        so.min_qty,
        so.max_qty 
        from  sop 
        join  so on sop.special_offer_id = so.special_offer_id
        )  
        , metrics as ( 
         select * ,
            count(distinct product_id)  as num_products,
            cast(avg(discount_pct) as float) as avg_discount_pct,
            count(offer_type) as offer_type_count,
            cast(avg(min_qty) as int) as avg_min_qty,
            cast(avg(max_qty) as int) as avg_max_qty

         from joined
         group by all
        )
        select * from metrics