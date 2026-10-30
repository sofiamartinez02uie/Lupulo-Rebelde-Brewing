select
    trim(estilo) as estilo,
    cast(temp_min_c as double) as temp_min_c,
    cast(temp_max_c as double) as temp_max_c
from {{ source('bronce', 'estilos') }}
