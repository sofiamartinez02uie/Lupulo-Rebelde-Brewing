select
    lote,
    fecha,
    cervecero,
    fermentador,
    estilo,
    litros,
    kg_malta,
    importe_eur,
    case
        when incidencia is not null and trim(incidencia) <> '' then true
        else false
    end as con_incidencia
from {{ ref('stg_parte') }}