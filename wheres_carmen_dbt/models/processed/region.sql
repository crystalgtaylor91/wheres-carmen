select distinct
    {{ dbt_utils.generate_surrogate_key(['region']) }} as region_id,
    region
from
{{ ref('int_carmen_sightings') }}
