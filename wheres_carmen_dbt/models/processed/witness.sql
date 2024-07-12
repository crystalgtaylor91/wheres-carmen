select distinct
    {{ dbt_utils.generate_surrogate_key(['witness', 'date_witness']) }} as witness_id,
    witness, 
    date_witness
from
    {{ ref('int_carmen_sightings') }}
    