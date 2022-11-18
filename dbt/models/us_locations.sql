{{
    config(
        materialized='table'
    )
}}

select
      a.lat a_lat
    , a.lon a_lon
    , a.city
    , a.postcode
    , b.*
from
    {{ ref('stg_address') }} a
    left join {{ ref('stg_mvmt') }} b using (lat, lon)
where
    a.country = 'us'
