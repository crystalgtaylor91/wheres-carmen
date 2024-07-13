with junction_table as (
    select distinct
        {{ dbt_utils.generate_surrogate_key(['agent']) }} as agent_id,
        {{ dbt_utils.generate_surrogate_key(['city_agent']) }} as city_agent_id
    from
        {{ ref('int_carmen_sightings') }}
)
select 
    {{ dbt_utils.generate_surrogate_key(['agent_id', 'city_agent_id']) }} as agent_city_id,
    agent_id,
    city_agent_id
from
    junction_table
    