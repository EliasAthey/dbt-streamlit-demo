{{
    config(
        materialized='incremental',
        on_schema_change='append_new_columns'
    )
}}

select
    date_trunc('minute', $1) as curr_minute,
    normal(0, 1, random()) as rng_value,
    $1 as raw_timestamp
from
    (values (current_timestamp(0)) )

{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  where curr_minute > (select max(curr_minute) from {{ this }})

{% endif %}