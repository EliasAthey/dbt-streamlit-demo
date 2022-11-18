select
	LAT as lat,
    LON as lon,
	NUMBER,
	STREET,
	UNIT,
	CITY,
	DISTRICT,
	REGION,
	POSTCODE,
	ID,
	HASH,
	COUNTRY
from
    {{ source('raw', 'openaddress')}}