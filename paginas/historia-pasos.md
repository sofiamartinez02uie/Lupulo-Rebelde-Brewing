# Cómo se construyó la historia

La portada cuenta el destino. Aquí queda el viaje: la decisión que hay detrás, lo que buscamos en los datos y lo que dejamos fuera.

## Paso 1 · De tema a decisión

| Tema | Incidencias de temperatura en fermentación: lotes que salen del rango de su estilo |
| Pregunta | ¿Sale de rango un fermentador más de lo que le corresponde? (quién: equipo de datos) |
| Decisión | Revisar la sonda de FV-97 con el depósito vacío antes del llenado del miércoles 11-mar (decide mantenimiento; si pasa la calibración, se llena igual) |

La prueba de que hay decisión detrás: después de leer la portada, un fermentador deja de llenarse el miércoles. Si solo se leyera como «curiosidad de datos», llenar FV-97 seguiría siendo lo normal.

## Paso 2 · Qué se mueve en los datos

### 2a · El terreno

```cifras
{{ historia_resumen.lotes }} | lotes del histórico (octubre 2025 – marzo 2026)
{{ historia_resumen.litros }} | litros producidos en total
{{ historia_resumen.dias }} | días entre el primer y el último lote
{{ stg_eventos.filas }} | lecturas de sondas del 7-mar, en plata
```

```grafico
tipo: linea
modelo: historia_litros_mes
x: mes
y: litros
titular: Producción mensual del histórico: crece sin sobresaltos
```

```grafico
tipo: histograma
modelo: fact_lotes
columna: litros
tramo: 100
titular: Cómo se reparten los lotes por tamaño
```

¿Destaca algo a simple vista? La producción crece de forma sostenida y el tamaño de los lotes es estable: el terreno no da ninguna señal de calidad. Si la incidencia de temperatura fuera un problema de producción, aquí se vería. No se ve.

### 2b · El disparador

Además de la tasa por fermentador que abre la portada (el hallazgo: {{ pregunta_3.fermentador[0] }} con {{ pregunta_3.incidencias_10000l[0] }} incidencias por 10.000 l, casi {{ ... }} veces el siguiente), el segundo espejo es la rejilla fermentador × estilo, cada celda con su propio denominador:

```grafico
tipo: calor
modelo: historia_calor
filas: fermentador
columnas: estilo
valor: inc_10mil
orden: desc
destacar: FV-97
titular: FV-97 sale con incidencias en 7 de los 8 estilos: el estilo no explica sus fallos
```

El hallazgo en una frase: FV-97 acumula incidencias en {{ historia_resumen.incidencias_fv97 }} de sus {{ historia_resumen.lotes_fv97 }} lotes, repartidas en los 6 meses, magnitud que ninguna mezcla de recetas explica. La hipótesis —no comprobada con estos datos— es un fallo de sonda o de control del propio depósito; la calibración del lunes la despejará.

### 2c · Qué lo puede explicar

- **Anomalía**: sí, es la explicación elegida. Un fermentador con el {{ historia_resumen.tasa_incidencias_fv97 }} % de sus lotes con incidencia frente al {{ historia_resumen.tasa_incidencias_resto }} % del resto.
- **Cambio significativo**: no. La remesa de marzo no trae estilos, cerveceros ni fermentadores nuevos, y FV-97 ya era el peor en febrero (antes y después de la remesa, el problema es crónico desde octubre).
- **Fuerzas del mercado**: no. La mezcla de estilos es la de siempre y FV-97 falla con igual cara en Lager ({{ historia?? }})…
- **Iniciativas propias**: no hay cambio de receta ni de prácticas en el histórico que coincida con octubre; los once equipos producen con los mismos estilos desde el inicio.

## Paso 3 · Qué datos entran y cuáles se quedan fuera

| Dato candidato | ¿Pasa el filtro? | Dónde se usa |
| --- | --- | --- |
| Parte diario: lotes, litros, incidencias, fermentador, estilo | Sí (cambia la decisión) | historia_horas, portada y cifras |
| Lecturas de sondas del 7-mar ({{ stg_eventos.filas }} filas) | Sí (identifica *cuándo* sale de rango) | Portada (línea horaria), historia_horas |
| Rangos de estilos (p. ej. IPA 18–21 °C) | Sí (define «fuera de rango») | historia_horas, historia_calor |
| Sonda FV-10 medida en Fahrenheit | Sí (como contraste de limpieza) | Paso 3, gráfico del contraste |
| Hueco de 368 min sin lecturas en FV-23 | No (ausencia ≠ tiempo fuera de rango) | Se excluye de las horas fuera de rango |
| Ingreso por litro, malta y cerveceros (los del memo) | No (no cambian esta decisión) | Quedan para la bitácora |

El contraste de limpieza. Tal cual llegaba, la sonda de FV-10 mide en Fahrenheit y el cálculo «sin arreglar» la comparaba contra un rango en Celsius: parecían 23,87 h fuera de rango del lote LA-001, que pasaría a ser el sospechoso. Tras corregir la conversión en plata, son 1,07 h, y el sospechoso real es FV-97:

```grafico
tipo: barras
modelo: historia_horas
barras: lote → horas_tal_cual, horas_revisada
solo: LA-001, LA-010
leyenda: Tal como llegó (Fahrenheit s/ convertir), Revisado (convertido)
titular: La limpieza saca del sospechoso al lote LA-001: el caso real sigue siendo FV-97
```

Y un aviso de honestidad: un eje truncado exagera la diferencia. Con el corte en 0,2 incidencias por 10.000 l, FV-97 parece el único que falla, cuando en verdad hay ocho fermentadores con alguna incidencia:

```grafico
tipo: eje
modelo: pregunta_3
barras: fermentador → incidencias_10000l
orden: desc
corte: 0.2
titular: ¿Eje truncado en 0,2? FV-97 parecería el único fermentador con incidencias
```

El alcance. Los datos del parte cubren 6 remesas de octubre 2025 a marzo 2026 ({{ historia_resumen.lotes }} lotes, {{ historia_resumen.litros }} l). Las lecturas de sondas cubren una única jornada, el 7-mar-2026 ({{ stg_eventos.filas }} filas en plata). De los lotes con incidencia se mide hora a hora solo lo de ese día; del resto queda la señal del parte.

## Las cinco comprobaciones

- Hay una decisión detrás: no llenar FV-97 sin calibración previa (lunes 9-mar, antes del miércoles 11).
- El titular afirma: «el lote {{ pregunta_4.lote[0] }} pasó {{ pregunta_4.horas_fuera_rango[0] }} h fuera de rango en {{ pregunta_4.fermentador[0] }}: saquemos ese fermentador y revisemos su sonda».
- Cada cifra tiene fuente: las horas, de las lecturas de sondas; las tasas, de los {{ historia_resumen.lotes }} lotes del parte; los grados, de las lecturas del 7-mar.
- La evidencia es diversa: barras, línea horaria, mapa de calor, histograma, el contraste sin limpiar frente a limpio y el ejemplo de eje truncado.
- Lo que no cuadra se dice: una sola jornada de sondas, el hueco de FV-23 sin causa y la hipótesis sonda-no-distingue-control formalmente abierta.
