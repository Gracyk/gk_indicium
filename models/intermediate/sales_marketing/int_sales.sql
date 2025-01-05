{{ config(materialized='table') }}

with
    soh as (
        select *
        from {{ ref('stg_salesorderheader') }}
    )
    , sod as (
        select *
        from {{ ref('stg_salesorderdetail') }}

    ),
    metric_sales_year as  (
        select
         sum(subtotal_amount) as sum_sales_year,
         substr(order_date,1,4) as sales_year,
         order_id as order_id_year
         from soh 
         group by all
    )    
        
     , joined as (
        select 
            soh.order_id,        
            msy.order_id_year,
            msy.sum_sales_year,
            msy.sales_year,                 
            soh.revision_number,
            soh.order_date,
            soh.due_date,
            soh.ship_date,
            soh.order_status,
            soh.is_online_order,
            soh.purchase_order_number,
            soh.account_number,
            soh.customer_id,
            soh.salesperson_id,
            soh.territory_id,
            soh.billing_address_id,
            soh.shipping_address_id,
            soh.shipping_method_id,
            soh.credit_card_id,
            soh.credit_card_approval_code,
            soh.currency_rate_id,
            soh.subtotal_amount,
            soh.tax_amount,
            soh.total_due,
            sod.sales_order_detail_id,
            sod.carrier_tracking_number,
            sod.order_qty,
            sod.product_id,
            sod.special_offer_id,
            sod.unit_price,
            sod.unit_price_discount
            from  soh
            join metric_sales_year msy on soh.order_id = msy.order_id_year
            left join  sod on soh.order_id = sod.sales_order_id
            
        
    )
    , metrics as(
        select *,
        count(distinct special_offer_id) as number_special_offer,
        count(distinct order_status) as number_order_status,
        count(distinct shipping_method_id) as number_shipping_method,
        count(distinct salesperson_id) as number_salesperson_id,
        count(distinct territory_id) as number_territory_id,
        year(order_date) as order_year,
        month(order_date) as order_month,
        count(distinct order_id) as number_orders,
        sum(distinct order_qty) as quantity_purchased,
        sum(distinct unit_price* order_qty) as total_value_negotiated,
        sum(distinct unit_price* order_qty - (1-unit_price_discount)) as total_net_traded_value,
        sum(distinct tax_amount) as total_tax_amount,
        count(distinct currency_rate_id) as number_currency_rate_id,
        count(case when ship_date <= due_date then 1 end) as on_time_deliveries,
        count(case when ship_date > due_date then 1 end) as late_deliveries,
        count(distinct ship_date) as total_deliveries,
        round(count  (case when ship_date <= due_date then 1 end) * 100.0 / count(distinct ship_date), 2) as percentage_of_deliveries_on_time,
        round(count  (case when ship_date > due_date then 1 end) * 100.0 / count(distinct ship_date), 2) as percentage_late_deliveries,
        case
                when unit_price_discount > 0 then true
                else false
            end as had_discount,
        sum(distinct subtotal_amount) as total_value_amount_year,
        sum(case when is_online_order = true then subtotal_amount else 0 end) as online_sales,
        sum(case when is_online_order = false then subtotal_amount else 0 end) as offline_sales,
        sum(distinct unit_price * order_qty) as gross_revenue,
        sum(distinct unit_price_discount * order_qty) as product_discounts,       
        (sum(distinct unit_price * order_qty) - sum(distinct unit_price_discount * order_qty)) / count(distinct order_id) as ticket_medium
        from joined
        group by all
    )

    select 
    *        
    from metrics    
  