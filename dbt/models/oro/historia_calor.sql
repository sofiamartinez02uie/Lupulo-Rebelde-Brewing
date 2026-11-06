-- Incidencias por fermentador y estilo: la rejilla de la portada. Cada celda con su propio denominador:
-- lotes con incidencia por cada 10.000 litros fermentados por esa combinación. Si un fermentador sale mal
-- con todos los estilos, el problema no está en la receta: está en el depósito.
with lotes as (
    select * from {{ ref('fact_lotes') }}
),

por_comparado as (
    select
        fermentador,
        estilo,
        count(*) as lotes,
        count(*) filter (where con_incidencia) as incidencias,
        sum(litros) as litros
    from lotes
    group by fermentador, estilo
)

select
    fermentador,
    estilo,
    lotes,
    incidencias,
    litros,
    round(incidencias * 10000.0 / nullif(litros, 0), 2) as inc_10mil,
    fermentador || ' · ' || estilo as par
from por_comparado
order by fermentador, estilo
