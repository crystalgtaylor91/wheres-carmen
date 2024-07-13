select distinct
    {{ dbt_utils.generate_surrogate_key(['city']) }} as location_id,
    country,
    city,
    longitude,
    latitude
from 
    {{ ref('int_carmen_sightings')}}
