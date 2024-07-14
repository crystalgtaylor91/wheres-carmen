-- depends_on: {{ ref('witness') }}
-- depends_on: {{ ref('region') }}

with junction_table as (
    select distinct
        {{ dbt_utils.generate_surrogate_key(['witness']) }} as witness_id,
        {{ dbt_utils.generate_surrogate_key(['region']) }} as region_id
    from
        {{ ref('int_carmen_sightings') }}
)
select 
    {{ dbt_utils.generate_surrogate_key(['witness_id', 'region_id']) }} as witness_region_id,
    witness_id,
    region_id
from
    junction_table
    