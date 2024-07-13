select distinct
    {{ dbt_utils.generate_surrogate_key(['city_agent']) }} as city_agent_id,
    city_agent
from
{{ ref('int_carmen_sightings') }}
