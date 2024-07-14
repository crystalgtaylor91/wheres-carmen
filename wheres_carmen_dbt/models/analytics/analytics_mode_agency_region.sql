with region_date_witness as (
    select 
        {{ ref('region') }}.region,
        {{ ref('date_witness') }}.date_witness,
        {{ ref('date_witness') }}.year,
        {{ ref('date_witness') }}.month
    from {{ ref('witness_sights_perp_region_date') }}
    inner join {{ ref('date_witness') }}
        on {{ ref('witness_sights_perp_region_date') }}.date_witness_id = {{ ref('date_witness') }}.date_witness_id
    inner join {{ ref('region') }}
        on {{ ref('witness_sights_perp_region_date') }}.region_id = {{ ref('region') }}.region_id
)
select 
    region_date_witness.year, 
    region_date_witness.month,
    mode(region_date_witness.region) as region
from region_date_witness
group by 
    region_date_witness.year, 
    region_date_witness.month
order by 
    region_date_witness.year, 
    region_date_witness.month
    