{% set tables=[
    '2020_CBG_B01',
    '2020_CBG_B02',
    '2020_CBG_B03',
    '2020_CBG_B09',
    '2020_CBG_B19',
    '2020_CBG_B99',
    '2020_CBG_C02'] %}
{{ stage_census_table(tables) }}