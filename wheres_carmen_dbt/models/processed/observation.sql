select distinct
    {{ dbt_utils.generate_surrogate_key(['has_weapon', 'has_hat', 'has_jacket', 'behavior']) }} as observation_id,
    has_weapon,
    has_hat,
    has_jacket,
    behavior
from
    {{ ref('int_carmen_sightings') }}
    