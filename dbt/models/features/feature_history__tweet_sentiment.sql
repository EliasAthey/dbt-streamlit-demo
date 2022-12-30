{{
    config(
        materialized='incremental',
        on_schema_change='append_new_columns',
        full_refresh=false,
        tags=["twitter"]
    )
}}

select
    *,
    current_timestamp() as updated_at
from {{ ref('features__tweet_sentiment') }}

{% if is_incremental() -%}
    where updated_at > (select max(updated_at) from {{ this }})
{%- endif %}