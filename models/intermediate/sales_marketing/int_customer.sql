
{{ config(materialized='table') }}

with
    c as (
        select *
        from {{ ref('stg_customer') }}
    )

    , p as (
        select *
        from {{ ref('stg_person') }}
    )
    , ea as (
        select *
        from {{ ref('stg_emailaddress') }}
    )

    , pp as (
        select *
        from {{ ref('stg_personphone') }}
    )
     , pnt as (
        select *
        from {{ ref('stg_phonenumbertype') }}
    )   
    , bec as (
        select *
        from {{ ref('stg_businessentitycontact') }}
    )
    , ct as (
        select *
        from {{ ref('stg_contacttype') }}
    )
    , be as (
        select *
        from {{ ref('stg_businessentity') }}
    )
    , bea as (
        select *
        from {{ ref('stg_businessentityaddress') }}
    )
    ,
     s as (
        select *
        from {{ ref('stg_store') }}
    )
    ,
     joined as (
        select  
        c.customer_id,
        c.person_id,
        c.store_id,
        c.territory_id,
        p.title,
        ifnull(p.first_name,'')||' '||ifnull(p.middle_name,'')||ifnull(p.last_name,'')  as name_customer,
        p.suffix,
        p.email_promotion,
        ea.email_address_id,
        ea.email_address,
        pp.phone_number,
        pp.phone_number_type_id,
        pnt.name as name_type_number,
        bec.contact_type_id,
        ct.name as name_contact_type,
        be.business_entity_id,
        bea.address_id,
        bea.address_type_id,
        s.name_store,
        s.sales_person_id
        from  c 
        left join p on c.person_id =  p.business_entity_id
        left join ea on c.person_id = ea.business_entity_id
        left join pp on c.person_id  = pp.business_entity_id
        left join pnt on pp.phone_number_type_id = pnt.phone_number_type_id
        left join bec  on  c.person_id = bec.person_id
        left join ct on bec.contact_type_id = ct.contact_type_id
        left join be on bec.business_entity_id = be.business_entity_id
        left join bea on be.business_entity_id = bea.business_entity_id
        left join s on c.store_id = s.business_entity_id
)
select * from joined
