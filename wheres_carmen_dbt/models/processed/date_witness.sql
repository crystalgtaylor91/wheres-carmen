select distinct
    {{ dbt_utils.generate_surrogate_key(['date_witness']) }} as date_witness_id,
    date_witness
from
{{ ref('int_carmen_sightings') }}
