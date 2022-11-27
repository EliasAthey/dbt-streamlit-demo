{% set relations=[ref('int_census_2019_name_fields'), ref('int_census_2020_name_fields')] %}
{{- dbt_utils.union_relations(relations) }}