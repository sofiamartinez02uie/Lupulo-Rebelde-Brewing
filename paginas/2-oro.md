# 2 · El oro

## El modelo estrella

El modelo de oro tiene como grano el lote de producción: cada fila de `fact_lotes` es un lote, con sus medidas (litros, kilogramos de malta, importe y el indicador de incidencias) y las claves que lo enlazan con tres dimensiones descriptivas: `dim_estilo`, `dim_cervecero` y `dim_fermentador`. Con la remesa nueva, la tabla de hechos contiene {{ fact_lotes.filas }} filas.

## Resultados de negocio

**Pregunta 1 · ¿Qué estilo deja menos ingreso por litro?**

Es **{{ pregunta_1.estilo[0] }}**, con {{ pregunta_1.ingreso_litro[0] }} €/l, muy lejos del siguiente (Lager, con {{ pregunta_1.ingreso_litro[1] }} €/l).

**Pregunta 2 · ¿Qué cervecero gasta más malta por litro?**

Es **{{ pregunta_2.cervecero[0] }}**, con {{ pregunta_2.kg_malta_100l[0] }} kg de malta por 100 litros, frente a {{ pregunta_2.kg_malta_100l[1] }} del segundo, Hugo Castro. Es el único que se despega del resto del equipo.

**Pregunta 3 · ¿Qué fermentador acumula más incidencias por cada 10.000 litros?**

El fermentador es **{{ pregunta_3.fermentador[0] }}**, con {{ pregunta_3.incidencias_10000l[0] }} incidencias por cada 10.000 litros; el segundo (FV-90) se queda en {{ pregunta_3.incidencias_10000l[1] }}. Es, por diferencia, el más problemático.

**¿Y con la remesa nueva, se mantienen las respuestas de la J3?**

Sí, se mantienen las tres. Para comprobarlo reconstruí el almacén solo con el parte de febrero: entonces `fact_lotes` tenía 501 lotes y las respuestas ya eran Radler (1,80 €/l), Carla Martín (24,29) y FV-97 (4,89). La remesa de marzo trae lotes de los mismos estilos, cerveceros y fermentadores de siempre, así que el ranking no cambia; lo que se mueven son las medias: el Radler sube a 1,81 €/l, la malta de Carla baja a 24,26 y las incidencias de FV-97 suben a 5,08.