{{ config(tags=["twitter"]) }}
-- I think it would make sense to refactor this as a dbt python model
-- in the python code, use snowpark to reigster a UDF for inference  - which selects from the feature table
select
    tweet
from
    {{ ref('incr_ftr_tweet_sentiment') }}
where 
    feature_version = 1
    