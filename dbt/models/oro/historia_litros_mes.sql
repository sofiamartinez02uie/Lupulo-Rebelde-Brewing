-- El terreno: cuánto se produce cada mes en el histórico completo.
with lotes as (
    select * from {{ ref('fact_lotes') }}
)

select
    strftime(date_trunc('month', fecha), '%Y-%m') as mes,
    count(*) as lotes,
    sum(litros) as litros,
    count(*) filter (where con_incidencia) as incidencias
from lotes
group by 1
order by 1
