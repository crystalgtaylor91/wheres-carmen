select distinct
    {{ dbt_utils.generate_surrogate_key(['date_agent']) }} as date_agent_id,
    date_agent
from
{{ ref('int_carmen_sightings') }}
