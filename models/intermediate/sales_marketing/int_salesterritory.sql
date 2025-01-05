{{ config(materialized='table') }}
with
    st as (
        select *
        from {{ ref('stg_salesterritory') }}
    ),
    joined as (

    select 
    st.territory_id,
    st.territory_name,
    st.country_region_code,
    st.territory_group,
    st.sales_ytd,
    st.sales_last_year,
    st.cost_ytd,
    st.cost_last_year
    from  st
)
select * from joined