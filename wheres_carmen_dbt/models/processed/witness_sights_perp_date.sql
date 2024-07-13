with junction_table as (
    select distinct
        {{ dbt_utils.generate_surrogate_key(['witness']) }} as witness_id,
        {{ dbt_utils.generate_surrogate_key(['date_witness']) }} as date_witness_id
    from
        {{ ref('int_carmen_sightings') }}
)
select 
    {{ dbt_utils.generate_surrogate_key(['witness_id', 'date_witness_id']) }} as witness_date_id,
    witness_id,
    date_witness_id
from
    junction_table
    