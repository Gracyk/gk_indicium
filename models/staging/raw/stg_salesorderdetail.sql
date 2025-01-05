{{ config(materialized='table') }}

with
    sod as (
         
select 
    sod.salesorderid as sales_order_id,                -- ID do pedido de venda
    sod.salesorderdetailid as sales_order_detail_id,   -- ID do detalhe do pedido de venda
    sod.carriertrackingnumber as carrier_tracking_number, -- Número de rastreamento da transportadora
    sod.orderqty as order_qty,                          -- Quantidade do pedido
    sod.productid as product_id,                        -- ID do produto
    sod.specialofferid as special_offer_id,            -- ID da oferta especial
    sod.unitprice as unit_price,                        -- Preço unitário
    sod.unitpricediscount as unit_price_discount,      -- Desconto sobre o preço unitário
    sod.rowguid as row_guid,                            -- GUID da linha
   cast(sod.modifieddate as date) as modified_date     -- Data da última modificação
from     
    {{ source('raw_adventure_works', 'salesorderdetail') }} as sod
-- Tabela que contém os detalhes dos pedidos de venda.


)
select *
from sod