-- Una sola fila con las cifras del histórico completo, para llevarlas con marca a los portales.
with la010 as (
    select lote from {{ ref('pregunta_4') }} order by horas_fuera_rango desc limit 1
),

horas as (
    select
        sum(horas_fuera_rango) as horas_fuera_total,
        sum(case when lote not in (select lote from la010) then horas_fuera_rango end) as horas_fuera_otros
    from {{ ref('pregunta_4') }}
),

sondas as (
    select
        max(temperatura) as temp_max_fv97,
        min(temperatura) as temp_min_fv97
    from {{ ref('stg_eventos') }}
    where fermentador = 'FV-97'
),

techo as (
    select s.temp_max_c as techo_la010
    from {{ ref('pregunta_4') }} p
    join {{ ref('stg_fermentaciones') }} f
        on f.lote = p.lote and f.fermentador = p.fermentador
    join {{ ref('stg_estilos') }} s
        on f.estilo = s.estilo
    where p.lote in (select lote from la010)
),

remesa as (
    select * from {{ ref('fact_lotes') }}
)

select
    (select count(*) from remesa) as lotes,
    (select sum(litros) from remesa) as litros,
    (select date_diff('day', min(fecha), max(fecha)) + 1 from remesa) as dias,
    (select count(distinct estilo) from remesa) as estilos,
    (select count(distinct fermentador) from remesa) as fermentadores,
    (select count(*) filter (where con_incidencia) from remesa) as incidencias,
    (select count(*) filter (where con_incidencia and fermentador = 'FV-97') from remesa) as incidencias_fv97,
    round(100.0 * (select count(*) filter (where con_incidencia) from remesa where fermentador = 'FV-97')
        / (select count(*) from remesa where fermentador = 'FV-97'), 1) as tasa_incidencias_fv97,
    round(100.0 * (select count(*) filter (where con_incidencia) from remesa where fermentador <> 'FV-97')
        / (select count(*) from remesa where fermentador <> 'FV-97'), 1) as tasa_incidencias_resto,
    (select count(*) from remesa where fermentador = 'FV-97') as lotes_fv97,
    round((select horas_fuera_total from horas), 2) as horas_fuera_total,
    round((select horas_fuera_otros from horas), 2) as horas_fuera_otros,
    round((select temp_max_fv97 from sondas), 1) as temp_max_fv97,
    round((select temp_min_fv97 from sondas), 1) as temp_min_fv97,
    round((select techo_la010 from techo), 1) as techo_la010
