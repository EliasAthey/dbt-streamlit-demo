select
    *
from
    {{ ref('stg_postal__sf_postals') }} postal
    left join {{ ref('int_census_all_years') }} census
        on postal.census_block_group = census.block_group
order by
    postal.census_block_group,
    year