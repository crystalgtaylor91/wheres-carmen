{%- set columns = model.columns %}
{%- set models = [
    'staging_carmen_sightings_africa', 
    'staging_carmen_sightings_america', 
    'staging_carmen_sightings_asia', 
    'staging_carmen_sightings_atlantic', 
    'staging_carmen_sightings_australia', 
    'staging_carmen_sightings_europe', 
    'staging_carmen_sightings_indian', 
    'staging_carmen_sightings_pacific'
    ]
-%}
{% for model in models -%}
select
{% for column in columns -%}
    {{ column }}{% if not loop.last %}, {% endif %}
{% endfor -%}
from {{ ref(model) }}
{% if not loop.last %}union{% endif %}
{% endfor %}