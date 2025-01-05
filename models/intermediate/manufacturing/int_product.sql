{{ config(materialized='table') }}
with
    p as (
        select *
        from {{ ref('stg_product') }}
    )
    , joined as (
        select 
         p.product_id
        ,p.product_name
        ,p.product_number
        ,p.make_flag
        ,p.finished_goods_flag
        ,p.color
        ,p.safety_stock_level
        ,p.reorder_point
        ,p.standard_cost
        ,p.list_price
        ,p.size
        ,p.size_unit_measure_code
        ,p.weight_unit_measure_code
        ,p.weight
        ,p.days_to_manufacture
        ,p.product_line
        ,p.class
        ,p.style
        ,p.product_subcategory_id
        ,p.product_model_id
        ,p.sell_start_date
        ,p.sell_end_date
        ,p.discontinued_date
        from p
    )
    select * from joined