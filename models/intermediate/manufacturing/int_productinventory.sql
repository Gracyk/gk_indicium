{{ config(materialized='table') }}
with
    pi as (
        select *
        from {{ ref('stg_productinventory') }}
    )
    , 
        l as (
        select *
        from {{ ref('stg_location') }}
    )
    , 
        wor as (
        select *
        from {{ ref('stg_workorderrouting') }}
    )
    , 
        wo as (
        select *
        from {{ ref('stg_workorder') }}
    )
    , 
        sr as (
        select *
        from {{ ref('stg_scrapreason') }}
    )
    , 
     
    joined as (
        select 
        pi.product_id,
        pi.location_id,
        pi.shelf,
        pi.bin,
        pi.quantity,
        l.location_name,
        l.availability,
        wor.work_order_id,
        wor.operation_sequence,
        wor.scheduled_start_date,
        wor.scheduled_end_date,
        wor.actual_start_date,
        wor.actual_end_date,
        wor.actual_resource_hours,
        wor.planned_cost,
        wo.order_quantity,
        wo.scrapped_quantity,
        wo.start_date,
        wo.end_date,
        wo.due_date,
        wo.scrap_reason_id,
        sr.name as name_scrap_reason
        from   pi 
        left join l on pi.location_id = l.location_id
         join  wor on l.location_id = wor.location_id and wor.product_id=pi.product_id
         join  wo on wor.work_order_id = wo.work_order_id
        left join  sr on wo.scrap_reason_id = sr.scrap_reason_id
        )   
        , metrics as
         (
            select*,
            count(distinct product_id) as num_products,                          -- número de produtos distintos
            sum(quantity) as total_quantity,                                    -- quantidade total de produtos em inventário
            cast(avg(quantity) as int) as avg_quantity_per_location,                         -- quantidade média de produtos por local
            count(distinct work_order_id) as num_work_orders,                   -- número total de ordens de trabalho
            cast(avg(order_quantity) as int) as avg_order_quantity,                          -- quantidade média por ordem de trabalho
            sum(scrapped_quantity) as total_scrapped_quantity,                  -- quantidade total de itens descartados
            cast((sum(scrapped_quantity) / nullif(sum(quantity), 0))as int) as scrap_rate, -- taxa de descarte
            avg(planned_cost) as avg_planned_cost,                             -- custo planejado médio das ordens de trabalho
            avg(actual_resource_hours) as avg_actual_resource_hours,           -- média de horas reais de recursos usados
            cast(avg(datediff('day', start_date, end_date)) as int) as avg_order_duration -- duração média em dias das ordens de trabalho
            
        from joined
        group by all
       ) select * from metrics