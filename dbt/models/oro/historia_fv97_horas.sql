-- La jornada de lecturas (7 de marzo) en FV-97, hora a hora: las que el lote LA-010 estaba fermentando IPA.
-- Cada celda de fermentación debería moverse entre 18 y 21 °C; aquí se ve cómo se comporta su sonda en un solo día.
with lecturas as (
    select
        extract(hour from ts) as hora,
        count(*) as lecturas,
        avg(temperatura) as temp_media,
        max(temperatura) as temp_max,
        min(temperatura) as temp_min
    from {{ ref('stg_eventos') }}
    where fermentador = 'FV-97'
    group by 1
)

select
    hora,
    lecturas,
    round(temp_min, 1) as temp_min,
    round(temp_media, 1) as temp_media,
    round(temp_max, 1) as temp_max
from lecturas
order by hora
