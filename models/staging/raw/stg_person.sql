
{{ config(materialized='table') }}

with
    p as (

select 

    p.businessentityid as business_entity_id,            -- Identificador único da pessoa
    p.persontype as person_type,                          -- Tipo de pessoa (por exemplo, funcionário, cliente)
    p.namestyle as name_style,                            -- Estilo de nome (Primeiro nome, Sobrenome, etc.)
    p.title as title,                                    -- Título (ex: Sr., Sra., Dr., etc.)
    p.firstname as first_name,                           -- Primeiro nome da pessoa
    p.middlename as middle_name,                         -- Nome do meio da pessoa
    p.lastname as last_name,                             -- Sobrenome da pessoa
    p.suffix as suffix,                                  -- Sufixo (ex: Jr., II, III, etc.)
    p.emailpromotion as email_promotion,                 -- Indica se a pessoa recebe promoções por e-mail
    p.additionalcontactinfo as additional_contact_info,  -- Informações de contato adicionais
    p.demographics as demographics,                      -- Dados demográficos da pessoa
    p.rowguid as row_guid,                               -- Identificador único da linha
    cast(p.modifieddate  as date) as modified_date       -- Data da última modificação no registro
from 
    {{ source('raw_adventure_works', 'person') }} as p
-- Tabela contendo informações detalhadas sobre as pessoas, incluindo dados pessoais e de contato.
)
select * from p