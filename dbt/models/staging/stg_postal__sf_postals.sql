with source as (
    select
        *
    from
        {{source('postal','ZIP_PLUS_4S_USA_SAMPLE')}}
),
renamed as (
    select
        BLOCKGROUP as census_block_group,
        ZIP as zip_code,
        STATE as state,
        COUNTYNAME as county,
        listagg(ST_NAME, ', ') as streets,
        listagg(
            case when REC_TYPE = 'F' then 'Firm'
            when REC_TYPE = 'G' then 'General DElivery'
            when REC_TYPE = 'H' then 'High-rise'
            when REC_TYPE = 'P' then 'PO Box'
            end, ', ') as postal_types,
        listagg(REC_TYPE, ', ') as postal_type_codes
    from
        source
    group by
        census_block_group,
        zip_code,
        state,
        county
)
select * from renamed