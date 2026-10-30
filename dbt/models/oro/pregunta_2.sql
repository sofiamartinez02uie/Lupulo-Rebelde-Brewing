select
    cervecero,
    sum(kg_malta) * 100.0 / nullif(sum(litros), 0) as kg_malta_100l
from {{ ref('fact_lotes') }}
group by cervecero
order by kg_malta_100l desc