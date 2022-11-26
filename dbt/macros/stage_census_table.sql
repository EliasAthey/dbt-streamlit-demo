{% macro stage_census_table(tablename) %}

{%- set source_ref=source('census', tablename) %}

with source as (
    select
        *
    from
        {{source_ref}}
),
renamed as (
    select
        CENSUS_BLOCK_GROUP as block_group,
        {{ dbt_utils.star(source_ref, except=["CENSUS_BLOCK_GROUP"]) }}
    from
        source
)
select * from renamed

{%- endmacro %}