{{ config(materialized='table') }}

with 
    sp as (
        select *
        from {{ ref('stg_salesperson') }}
    ),
    st as (
        select *
        from {{ ref('stg_salesterritory') }}
    ),
    emp as (
        select *
        from {{ ref('stg_employee') }}
    ),
    p as (
        select *
        from {{ ref('stg_person') }}
    ),
    joined as (
        select 
            sp.business_entity_id,
            sp.territory_id,
            sp.sales_quota,        
            sp.bonus,
            sp.commission_pct,
            sp.sales_ytd,
            sp.sales_last_year,
            st.territory_name,
            st.country_region_code,
            st.territory_group,
            st.sales_ytd as sales_person_ytd_territory,
            st.sales_last_year as sales_person_last_year_territory,
            st.cost_ytd,
            st.cost_last_year,
            emp.national_id_number,
            emp.job_title,
            emp.birth_date,
            emp.gender,
            emp.hire_date,
            emp.salaried_flag,
            emp.vacation_hours,
            emp.sick_leave_hours,
            emp.current_flag,
            p.person_type,
            ifnull(p.first_name,' ') 
            || ' ' || ifnull(p.middle_name,' ') 
            || ' ' || ifnull(p.last_name,' ') as name_person_sales
        from sp 
        left join st on sp.territory_id = st.territory_id
        join emp on sp.business_entity_id = emp.business_entity_id
        join p on emp.business_entity_id = p.business_entity_id 
    ),
    metrics as (
        select 
            *,
            (sum(sales_ytd) / nullif(sum(sales_quota), 0) * 100) as number_quota_realized,
            case 
                when sales_ytd >= sales_quota then 'quota reached'
                else 'quota not met' 
            end as target_quota,
            round(sales_ytd * (commission_pct / 100), 2) as commission_value,
            round(((sales_ytd - sales_last_year) / nullif(sales_last_year, 0)) * 100, 2) as sales_growth,
            round(((sales_ytd - cost_ytd) / nullif(sales_ytd, 0)) * 100, 2) as profit_margin,
            round(cost_ytd / nullif(sales_ytd, 0), 2) as cost_per_sale,
            round(sales_ytd / nullif(vacation_hours, 0), 2) as sales_per_hour,
            round(sales_ytd / nullif(sales_last_year, 0), 2) as sales_retention_rate,
            round(cost_ytd / nullif(sales_ytd, 0), 2) as cac_per_sale,
            round(sales_ytd / nullif(sales_person_ytd_territory, 0), 2) as territory_sales_performance,
            round(((sales_ytd - sales_person_last_year_territory) / nullif(sales_person_last_year_territory, 0)) * 100, 2) as territory_sales_growth,
            round(sales_ytd / nullif(cost_ytd, 0), 2) as sales_to_cost_ratio,
            round(sales_ytd / count(*) over (partition by job_title), 2) as sales_per_role   
        from joined
        group by
        business_entity_id, 
        territory_id, 
        sales_quota, 
        bonus, 
        commission_pct, 
        sales_ytd, 
        sales_last_year, 
        sales_person_ytd_territory,
        sales_person_last_year_territory,
        territory_name, 
        country_region_code, 
        territory_group, 
        sales_ytd, 
        sales_last_year, 
        cost_ytd, 
        cost_last_year, 
        national_id_number, 
        job_title, 
        birth_date, 
        gender, 
        hire_date, 
        salaried_flag, 
        vacation_hours, 
        sick_leave_hours, 
        current_flag, 
        person_type, 
        name_person_sales

                
    )
select * 
from metrics
