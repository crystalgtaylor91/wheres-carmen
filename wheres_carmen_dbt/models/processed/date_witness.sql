select distinct
    {{ dbt_utils.generate_surrogate_key(['date_witness']) }} as date_witness_id,
    date_witness,
    year(date_witness)::int as year,
    month(date_witness)::int as month,
    day(date_witness)::int as day
from
{{ ref('int_carmen_sightings') }}
