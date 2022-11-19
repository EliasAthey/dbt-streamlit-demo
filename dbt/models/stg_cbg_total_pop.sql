select
    CENSUS_BLOCK_GROUP,
    TOTAL_POP_EST,
    TOTAL_POP_EST_ERR
from {{ source('raw', 'cbg_total_pop')}}