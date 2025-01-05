{{ config(materialized='table') }}

with
    soh as (
      -- seleciona dados do cabeçalho dos pedidos de venda (sales order header)
select 
    soh.salesorderid as order_id, -- id do pedido de venda
    soh.revisionnumber as revision_number, -- número de revisão
    cast(soh.orderdate as date) as order_date, -- data do pedido
    cast(soh.duedate as date) as due_date, -- data de vencimento
    cast(soh.shipdate as date) as ship_date, -- data de envio
    soh.status as order_status, -- status do pedido
    soh.onlineorderflag as is_online_order, -- pedido online (sim/não)
    soh.purchaseordernumber as purchase_order_number, -- número do pedido de compra
    soh.accountnumber as account_number, -- número da conta
    soh.customerid as customer_id, -- id do cliente
    soh.salespersonid as salesperson_id, -- id do vendedor
    soh.territoryid as territory_id, -- id do território
    soh.billtoaddressid as billing_address_id, -- id do endereço de cobrança
    soh.shiptoaddressid as shipping_address_id, -- id do endereço de entrega
    soh.shipmethodid as shipping_method_id, -- id do método de envio
    soh.creditcardid as credit_card_id, -- id do cartão de crédito
    soh.creditcardapprovalcode as credit_card_approval_code, -- código de aprovação do cartão
    soh.currencyrateid as currency_rate_id, -- id da taxa de câmbio
    soh.subtotal as subtotal_amount, -- subtotal (valor antes de impostos e frete)
    soh.taxamt as tax_amount, -- valor do imposto
    soh.freight as freight_amount, -- valor do frete
    soh.totaldue as total_due, -- total devido
    soh.comment as order_comment, -- comentário do pedido
    soh.rowguid as row_guid, -- identificador único da linha
    cast(soh.modifieddate as date) as modified_date -- data da última modificação
from 
     {{ source('raw_adventure_works', 'salesorderheader') }} as soh -- cabeçalho do pedido de venda
  
    )

select *
from soh
