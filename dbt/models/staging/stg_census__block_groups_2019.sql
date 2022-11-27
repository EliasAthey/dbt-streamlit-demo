{% set tables=[
    '2019_CBG_B01',
    '2019_CBG_B02',
    '2019_CBG_B03'] %}
{{ stage_census_table(tables) }}