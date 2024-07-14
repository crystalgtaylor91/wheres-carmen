with dates_criteria as (
    select 
        {{ ref('date_witness') }} .date_witness, 
        {{ ref('date_witness') }} .year, 
        {{ ref('date_witness') }} .month, 
        case 
            when {{ ref('observation') }}.has_weapon = true 
                and {{ ref('observation') }}.has_jacket = true 
                and not {{ ref('observation') }}.has_hat = true 
            then 1 
            else 0 
        end as matches_criteria
    from {{ ref('sighting') }}
    inner join {{ ref('observation') }}
        on {{ ref('sighting') }}.observation_id = {{ ref('observation') }}.observation_id
    inner join {{ ref('witness_sights_perp_region_date') }} 
        on {{ ref('sighting') }}.witness_region_date_id = {{ ref('witness_sights_perp_region_date') }}.witness_region_date_id 
    inner join {{ ref('date_witness') }} 
        on {{ ref('witness_sights_perp_region_date') }}.date_witness_id = {{ ref('date_witness') }} .date_witness_id
)
select 
    dates_criteria.year,
    dates_criteria.month,
    round(sum(dates_criteria.matches_criteria) / count(dates_criteria.matches_criteria), 2) as probability
from dates_criteria
group by 
    dates_criteria.year,
    dates_criteria.month
order by 
    dates_criteria.year,
    dates_criteria.month
