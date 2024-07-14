-- depends_on: {{ ref('agent') }}
-- depends_on: {{ ref('city_agent') }}
-- depends_on: {{ ref('date_agent') }}

select distinct
    {{ dbt_utils.generate_surrogate_key(['agent', 'city_agent', 'date_agent'] )}} as agent_city_date_id,
    {{ dbt_utils.generate_surrogate_key(['agent']) }} as agent_id,
    {{ dbt_utils.generate_surrogate_key(['city_agent']) }} as city_agent_id,
    {{ dbt_utils.generate_surrogate_key(['date_agent']) }} as date_agent_id
from
    {{ ref('int_carmen_sightings') }}
