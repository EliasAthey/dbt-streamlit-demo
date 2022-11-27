-- depends_on: {{ ref('stg_census__block_group_fields_2020') }}
-- depends_on: {{ ref('stg_census__block_groups_2020_total_pop') }}
{{- census_named_fields_for_year(2020, 'stg_census__block_groups_2020_total_pop') }}