# 3 · Fuentes nuevas

## Nuevas fuentes de información

Se han incorporado tres nuevas fuentes al almacén de datos: los rangos de temperatura de cada estilo, las fermentaciones activas y las lecturas de las sondas de los fermentadores.

Se han preparado tres modelos de plata para limpiar y normalizar estos datos antes de utilizarlos en el análisis.

## Calidad de los datos

Durante la exploración se detectaron dos situaciones relevantes:

- La sonda del fermentador FV-10 registraba temperaturas en Fahrenheit. Se han convertido a Celsius en el modelo de plata.
- El fermentador FV-23 dejó de emitir lecturas durante 368 minutos, entre las 07:04 y las 13:12. Ese intervalo se ha tratado como ausencia de información y no como tiempo fuera de rango.

Se ha añadido un test singular que comprueba que las temperaturas corregidas estén entre 0 y 35 °C.

## Pregunta 4 · ¿Qué lote ha pasado más tiempo fuera del rango de temperatura de su estilo y cuántos litros arriesga?

El lote con mayor tiempo acumulado fuera del rango es **{{ pregunta_4.lote[0] }}**, del fermentador **{{ pregunta_4.fermentador[0] }}**, correspondiente al estilo **{{ pregunta_4.estilo[0] }}**.

Ha acumulado **{{ pregunta_4.horas_fuera_rango[0] }} horas** fuera del rango de temperatura adecuado, poniendo en riesgo **{{ pregunta_4.litros_en_riesgo[0] }} litros**.

Para realizar el cálculo solo se han considerado intervalos consecutivos de lecturas separados por ocho minutos, evitando atribuir temperaturas a periodos sin datos.
