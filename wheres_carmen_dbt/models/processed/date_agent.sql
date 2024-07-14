select distinct
    {{ dbt_utils.generate_surrogate_key(['date_agent']) }} as date_agent_id,
    date_agent,
    year(date_agent)::int as year,
    month(date_agent)::int as month,
    day(date_agent)::int as day
from
{{ ref('int_carmen_sightings') }}
