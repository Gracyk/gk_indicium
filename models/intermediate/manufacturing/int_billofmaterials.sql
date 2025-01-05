{{ config(materialized='table') }}
with
    bom as (
        select *
        from {{ ref('stg_billofmaterials') }}
    )
    , 
        um as (
        select *
        from {{ ref('stg_unitmeasure') }}
    )
     ,
        joined as (
        select 
        bom.bill_of_materials_id,
        bom.product_assembly_id,
        bom.component_id,
        bom.start_date,
        bom.end_date,
        bom.unit_measure_code,
        bom.bom_level,
        bom.per_assembly_qty,
        um.name as name_measure
        from  bom  
        join  um on bom.unit_measure_code= um.unit_measure_code
        )   
    select * from joined