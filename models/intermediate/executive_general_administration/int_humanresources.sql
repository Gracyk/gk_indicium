{{ config(materialized='table') }}

with 
    em as (
        select *
        from {{ ref('stg_employee') }}
    ),
    jb as (
        select *
        from {{ ref('stg_jobcandidate') }}
    ),    
    emph as (
        select *
        from {{ ref('stg_employeepayhistory') }}
    ),
    emdh as (
        select *
        from {{ ref('stg_employeedepartmenthistory') }}
    ),   
    s as (
        select *
        from {{ ref('stg_shift') }}
    ),
    d as (
        select *
        from {{ ref('stg_department') }}
    ),   
    joined as (
        select  
            em.business_entity_id,
            em.national_id_number,
            em.job_title,
            em.birth_date,
            em.gender,
            em.salaried_flag,
            em.vacation_hours,
            em.sick_leave_hours,
            em.current_flag,
            jb.job_candidate_id,
            emph.rate_change_date,
            emph.rate,
            emph.pay_frequency,
            emdh.department_id,
            emdh.shift_id,
            emdh.start_date,
            emdh.end_date,
            s.name as name_shift,
            s.start_time,
            d.name_department,
            d.group_name
            from  em
            left join  jb on em.business_entity_id=jb.job_candidate_id
            left join  emph on em.business_entity_id = emph.business_entity_id
            left join  emdh on em.business_entity_id=emdh.business_entity_id
            join  s on emdh.shift_id = s.shift_id
            join  d on emdh.department_id=d.department_id
            ),
            metrics as (
                select *,
                count(business_entity_id) as num_employees,
                avg(rate) as avg_salary,
                sum(vacation_hours) as total_vacation_hours,
                sum(sick_leave_hours) as total_sick_leave_hours,
                count(current_flag) as num_current_flag,
                cast(avg(datediff(year, birth_date, getdate())) as int) as avg_age,
                count(gender) as num_employees_gender
                from joined
                group by all
             )
            select * 
            from metrics
