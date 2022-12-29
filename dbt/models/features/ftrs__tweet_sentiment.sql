{{ config(tags=["twitter"]) }}

select
    id,
    replace(tweet, 'RT', '') tweet,
    labels,
    createddate as create_date,
    1 as feature_version
from
    {{ ref('stg_tweets') }}