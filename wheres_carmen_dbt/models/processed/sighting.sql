with junction_table as (
    select distinct
        {{ dbt_utils.generate_surrogate_key(['agent', 'date_agent']) }} as agent_id,
        {{ dbt_utils.generate_surrogate_key(['country', 'city']) }} as location_id,
        {{ dbt_utils.generate_surrogate_key(['witness', 'date_witness']) }} as witness_id,
        {{ dbt_utils.generate_surrogate_key(['has_weapon', 'has_hat', 'has_jacket', 'behavior']) }} as observation_id
    from
        {{ ref('int_carmen_sightings') }}
)
select 
    {{ dbt_utils.generate_surrogate_key(['agent_id', 'location_id', 'witness_id', 'observation_id']) }} as sighting_id,
    agent_id,
    location_id,
    witness_id,
    observation_id
from junction_table
