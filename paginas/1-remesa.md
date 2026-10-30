# 1 · La remesa nueva

La nueva entrega del parte diario, recibida el 5 de marzo de 2026, incorporó un cambio en el formato de los nombres de los cerveceros. En la columna `cervecero`, algunos registros llegaron con los apellidos delante y separados por una coma (por ejemplo, `CAMPOS, BRUNO` en lugar de `BRUNO CAMPOS`). Esto provocaba que una misma persona apareciese identificada como dos cerveceros diferentes.

Para descubrirlo, ejecuté `dbt build`, pero los siete tests existentes pasaron correctamente. La anomalía se detectó al contar los cerveceros distintos en plata: aparecían 12 cuando deberían ser 6. Después comparé los registros agrupados por fecha de carga y consulté directamente la fuente de bronce. Así comprobé que el cambio de formato ya venía en la entrega del 05/03/2026 y no lo introducía el modelo de transformación.

La solución se aplicó en `stg_parte.sql`, dentro de plata. Añadí una normalización que detecta los nombres que contienen una coma, invierte el orden de apellidos y nombre y convierte el resultado a mayúsculas. De esta forma, todas las variantes quedan identificadas con el mismo nombre. La corrección se realiza en plata porque es la capa destinada a limpiar y transformar los datos, mientras que bronce debe conservar los ficheros originales sin modificaciones.

Tras la corrección, plata contiene {{ stg_parte.filas }} lotes, sin perder ninguna fila.
