{{ config(materialized='table') }}

with
    emp as (

select 
    emp.businessentityid as business_entity_id,         -- Identificador único do funcionário
    emp.nationalidnumber as national_id_number,          -- Número de identificação nacional do funcionário
    emp.loginid as login_id,                             -- ID de login do funcionário
    emp.jobtitle as job_title,                           -- Cargo do funcionário
    emp.birthdate as birth_date,                         -- Data de nascimento do funcionário
    emp.maritalstatus as marital_status,                 -- Estado civil do funcionário
    emp.gender as gender,                                -- Gênero do funcionário
    emp.hiredate as hire_date,                           -- Data de contratação
    emp.salariedflag as salaried_flag,                   -- Indica se o funcionário é assalariado
    emp.vacationhours as vacation_hours,                 -- Horas de férias disponíveis
    emp.sickleavehours as sick_leave_hours,               -- Horas de licença médica disponíveis
    emp.currentflag as current_flag,                     -- Indica se o funcionário está ativo
    emp.rowguid as row_guid,                             -- Identificador único da linha
   cast(emp.modifieddate  as date) as modified_date,     -- Data da última modificação no registro
    emp.organizationnode as organization_node           -- Nó da organização do funcionário
from 
    {{ source('raw_adventure_works', 'employee') }} as emp
-- Tabela contendo informações sobre os funcionários da empresa, incluindo dados pessoais, status de emprego, e cargo.
)
select * 
from emp
