with source as (
    select
        *
    from
        {{source('census','2020_METADATA_CBG_FIELD_DESCRIPTIONS')}}
),
renamed as (
    select
        TABLE_ID as field_id,
        trim(replace(lower(concat_ws('__',
            coalesce(TABLE_TITLE,''),
            coalesce(FIELD_LEVEL_1,''),
            coalesce(FIELD_LEVEL_2,''),
            coalesce(FIELD_LEVEL_3,''),
            coalesce(FIELD_LEVEL_4,''),
            coalesce(FIELD_LEVEL_5,''),
            coalesce(FIELD_LEVEL_6,''),
            coalesce(FIELD_LEVEL_7,''),
            coalesce(FIELD_LEVEL_8,''),
            coalesce("FIELD_LEVELl_9",''),
            coalesce(FIELD_LEVEL_10,'')
            )), ' ', '_'), '_') as field_name
    from
        source
    where TABLE_ID like 'B01%'
)
select * from renamed
