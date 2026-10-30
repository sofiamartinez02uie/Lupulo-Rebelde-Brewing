<!-- pendiente: borra esta línea cuando empieces a escribir la página -->
# 2 · El oro

## El modelo estrella

Se ha construido un modelo dimensional en estrella cuyo grano es el lote de producción: cada fila de `fact_lotes` representa un lote.

La tabla de hechos contiene las medidas necesarias para el análisis: litros producidos, kilogramos de malta, importe y un indicador de incidencia. Se relaciona con tres dimensiones descriptivas: cervecero, fermentador y estilo.

El modelo final contiene **{{ fact_lotes.filas }} lotes**.

## Resultados de negocio

**Pregunta 1 · ¿Qué estilo genera menos ingreso por litro?**

El estilo con menor ingreso por litro es **{{ pregunta_1.estilo[0] }}**, con