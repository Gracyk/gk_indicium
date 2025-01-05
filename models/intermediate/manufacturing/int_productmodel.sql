{{ config(materialized='table') }}
with
    pm as (
        select *
        from {{ ref('stg_productmodel') }}
    )
    , 
        pmi as (
        select *
        from {{ ref('stg_productmodelillustration') }}
    )
    , 
        i as (
        select *
        from {{ ref('stg_illustration') }}
    )
    , 
        pmdc as (
        select *
        from {{ ref('stg_productmodelproductdescriptionculture') }}
    )
    , 
        cult as (
        select *
        from {{ ref('stg_culture') }}
    )
    , 
        pd as (
        select *
        from {{ ref('stg_productdescription') }}
    )
    , 
    joined as (
        select 
        pm.product_model_id,
        pm.product_model_name,
        pmi.illustration_id,
        i.diagram, 
        pmdc.culture_id,
        cult.culture_name,
        pd.product_description_id,
        pd.product_description
        from  pm
        join  pmi on pm.product_model_id =pmi.product_model_id
        join  i on pmi.illustration_id=i.illustration_id
        join  pmdc on pm.product_model_id=pmdc.product_model_id
        join cult on pmdc.culture_id = cult.culture_id
        join pd on pmdc.product_description_id = pd.product_description_id
)   
    select * from joined