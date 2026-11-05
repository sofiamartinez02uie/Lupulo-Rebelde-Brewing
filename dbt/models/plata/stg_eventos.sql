select
    lectura_id,
    trim(fermentador) as fermentador,
    cast(ts as timestamp) as ts,
    case
        when fermentador = 'FV-10' then
            (cast(temperatura as double) - 32) * 5 / 9
        else cast(temperatura as double)
    end as temperatura
from {{ source('bronce', 'eventos') }}
