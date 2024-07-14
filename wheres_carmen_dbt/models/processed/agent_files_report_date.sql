-- depends_on: {{ ref('agent') }}
-- depends_on: {{ ref('date_agent') }}

with junction_table as (
    select distinct
        {{ dbt_utils.generate_surrogate_key(['agent']) }} as agent_id,
        {{ dbt_utils.generate_surrogate_key(['date_agent']) }} as date_agent_id
    from
        {{ ref('int_carmen_sightings') }}
)
select 
    {{ dbt_utils.generate_surrogate_key(['agent_id', 'date_agent_id']) }} as agent_date_id,
    agent_id,
    date_agent_id
from
    junction_table
    