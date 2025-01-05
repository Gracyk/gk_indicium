{{ config(materialized='table') }}
with
    so as (
        select *
        from {{ ref('stg_specialoffer') }}
    )

    select 
    special_offer_id,       -- ID da oferta especial
    description,               -- Descrição da oferta especial
    discount_pct,              -- Percentual de desconto
    offer_type,                       -- Tipo da oferta
    category,                     -- Categoria da oferta
    start_date,                  -- Data de início da oferta
    end_date,                      -- Data de término da oferta
    min_qty,                        -- Quantidade mínima para a oferta
    max_qty
    
    from so