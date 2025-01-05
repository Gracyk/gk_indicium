{{ config(materialized='table') }}

with
    a as (
        select *
        from {{ ref('stg_address') }}
    )

    , st as (
        select *
        from {{ ref('stg_stateprovince') }}
    )
    , cr as (
        select *
        from {{ ref('stg_countryregion') }}
    )

    , bea as (
        select *
        from {{ ref('stg_businessentityaddress') }}
    )
     , at as (
        select *
        from {{ ref('stg_addresstype') }}
    ) 
    , joined as (
        select 
        a.address_id,
        a.address_line_1,
        a.address_line_2,
        a.city,
        a.state_province_id,
        st.state_province_code,
        st.country_region_code,
        st.name as name_state_province,
        st.territory_id,
        cr.name as name_country_region,
        bea.business_entity_id,
        bea.address_type_id,
        at.name as name_address_type
        from  a
        left join st on a.state_province_id = st.state_province_id
        left join cr on st.country_region_code = cr.country_region_code
        left join bea on a.address_id = bea.address_id
        left join at on bea.address_type_id = at.address_type_id

    ) select * from joined
