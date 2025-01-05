{{ config(materialized='table') }}

with
    p as (
        select *
        from {{ ref('int_product') }}
     ),
        pch as (
        select *
        from {{ ref('int_productcosthistory') }}
     ),
     pi as (
        select *
        from {{ ref('int_productinventory') }}
     ),
        pm as (
        select *
        from {{ ref('int_productmodel') }}
     ),
    pph as (
        select *
        from {{ ref('int_productpricehistory') }}
     ),
    sop as (
        select *
        from {{ ref('int_specialofferproduct') }}
     ),
     vpo as (
        select *
        from {{ ref('int_vendorpurchaseorder') }}
     ), 
     joined as (  

     select 
        p.product_id,
        p.product_name,
        p.product_number,
        pch.start_date as start_date_pch,
        pch.end_date as end_date_pch,
        pch.standard_cost,
        pch.num_products as num_products_pch,
        pch.avg_standard_cost,
        pch.total_cost_changes,
        pch.max_standard_cost,
        pch.min_standard_cost,
        pch.duration_avg_days,
        pi.shelf,
        pi.bin,
        pi.quantity,
        pi.location_name,
        pi.availability,
        pi.operation_sequence,
        pi.scheduled_start_date,
        pi.scheduled_end_date,
        pi.actual_start_date,
        pi.actual_end_date,
        pi.actual_resource_hours,
        pi.planned_cost,
        pi.order_quantity,
        pi.start_date as start_date_pi,
        pi.end_date as end_date_pi,
        pi.due_date,
        pi.name_scrap_reason,
        pi.num_products as num_products_pi,
        pi.total_quantity as total_quantity_prod_iven,
        pi.avg_quantity_per_location,
        pi.num_work_orders,
        pi.avg_order_quantity,
        pi.total_scrapped_quantity,
        pi.scrap_rate,
        pi.avg_planned_cost,
        pi.avg_actual_resource_hours,
        pi.avg_order_duration,
        pm.product_model_name,
        pm.culture_name,
        pm.product_description,
        pph.start_date as start_date_pph,
        pph.end_date as end_date_pph,
        pph.list_price,
        pph.number_price_entries,
        pph.average_price,
        pph.total_price,
        pph.price_range,
        pph.price_change_count,
        sop.description as description_sop,
        sop.discount_pct as discount_pct_sop,
        sop.offer_type as offer_type_sop,
        sop.category as category_sop,
        sop.start_date as start_date_sop,
        sop.end_date as end_date_sop,
        sop.min_qty,
        sop.max_qty,
        sop.num_products as num_products_sop,
        sop.avg_discount_pct,
        sop.offer_type_count,
        sop.avg_max_qty,
        sop.avg_min_qty,  
        vpo.name_fornecedor,
        vpo.credit_rating,
        vpo.preferred_vendor_status,
        vpo.active_flag,
        vpo.average_lead_time,
        vpo.last_receipt_cost,
        vpo.last_receipt_date,
        vpo.max_order_qty as max_order_qty_vpo,
        vpo.min_order_qty as min_order_qty_vpo,
        vpo.unit_measure_code,
        vpo.name_measure,
        vpo.revision_number,
        vpo.status,
        vpo.order_date,
        vpo.ship_date,
        vpo.subtotal,
        vpo.tax_amount,
        vpo.freight,
        vpo.order_qty,
        vpo.unit_price,
        vpo.received_qty,
        vpo.rejected_qty,
        vpo.num_suppliers,
        vpo.avg_lead_time,
        vpo.total_purchase_cost,
        vpo.avg_order_qty,
        vpo.total_received_qty,
        vpo.total_receipt_cost,
        vpo.num_pending_orders,
        vpo.total_rejected_qty

     from p 
     left join  pch  on p.product_id = pch.product_id     
     left join  pi on p.product_id = pi.product_id
     left join pm on p.product_model_id = pm.product_model_id
     left join pph on p.product_id = pph.product_id
     left join sop on p.product_id = sop.product_id
     left join vpo on p.product_id = vpo.product_id
     ) 
     select * from joined