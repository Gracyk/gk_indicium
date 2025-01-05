
{{ config(materialized='table') }}

with
    poh as (

select 
    poh.purchaseorderid as purchase_order_id,  -- ID do pedido de compra
    poh.revisionnumber as revision_number,      -- Número da revisão do pedido de compra
    poh.status as status,                       -- Status do pedido de compra
    poh.employeeid as employee_id,              -- ID do funcionário responsável pelo pedido
    poh.vendorid as vendor_id,                  -- ID do fornecedor
    poh.shipmethodid as ship_method_id,         -- ID do método de envio
    cast(poh.orderdate as date) as order_date,                -- Data do pedido
    cast(poh.shipdate as date) as ship_date,                  -- Data do envio
    poh.subtotal as subtotal,                   -- Subtotal do pedido
    poh.taxamt as tax_amount,                   -- Valor do imposto do pedido
    poh.freight as freight,                     -- Custo do frete
    cast(poh.modifieddate as date) as modified_date -- Data da última modificação
from 
    {{ source('raw_adventure_works', 'purchaseorderheader') }} as poh
    -- Tabela contendo as informações dos pedidos de compra no sistema AdventureWorks.
)
select *
from poh