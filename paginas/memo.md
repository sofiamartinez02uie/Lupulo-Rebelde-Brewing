# Memo para la dirección de Lúpulo Rebelde Brewing

## Qué hemos visto

- El estilo que menos ingreso deja por litro es {{ pregunta_1.estilo[0] }}, con {{ pregunta_1.ingreso_litro[0] }} €/l; el siguiente (Lager) está en {{ pregunta_1.ingreso_litro[1] }} €/l.
- El cervecero que más malta gasta por litro es {{ pregunta_2.cervecero[0] }}, con {{ pregunta_2.kg_malta_100l[0] }} kg/100 l, mientras que el resto del equipo no pasa de {{ pregunta_2.kg_malta_100l[1] }}.
- El fermentador con más incidencias es {{ pregunta_3.fermentador[0] }}, con {{ pregunta_3.incidencias_10000l[0] }} por cada 10.000 litros (el segundo acumula {{ pregunta_3.incidencias_10000l[1] }}).
- El lote más fuera de rango es {{ pregunta_4.lote[0] }}, en el fermentador {{ pregunta_4.fermentador[0] }} con el estilo {{ pregunta_4.estilo[0] }}: {{ pregunta_4.horas_fuera_rango[0] }} horas fuera del rango de su estilo y {{ pregunta_4.litros_en_riesgo[0] }} litros en riesgo.

## Qué recomendamos

- Revisar el Radler antes de la próxima campaña: coste y precio de venta, porque es el estilo que menos deja por litro.
- Formar a Carla Martín (o revisar sus recetas): dosifica bastantes más malta que sus compañeros y casi seguro es un problema de dosificación, no de receta.
- Programar intervención en FV-97: es el fermentador con más incidencias y también el que acumula el lote con más horas fuera de rango; revisar la sonda y el propio depósito.
- Revisar el lote {{ pregunta_4.lote[0] }} lo antes posible: {{ pregunta_4.litros_en_riesgo[0] }} litros están en riesgo de estropearse por temperatura.

## Qué no sabemos todavía

- Solo sabemos CUÁNDO se registra una incidencia, no por qué: necesitaríamos el motivo de cada incidencia (mantenimiento, errores...) para saber si el problema de FV-97 es el equipo, el proceso o la receta.
- Hemos asumido que el rango válido de fermentación es el que declara `estilos.csv`, que las lecturas de la sonda FV-10 venían en Fahrenheit (las convertimos a Celsius en plata) y que el hueco de 368 minutos de la sonda FV-23 es un fallo de registro, no tiempo fuera de rango.
- Hemos corregido además la remesa de marzo, que llegaba con los nombres de los cerveceros en otro formato y agrupaba a una misma persona como dos (ver página «1 · La remesa»).

## Cómo se ha hecho

El problema de calidad principal estaba en las lecturas de las sondas: fermentador FV-10 las registraba en Fahrenheit en lugar de Celsius y el FV-23 dejó de emitir datos durante 368 minutos. En plata, las temperaturas se convierten a Celsius y el hueco no se cuenta como tiempo fuera de rango sino como ausencia de datos. Desde ahora lo vigila un test singular que comprueba que todas las temperaturas corregidas están entre 0 y 35 °C: si un dato vuelve a romperlo fallaría dbt build.