select
    estilo,
    sum(importe_eur) / nullif(sum(litros), 0) as ingreso_litro
from {{ ref('fact_lotes') }}
group by estilo
order by ingreso_litro asc