{{ config(materialized='table') }}

with
    jc as (
         
select 
    jc.jobcandidateid as job_candidate_id,     -- ID do candidato
    jc.businessentityid as business_entity_id, -- ID da entidade de negócios
    jc.resume as resume,                        -- Currículo
    cast(jc.modifieddate as date) as modified_date  -- Data da última modificação
from     
   {{ source('raw_adventure_works', 'jobcandidate') }} as jc
-- Tabela que contém informações sobre os candidatos a empregos.


)
select *
from jc