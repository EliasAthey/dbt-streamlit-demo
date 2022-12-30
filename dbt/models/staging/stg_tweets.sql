{{ config(tags=["twitter"]) }}

with source as (
    select
        *
    from
        {{source('tweets','TWEETS')}}
),
renamed as (
    select
        id,
        text as tweet,
        keywords as labels,
        createddate,
        createddate as updated_at
    from
        source
)
select * from renamed