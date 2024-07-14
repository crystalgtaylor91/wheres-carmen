with date_joined_behavior as (
	select 
        {{ ref('date_witness') }}.date_witness, 
        {{ ref('date_witness') }}.year, 
        {{ ref('date_witness') }}.month, 
        {{ ref('observation') }}.behavior
	from {{ ref('sighting') }}
	inner join {{ ref('witness_sights_perp_region_date') }}
		on {{ ref('sighting') }}.witness_region_date_id = {{ ref('witness_sights_perp_region_date') }}.witness_region_date_id
	inner join {{ ref('date_witness') }}
		on {{ ref('witness_sights_perp_region_date') }}.date_witness_id = {{ ref('date_witness') }}.date_witness_id
	inner join {{ ref('observation') }}
		on {{ ref('sighting') }}.observation_id = {{ ref('observation') }}.observation_id
), filtered_by_behavior as (
	select
        date_witness,
        year,
        month,
        behavior
	from date_joined_behavior
	where behavior in (
        select 
            {{ ref('analytics_common_behaviors') }}.behavior
        from {{ ref('analytics_common_behaviors') }}
    )
)
select 
    year, 
    month, 
    round(
        count(*) / (
            select 
                count(*) 
            from date_joined_behavior 
            where filtered_by_behavior.year = date_joined_behavior.year
                and filtered_by_behavior.month = date_joined_behavior.month
        ) ,2
    ) as probability
from filtered_by_behavior
group by 
    year, 
    month
    