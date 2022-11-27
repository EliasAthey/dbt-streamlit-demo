{%- macro stage_census_field_table(table_name) -%}

with source as (
    select
        *
    from
        {{source('census',table_name)}}
),
{%- set field_list=[
    'TABLE_TITLE',
    'FIELD_LEVEL_1',
    'FIELD_LEVEL_2',
    'FIELD_LEVEL_3',
    'FIELD_LEVEL_4',
    'FIELD_LEVEL_5',
    'FIELD_LEVEL_6',
    'FIELD_LEVEL_7',
    'FIELD_LEVEL_8',
    'FIELD_LEVELl_9',
    'FIELD_LEVEL_10']
%}
{%- set replacements={
    'total': 'ttl',
    'population': 'pop',
    'marginoferror': 'moe',
    'estimate': 'est',
    '_the_': '_',
    'combination': 'combo',
    'american_indian': 'us_natv',
    'alaska_native': 'ak_natv',
    'native_hawaiian': 'hi_natv',
    'other_pacific_islander': 'pac_natv',
    'hispanic_or_latino': 'span_lat',
    'black_or_african_american': 'blck_afr',
    'white': 'wht',
    'asian': 'asn'
}
%}
renamed as (
    select
        TABLE_ID as field_id,
        {%- for i in range(replacements|length) %}
        replace(
        {%- endfor %}
            trim(replace(lower(concat_ws('__',
            {%- for f in field_list %}
                coalesce("{{f}}",''){% if not loop.last %},{% endif %}
            {%- endfor %}
            )), ' ', '_'), '_'),
        {%- for repl in replacements %}
        '{{repl}}','{{replacements[repl]}}'){% if not loop.last %},{% endif %}
        {%- endfor %}
        as field_name
    from
        source
)
select * from renamed

{%- endmacro -%}