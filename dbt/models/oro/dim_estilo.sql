select distinct
    estilo
from {{ ref('stg_parte') }}
where estilo is not null