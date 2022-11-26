{% macro census_named_fields_for_year(year) %}

{%- set field_model_ref='stg_census__block_group_fields_' ~ year %}
{%- set model_ref='stg_census__block_groups_' ~ year %}

{%- set fields_q %}
select * from {{ref(field_model_ref)}}
where field_id in ({{dbt_utils.star(ref(model_ref), except=['block_group'])|replace('\"', "\'")}})
{%- endset %}

{%- set field_names=run_query(fields_q) %}
{%- if execute %}
select
    '{{year}}' as year,
    block_group,
    {%- for field_id, field_name in field_names %}
    "{{field_id}}" as "{{field_name}}"{% if not loop.last %},{% endif %}
    {%- endfor %}
from
    {{ref(model_ref)-}}

{%- endif %}

{%- endmacro %}