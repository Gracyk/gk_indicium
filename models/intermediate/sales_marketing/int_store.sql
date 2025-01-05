{{ config(materialized="table") }}


with s as (select * from {{ ref("stg_store") }})
select business_entity_id, name_store, sales_person_id, demographics

from s