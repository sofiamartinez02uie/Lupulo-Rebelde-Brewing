with lecturas_con_siguiente as (
    select
        fermentador,
        ts,
        temperatura,
        lead(ts) over (
            partition by fermentador
            order by ts
        ) as siguiente_ts
    from {{ ref('stg_eventos') }}
),

intervalos as (
    select
        e.fermentador,
        f.lote,
        f.estilo,
        f.litros,
        e.ts,
        e.temperatura,
        s.temp_min_c,
        s.temp_max_c,
        date_diff('minute', e.ts, e.siguiente_ts) as minutos
    from lecturas_con_siguiente e
    join {{ ref('stg_fermentaciones') }} f
        on e.fermentador = f.fermentador
    join {{ ref('stg_estilos') }} s
        on f.estilo = s.estilo
    where e.siguiente_ts is not null
      and date_diff('minute', e.ts, e.siguiente_ts) = 8
),

tiempo_fuera as (
    select
        lote,
        fermentador,
        estilo,
        litros,
        sum(
            case
                when temperatura < temp_min_c
                  or temperatura > temp_max_c
                then minutos
                else 0
            end
        ) as minutos_fuera_rango
    from intervalos
    group by lote, fermentador, estilo, litros
)

select
    lote,
    fermentador,
    estilo,
    litros as litros_en_riesgo,
    minutos_fuera_rango,
    round(minutos_fuera_rango / 60.0, 2) as horas_fuera_rango
from tiempo_fuera
order by minutos_fuera_rango desc, lote
