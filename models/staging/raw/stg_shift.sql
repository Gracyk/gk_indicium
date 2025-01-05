{{ config(materialized='table') }}

with
    s as (
         
select 
    s.shiftid as shift_id,              -- ID do turno
    s.name as name,                     -- Nome do turno
    cast(s.starttime as time) as start_time,          -- Hora de início
    cast(s.endtime as time) as end_time,              -- Hora de término
    cast(s.modifieddate as date) as modified_date     -- Data da última modificação
from     
    {{ source('raw_adventure_works', 'shift') }} as s
-- Tabela que contém os turnos de trabalho.



)
select *
from s