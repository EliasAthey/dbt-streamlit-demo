{{ config(tags=["twitter"]) }}

select
    tweet,
    labels
from
    {{ ref('incr_ftr_tweet_sentiment') }}
where 
    feature_version = 1
    and labels like '%data%'
    