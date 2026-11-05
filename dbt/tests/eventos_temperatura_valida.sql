select *
from {{ ref('stg_eventos') }}
where temperatura < 0
   or temperatura > 35
