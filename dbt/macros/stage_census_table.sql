{% macro stage_census_table(tables) -%}

with sources as (
    select
        "{{tables[0]}}"."CENSUS_BLOCK_GROUP" as block_group
        {% for tab in tables %}
        ,{{ dbt_utils.star(source('census', tab), except=["CENSUS_BLOCK_GROUP"]) -}}
        {% endfor %}
    from
        {{source('census', tables[0])}} as "{{tables[0]}}"
        {% for tab in tables[1:] %}
        left join {{ source('census', tab)}} as "{{tab}}"
            on "{{tables[0]}}"."CENSUS_BLOCK_GROUP" = "{{tab}}"."CENSUS_BLOCK_GROUP"
        {% endfor %}
)
select * from sources

{%- endmacro %}