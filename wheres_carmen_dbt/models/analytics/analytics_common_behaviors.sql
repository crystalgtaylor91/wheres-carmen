with behaviors as (
select 
    {{ ref('observation') }}.behavior,
    count({{ ref('observation') }}.behavior) as behavior_count
from {{ ref('sighting') }}
left join {{ ref('observation') }}
    on {{ ref('sighting') }}.observation_id = {{ ref('observation') }}.observation_id
group by 
    {{ ref('observation') }}.behavior
)
select 
    behavior
from behaviors
qualify row_number() over(order by behavior_count desc) <= 3
