{{ config(materialized='table') }}

with
    s as (
        select *
        from {{ ref('fact_aggregatedsales') }}
    ),
     cc as (
        select *
        from {{ ref('dim_creditcard') }}
    )
    , c as (
        select *
        from {{ ref('dim_customer') }}
    )
   , sr as (
        select * 
        from {{ref ('dim_salesreason')}}
    )
     , st as (
        select * 
        from {{ref ('dim_salesterritory')}}

    ) , a as (
        select * 
        from {{ref ('dim_address')}}
    ) ,
      sm as (
        select * 
        from {{ref ('dim_shipmethod')}}
    ) ,

      sp as (
        select * 
        from {{ref ('dim_salesperson')}}
    ) ,
        cr as (
        select * 
        from {{ref ('dim_currencyrate')}}
    ) ,
        so as (
        select * 
        from {{ref ('dim_specialoffer')}}
    ) ,
     p as (
        select * 
        from {{ref ('dim_product')}}
    ) ,

    metrics_joined as (
        select distinct s.*,
        count(distinct cc.card_type) as number_sales_card_type,
        cc.card_type,
        count(distinct sr.name_sales_reason) as number_sales_reason,
        sr.name_sales_reason,
        count(distinct sr.reason_type) as number_reason_type,
        sr.reason_type,
        c.name_customer,
        c.store_id,
        c.name_store, 
        count(distinct c.store_id) as number_store_id,
        st.territory_name,
        st.country_region_code,
        st.territory_group,
        st.sales_ytd,
        st.sales_last_year,
        st.cost_ytd,
        st.cost_last_year,
        sm.ship_method_name,
        sm.ship_base,
        sm.ship_rate,
        sp.name_person_sales,
        sp.job_title,
        cr.name_currency,
        cr.currency_code,
        so.description,
        so.discount_pct,
        so.offer_type,
        so.category,
        p.product_name,
        p.product_number,
        a.city,
        a.state_province_id,
        a.state_province_code,
        a.country_region_code as country_region_code_ship,
        a.name_state_province,
        a.name_country_region as name_country_region_ship

        
    from s
    left join  cc  on s.credit_card_id =cc.credit_card_id 
    left join  c   on s.customer_id = c.customer_id  
    left join  sr  on s.order_id = sr.sales_order_id 
    left join  st  on s.territory_id = st.territory_id
    left join  sm  on s.shipping_method_id = sm.ship_method_id
    left join  sp  on s.salesperson_id = sp.business_entity_id
    left join  cr  on s.currency_rate_id = cr.currency_rate_id
    left join  so  on s.special_offer_id=so.special_offer_id
    left join  p   on s.product_id = p.product_id
    left join  a   on s.shipping_address_id = a.address_id
    group by all

    ) select 
        -- **1. informações do pedido**
        order_id,
        order_date,
        order_month,
        order_year,
        order_id_year,
        due_date,
        ship_date,
        order_status,
        purchase_order_number,
        account_number,

        -- **2. detalhes de itens do pedido**
        sales_order_detail_id,
        product_id,
        product_name,
        product_number,
        category,
        special_offer_id,
        offer_type,
        discount_pct,
        unit_price,
        unit_price_discount,
        quantity_purchased,
        had_discount,

        -- **3. informações do cliente**
        customer_id,
        name_customer,

        -- **4. informações da loja**
        store_id,
        name_store,
        number_store_id,

        -- **5. dados de vendas**
        sum_sales_year,
        sales_year,
        total_value_negotiated,
        total_net_traded_value,
        tax_amount,
        total_tax_amount,
        total_value_amount_year,
        gross_revenue,
        product_discounts,
        online_sales,
        offline_sales,
        ticket_medium,

        -- **6. informações de entrega**
        carrier_tracking_number,
        late_deliveries,
        percentage_late_deliveries,
        on_time_deliveries,
        percentage_of_deliveries_on_time,
        total_deliveries,
        ship_method_name,
        ship_base,
        ship_rate,
        city,
        state_province_id,
        state_province_code,
        country_region_code_ship,
        name_state_province,
        name_country_region_ship,

        -- **7. métodos e operações**
        credit_card_id,
        credit_card_approval_code,
        currency_rate_id,
        name_currency,
        currency_code,
        description,

        -- **8. vendedor e região**
        salesperson_id,
        name_person_sales,
        job_title,
        territory_id,
        territory_name,
        country_region_code,
        territory_group,
        sales_ytd,
        sales_last_year,
        cost_ytd,
        cost_last_year,

        -- **9. métricas e contagens**
        number_special_offer,
        number_order_status,
        number_shipping_method,
        number_salesperson_id,
        number_territory_id,
        number_orders,
        number_currency_rate_id,
        number_sales_card_type,
        card_type,
        number_sales_reason,
        name_sales_reason,
        number_reason_type,
        reason_type,

        -- **10. endereços**
        billing_address_id,
        shipping_address_id
        
            
        from metrics_joined