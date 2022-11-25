select * from {{ ref('int_census_2019_name_fields') }}
union all
select * from {{ ref('int_census_2020_name_fields') }}