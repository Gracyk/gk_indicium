{{ config(materialized='table') }}
with
    cr as (
        select *
        from {{ ref('stg_creditcard') }}
    )

    , pcr as (
        select *
        from {{ ref('stg_personcreditcard') }}
    )
    , joined as (
        select 
        cr.credit_card_id,
        cr.card_type,
        cr.expiration_month,
        cr.expiration_year,
        pcr.business_entity_id as business_entity_person_id
        from  cr 
        left join  pcr
        on cr.credit_card_id = pcr.credit_card_id
    )
    select * from joined