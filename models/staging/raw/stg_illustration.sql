
{{ config(materialized='table') }}

with
    i as (
         -- seleciona dados de Cartão de crédito  (credit card) 
select 
    i.illustrationid as illustration_id,         -- ID da ilustração
    i.diagram as diagram,                         -- Diagrama representando a ilustração
    cast(i.modifieddate as date) as modified_date   -- Data da última modificação
from 
  {{ source('raw_adventure_works', 'illustration') }} as i
-- Tabela contendo informações sobre as ilustrações no sistema AdventureWorks, como o diagrama associado.

)
select *
from i