{{
    config(
        materialized='incremental'
    )
}}

select * from
    (values(
        date_trunc('minute', current_timestamp(0)),
        date_part('second', current_timestamp(0))
        ) as v1(curr_minute, rng_value)
    )

{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  where curr_minute > (select max(curr_minute) from {{ this }})

{% endif %}