select distinct
    fermentador
from {{ ref('stg_parte') }}
where fermentador is not null