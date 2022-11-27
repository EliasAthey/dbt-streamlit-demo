{% set tables=[
    '2020_CBG_B01',
    '2020_CBG_B02',
    '2020_CBG_B03'] %}
{{ stage_census_table(tables) }}