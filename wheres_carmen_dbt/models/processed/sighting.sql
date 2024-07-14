-- depends_on: {{ ref('agent_files_report_city_date') }}
-- depends_on: {{ ref('location') }}
-- depends_on: {{ ref('witness_sights_perp_region_date') }}
-- depends_on: {{ ref('observation') }}

with junction_table as (
    select distinct
        {{ dbt_utils.generate_surrogate_key(['agent', 'city_agent', 'date_agent']) }} as agent_city_date_id,
        {{ dbt_utils.generate_surrogate_key(['city']) }} as location_id,
        {{ dbt_utils.generate_surrogate_key(['witness', 'region', 'date_witness']) }} as witness_region_date_id,
        {{ dbt_utils.generate_surrogate_key(['has_weapon', 'has_hat', 'has_jacket', 'behavior']) }} as observation_id
    from
        {{ ref('int_carmen_sightings') }}
)
select 
    {{ dbt_utils.generate_surrogate_key(['agent_city_date_id', 'location_id', 'witness_region_date_id', 'observation_id']) }} as sighting_id,
    agent_city_date_id,
    location_id,
    witness_region_date_id,
    observation_id
from junction_table
