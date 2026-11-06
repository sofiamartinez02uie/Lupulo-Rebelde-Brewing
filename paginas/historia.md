# El lote {{ pregunta_4.lote[0] }} pasó {{ pregunta_4.horas_fuera_rango[0] }} h por encima de su rango de temperatura en {{ pregunta_4.fermentador[0] }}: saquemos ese fermentador de servicio y revisemos su sonda antes del llenado del miércoles

{{ pregunta_4.fermentador[0] }} no es un caso puntual. De los {{ historia_resumen.lotes }} lotes del histórico, el {{ historia_resumen.tasa_incidencias_fv97 }} % de los que ha fermentado este depósito salió con incidencia de temperatura, frente al {{ historia_resumen.tasa_incidencias_resto }} % del resto de la cámara; lleva incidencias en los seis meses desde octubre y con 7 de los 8 estilos de casa, así que la receta no lo explica: apunta al depósito o a su sonda. Con {{ historia_resumen.litros }} l producidos en {{ historia_resumen.dias }} días, los {{ pregunta_4.litros_en_riesgo[0] }} l del lote {{ pregunta_4.lote[0] }} van en riesgo (la sonda llegó a marcar {{ historia_resumen.temp_max_fv97 }} °C para un estilo cuyo techo son {{ historia_resumen.techo_la010 }} °C): proponemos sacar del circuito un único fermentador, {{ pregunta_4.fermentador[0] }}.

```grafico
tipo: barras
modelo: historia_horas
barras: lote → horas_revisada
orden: desc
destacar: LA-010
referencia: historia_resumen.horas_fuera_otros · Los otros nueve lotes de la remesa juntos
titular: El lote {{ pregunta_4.lote[0] }} estuvo fuera de rango más horas que los otros nueve lotes de la remesa sumados
```

El fermentador {{ pregunta_4.fermentador[0] }} fermentó ese sábado el lote {{ pregunta_4.lote[0] }} (IPA, {{ pregunta_4.litros_en_riesgo[0] }} l). La segunda prueba apunta en la misma dirección:

```grafico
tipo: linea
modelo: historia_fv97_horas
x: hora
y: temp_max, temp_media
leyenda: Máxima horaria, Media horaria
destacar: 10
referencia: 21 · Techo del rango del estilo de este lote (IPA 18–21 °C)
titular: En la única jornada con lecturas, la sonda de {{ pregunta_4.fermentador[0] }} dio picos de {{ historia_resumen.temp_max_fv97 }} °C con un techo de estilo de {{ historia_resumen.techo_la010 }} °C
```

Si al limpiar no convertimos la lectura de Fahrenheit a Celsius, la conclusión cambia de lote y de culpable (LA-001 parecía el peor por culpa de la sonda en Fahrenheit de FV-10); corregido, el culpable real sigue siendo {{ pregunta_4.fermentador[0] }} con {{ pregunta_4.horas_fuera_rango[0] }} h: la conclusión aguanta la limpieza.

## Qué proponemos

- **Mantenimiento** saca a {{ pregunta_4.fermentador[0] }} de servicio hoy y calibra (o sustituye) su sonda de temperatura con el depósito vacío, **antes del llenado del miércoles 11-mar**. No vuelve al circuito hasta tener la calibración firmada.
- **El equipo de datos comunica al proveedor esta semana** que la sonda de FV-10 envía Fahrenheit con la remesa, para corregirlo en origen; mientras tanto, la conversión queda documentada en `stg_eventos.sql`.

## Qué no sabemos todavía

- Las lecturas de sondas cubren **una sola jornada** (sábado 7-mar-2026, {{ stg_eventos.filas }} lecturas en plata): las {{ pregunta_4.horas_fuera_rango[0] }} h fuera de rango se miden ese día. No sabemos si la sonda se comporta igual el resto del histórico; los 59 partes con incidencia sí cubren octubre–marzo.
- Con estos datos no podemos separar si falla **la sonda** (mide mal el vaivén de 18,5 a 26,9 °C en la misma hora) o **el control de frío**. La calibración propuesta lo decide.
- Un hueco de 368 minutos sin lecturas en FV-23 (135 lecturas frente a las 180 de los demás) no tiene causa conocida; lo tratamos como ausencia de datos, no como tiempo fuera de rango.
- FV-97 solo fermentó Pale Ale en dos lotes en cinco meses: el «7 de 8 estilos» podría ser en realidad «8 de 8».

## La misma historia para cada audiencia

- **Comité de dirección (5 segundos)**: «Uno de cada diez lotes sale con incidencia; FV-97 falla en casi 4 de cada 10 de los suyos. Sale de servicio hoy.»
- **Responsable que actúa (1 minuto)**: parar FV-97 hoy y calibrar su sonda con el depósito vacío antes del llenado del miércoles 11-mar; avisar al proveedor por lo Fahrenheit de FV-10. Los {{ pregunta_4.litros_en_riesgo[0] }} l del {{ pregunta_4.lote[0] }} quedan en riesgo mientras no se calibre.
- **Equipo de datos (5 minutos)**: fuente: parte diario (octubre 2025–marzo 2026) y lecturas de sondas del 7-mar; filtro: fermentador FV-97, lote LA-010, IPA 18–21 °C; el contraste Fahrenheit–Celsius descarta el falso culpable LA-001; y ojo con un eje truncado, que convertiría al resto de la cámara en «cero».
