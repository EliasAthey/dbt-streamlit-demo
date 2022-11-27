{% set tables=[
    '2019_CBG_B01',
    '2019_CBG_B02',
    '2019_CBG_B03',
    '2019_CBG_B09',
    '2019_CBG_B19',
    '2019_CBG_B99',
    '2019_CBG_C02'] %}
{{ stage_census_table(tables) }}