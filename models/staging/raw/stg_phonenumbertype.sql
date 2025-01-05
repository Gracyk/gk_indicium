
{{ config(materialized='table') }}

with
    p as (
       
select 
    p.phonenumbertypeid as phone_number_type_id,  -- Identificador do tipo de telefone
    p.name as name,                               -- Nome do tipo de telefone
    cast(p.modifieddate as date) as modified_date -- Data da última modificação no registro
   
from 
   {{ source('raw_adventure_works', 'phonenumbertype') }} as p -- Tabela contendo tipos de telefone.

)
select *
from p