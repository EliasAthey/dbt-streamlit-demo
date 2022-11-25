{% macro census_named_fields_for_year(year) %}

{% set field_model_ref='stg_census__block_group_fields_' ~ year %}
{% set fields_q %}
select * from {{ref(field_model_ref)}}
{% endset %}

{% set fields = run_query(fields_q) %}

{% if execute %}
{% set field_names = fields %}
{% set model_ref='stg_census__block_groups_' ~ year %}

select
    '{{year}}' as year,
    block_group,
    {% for field_id, field_name in field_names %}
    "{{field_id}}" as "{{field_name}}"{% if not loop.last %},{% endif %}
    {% endfor %}
from
    {{ref(model_ref)}}
{% endif %}

{% endmacro %}