select
    trim(fermentador) as fermentador,
    trim(lote) as lote,
    trim(estilo) as estilo,
    cast(litros as integer) as litros
from {{ source('bronce', 'fermentaciones') }}
