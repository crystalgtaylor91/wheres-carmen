-- depends_on: {{ ref('witness') }}
-- depends_on: {{ ref('region') }}
-- depends_on {{ ref('date_witness') }}

select distinct
    {{ dbt_utils.generate_surrogate_key(['witness', 'region', 'date_witness']) }} as witness_region_date_id,
    {{ dbt_utils.generate_surrogate_key(['witness']) }} as witness_id,
    {{ dbt_utils.generate_surrogate_key(['region']) }} as region_id,
    {{ dbt_utils.generate_surrogate_key(['date_witness']) }} as date_witness_id
from
    {{ ref('int_carmen_sightings') }}
