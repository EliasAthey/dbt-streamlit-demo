select
    *
from
    {{ source('raw', 'zip_to_cbg')}}