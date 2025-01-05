
{{ config(materialized='table') }}

with
    c as (
        -- -- seleciona dados de Cartão de crédito  (credit card) 
select 
    c.customerid as customer_id,  -- Identificador único do cliente
    c.personid as person_id,      -- Identificador da pessoa associada ao cliente
    c.storeid as store_id,        -- Identificador da loja onde o cliente fez compras
    c.territoryid as territory_id, -- Identificador do território de vendas
    c.rowguid as row_guid,        -- Identificador único da linha
    cast(c.modifieddate as date) as modified_date   -- Data da última modificação no registro
from 
    {{ source('raw_adventure_works', 'customer') }} as c
    -- Tabela contendo dados sobre os clientes.
)
select *
from c