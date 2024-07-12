{% macro build_raw_table_from_seed(seed) %}
-- depends_on: {{ ref(seed) }}
{%- set columns = model.columns %}

select
{% for column in columns -%}
    "{{ columns[column].get('alias', column) }}"::{{columns[column].get('data_type')}} 
        as {{ column }}{% if not loop.last %}, {% endif %}
{% endfor %}
from {{ ref(seed) }}
{% endmacro %}