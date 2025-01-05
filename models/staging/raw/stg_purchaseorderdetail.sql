
{{ config(materialized='table') }}

with
    pod as (

select 
    pod."purchaseorderid" as purchase_order_id,         -- ID do pedido de compra
    pod."purchaseorderdetailid" as purchase_order_detail_id,  -- ID do detalhe do pedido de compra
    cast(pod."duedate" as date) as due_date,                          -- Data de vencimento do pedido de compra
    pod."orderqty" as order_qty,                        -- Quantidade do pedido de compra
    pod."productid" as product_id,                      -- ID do produto associado ao pedido
    pod."unitprice" as unit_price,                      -- Preço unitário do produto
    pod."receivedqty" as received_qty,                  -- Quantidade recebida do produto
    pod."rejectedqty" as rejected_qty,                  -- Quantidade rejeitada do produto
    cast(pod."modifieddate" as date) as modified_date    -- Data da última modificação no registro
from 
    {{ source('raw_adventure_works', 'purchaseorderdetail') }} as pod
    -- Tabela contendo os detalhes dos pedidos de compra no sistema AdventureWorks.
)
select *
from pod