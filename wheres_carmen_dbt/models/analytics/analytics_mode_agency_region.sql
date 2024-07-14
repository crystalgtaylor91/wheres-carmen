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
), count_by_region as (
    select
        region,
        year,
        month,
        count(region) as region_count
    from region_date_witness
    group by
        year, 
        month,
        region
)
select 
    year, 
    month,
    region
from count_by_region
qualify region_count = max(region_count) over(partition by year, month)
order by 
    year, 
    month
    