{{ config(materialized='table') }}

with
    edh as (
         
select 
    edh.businessentityid as business_entity_id,  -- ID da entidade de negócios
    edh.departmentid as department_id,            -- ID do departamento
    edh.shiftid as shift_id,                      -- ID do turno
    cast(edh.startdate as date) as start_date,                  -- Data de início
    cast(edh.enddate as date) as end_date,                      -- Data de término
    cast(edh.modifieddate as date) as modified_date -- Data da última modificação
from     
   {{ source('raw_adventure_works', 'employeedepartmenthistory') }} as edh
-- Tabela que contém o histórico de departamentos dos funcionários.


)
select *
from edh