{{ config(materialized='table') }}
with
    v as (
        select *
        from {{ ref('stg_vendor') }}
    ), 
        b as (
        select *
        from {{ ref('stg_businessentity') }}
    ), 
        p as (
        select *
        from {{ ref('stg_productvendor') }}
    ), 
        um as (
        select *
        from {{ ref('stg_unitmeasure') }}
    ), 
        poh as (
        select *
        from {{ ref('stg_purchaseorderheader') }}
    ), 
        podt as (
        select *
        from {{ ref('stg_purchaseorderdetail') }}
    
    ), 
    joined as (
        select
        v.business_entity_id,
        v.account_number,
        v.name as name_fornecedor,
        v.credit_rating,
        v.preferred_vendor_status,
        v.active_flag,
        p.product_id,
        p.average_lead_time,
        p.standard_price,
        p.last_receipt_cost,
        p.last_receipt_date,
        p.min_order_qty,
        p.max_order_qty,
        p.on_order_qty,
        p.unit_measure_code,
        um.name as name_measure,
        poh.purchase_order_id,
        poh.revision_number,
        poh.status,
        poh.employee_id,
        poh.vendor_id,
        poh.ship_method_id,
        poh.order_date,
        poh.ship_date,
        poh.subtotal,
        poh.tax_amount,
        poh.freight,
        podt.purchase_order_detail_id,
        podt.due_date,
        podt.order_qty,
        podt.unit_price,
        podt.received_qty,
        podt.rejected_qty

        from  v
        left join  b 
        on v.business_entity_id=b.business_entity_id

        left join   p
        on v.business_entity_id = p.business_entity_id

        join  um on p.unit_measure_code = um.unit_measure_code

        left join   poh on v.business_entity_id = poh.vendor_id

        left join  podt on poh.purchase_order_id= podt.purchase_order_id

        left join podt as podtp on podtp.product_id = p.product_id
 ) ,
    metrics as 
    (
           select *,
            count(distinct business_entity_id) as num_suppliers,
            avg(average_lead_time) as avg_lead_time,
            sum(subtotal + tax_amount + freight) as total_purchase_cost,
            avg(order_qty) as avg_order_qty ,
            sum(received_qty) as total_received_qty,
            sum(received_qty * unit_price) as total_receipt_cost,
            count(distinct purchase_order_id) as num_pending_orders,
            sum(rejected_qty) as total_rejected_qty
           from joined
           group by all

    )
    select * from metrics