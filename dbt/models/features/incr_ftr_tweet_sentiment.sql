{{
    config(
        materialized='incremental',
        tags=["twitter"]
    )
}}

select
    *
from {{ ref('ftrs__tweet_sentiment') }}

{% if is_incremental() -%}

  -- this filter will only be applied on an incremental run
  where feature_version > (select max(feature_version) from {{ this }})

{%- endif %}