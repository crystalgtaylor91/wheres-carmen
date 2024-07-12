select distinct
    {{ dbt_utils.generate_surrogate_key(['country', 'city']) }} as location_id,
    country,
    city,
    longitude,
    latitude
from 
    {{ ref('int_carmen_sightings')}}
