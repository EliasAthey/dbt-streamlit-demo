{{ config(tags=["twitter"]) }}

with features as (
    select
        3 as feature_version,
        id,
        regexp_replace(tweet, 'RT|@\w*\b', '') tweet,
        labels,
        createddate as create_date,
        date_trunc('day', createddate) created_day
    from
        {{ ref('stg_tweets') }}
)

select
    *
from features