with events as (
  select * from {{ ref('stg_events') }}
)

{% set event_types = dbt_utils.get_column_values(
  table=ref('stg_events'),
  column='event_type'
)  %}

, final as (
select
user_id,
session_id,
product_id, 
order_id,
{% for event_type in event_types %}
{{ sum_of ('e.event_type',event_type)}} as {{ event_type }}s,
{% endfor %}
min(created_at) as first_session_event_at_utc,
max(created_at) as last_session_event_at_utc
from events e
group by 1,2,3,4
)

select * from final 