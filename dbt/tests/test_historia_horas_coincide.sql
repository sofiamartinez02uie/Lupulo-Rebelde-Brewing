-- La columna revisada de historia_horas debe coincidir con pregunta_4: la única diferencia
-- entre ambos cálculos es que historia_horas relee bronce para tener la versión tal cual.
select h.lote, h.horas_revisada, p.horas_fuera_rango
from {{ ref('historia_horas') }} h
join {{ ref('pregunta_4') }} p
    on h.lote = p.lote and h.fermentador = p.fermentador
where abs(h.horas_revisada - p.horas_fuera_rango) > 0.01
