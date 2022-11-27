{% set relations=[ref('int_census_2019_total_pop'), ref('int_census_2020_total_pop')] %}
{{- dbt_utils.union_relations(relations) }}