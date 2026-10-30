select distinct
    cervecero
from {{ ref('stg_parte') }}
where cervecero is not null