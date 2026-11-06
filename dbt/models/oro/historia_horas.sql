-- Cuánto tiempo pasó cada lote de la remesa fuera del rango de su estilo, de dos maneras:
--   tal_cual: lo que habría salido con los datos tal como llegaron (la sonda FV-10 mide en Fahrenheit).
--   revisada: lo que sale tras la limpieza (Fahrenheit convertido a Celsius; el hueco de FV-23 no cuenta).
-- Es la prueba de que la conclusión de la portada no sale de un error de unidades.
with tal_cual as (
    -- los datos tal como llegaron: la sonda FV-10 mide en Fahrenheit y se compara sin convertir
    select
        trim(fermentador) as fermentador,
        cast(ts as timestamp) as ts,
        cast(temperatura as double) as temperatura,
        lead(cast(ts as timestamp)) over (partition by trim(fermentador) order by cast(ts as timestamp)) as siguiente_ts
    from {{ source('bronce', 'eventos') }}
),

revisada as (
    -- lo que queda en plata: la temperatura ya convertida a Celsius
    select
        fermentador,
        ts,
        temperatura,
        lead(ts) over (partition by fermentador order by ts) as siguiente_ts
    from {{ ref('stg_eventos') }}
),

fuera_rango as (
    select
        'tal_cual' as forma,
        b.fermentador,
        f.lote,
        f.estilo,
        f.litros,
        date_diff('minute', b.ts, b.siguiente_ts) as minutos
    from tal_cual b
    join {{ ref('stg_fermentaciones') }} f
        on b.fermentador = f.fermentador
    join {{ ref('stg_estilos') }} e
        on f.estilo = e.estilo
    where b.siguiente_ts is not null and date_diff('minute', b.ts, b.siguiente_ts) = 8
      and (b.temperatura < e.temp_min_c or b.temperatura > e.temp_max_c)

    union all

    select
        'revisada' as forma,
        p.fermentador,
        f.lote,
        f.estilo,
        f.litros,
        date_diff('minute', p.ts, p.siguiente_ts) as minutos
    from revisada p
    join {{ ref('stg_fermentaciones') }} f
        on p.fermentador = f.fermentador
    join {{ ref('stg_estilos') }} e
        on f.estilo = e.estilo
    where p.siguiente_ts is not null and date_diff('minute', p.ts, p.siguiente_ts) = 8
      and (p.temperatura < e.temp_min_c or p.temperatura > e.temp_max_c)
),

por_lote as (
    select
        lote,
        fermentador,
        estilo,
        litros,
        sum(case when forma = 'tal_cual' then minutos else 0 end) / 60.0 as h_tal_cual,
        sum(case when forma = 'revisada' then minutos else 0 end) / 60.0 as h_revisada
    from fuera_rango
    group by lote, fermentador, estilo, litros
)

select
    lote,
    fermentador,
    estilo,
    litros as litros_en_riesgo,
    round(h_tal_cual, 2) as horas_tal_cual,
    round(h_revisada, 2) as horas_revisada
from por_lote
order by horas_revisada desc
