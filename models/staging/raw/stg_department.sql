{{ config(materialized='table') }}

with
    d as (
         
select 
    d.departmentid as department_id,  -- ID do departamento
    d.name as name_department,            -- Nome do departamento
    d.groupname as group_name,           -- Grupo do departamento
    cast(d.modifieddate as date) as modified_date -- Data da última modificação
from     
   {{ source('raw_adventure_works', 'department') }} as d
-- Tabela que contém os departamentos dos funcionários.


)
select *
from d