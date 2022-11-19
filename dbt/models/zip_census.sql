select
    *
from
    {{ ref('stg_zip_to_cbg') }} zip
    left join {{ ref('stg_cbg_total_pop') }} census
        on zip.blockgroup = census.census_block_group