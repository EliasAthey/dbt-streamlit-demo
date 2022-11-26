-- depends_on: {{ ref('stg_census__block_group_fields_2020') }}
-- depends_on: {{ ref('stg_census__block_groups_2020') }}
{{ census_named_fields_for_year(2020) }}