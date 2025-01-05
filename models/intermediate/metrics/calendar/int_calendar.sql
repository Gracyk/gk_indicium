{{ config(materialized='table') }}

    with calendario as (
    select
        dateadd(day, seq4(), '2000-01-01') as data
    from table(generator(rowcount => 36525)) -- gera 100 anos (365 dias * 100 anos)
)
select 
    to_number(to_char(data, 'yyyymmdd')) as data_key,
    to_date(data) data,
    data as data_tntz,
    year(data) as ano,
    month(data) as mes,
    monthname(data) as nome_mes,
    ceil(month(data) / 3.0) as trimestre,
    day(data) as dia,
    dayofweek(data) as dia_da_semana, -- snowflake retorna 0=domingo, 6=sábado
    dayname(data)  as nome_dia_semana,
    week(data) as semana_ano,
    case when dayofweek(data) in (1, 7) then true else false end as final_semana
from calendario 