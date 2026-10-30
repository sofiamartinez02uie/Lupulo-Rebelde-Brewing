select
    fermentador,
    sum(case when con_incidencia then 1 else 0 end) * 10000.0
        / nullif(sum(litros), 0) as incidencias_10000l
from {{ ref('fact_lotes') }}
group by fermentador
order by incidencias_10000l desc