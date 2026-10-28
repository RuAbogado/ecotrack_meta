# Retos extra

## 1. Reconstrucción selectiva en Meta

`MetaProvider` usa `context.select` para observar un registro inmutable con `total`, `meta`, `avance` y `superada`. Los últimos dos valores derivan de los primeros; por eso un aviso de `guardando` no reconstruye esa pestaña. Un test temporal de widgets contó una construcción inicial, ninguna adicional al activar `guardando`, una al guardar un consumo y otra al subir la meta. La prueba original de etapa 5 también pasa.

## 2. Guardado lento

`LentoConsumoRepository` implementa `ConsumoRepository`, espera un segundo al guardar y delega a `MemoriaConsumoRepository`. Solo [main.dart](../lib/main.dart) elige ese decorador; `main_change_notifier.dart` conserva el repositorio inmediato. **No fue necesario cambiar ninguna pantalla:** `Registro` ya desactiva Guardar mientras `guardando` es verdadero. Un test temporal de widgets comprobó que el botón queda desactivado durante la espera y vuelve a activarse después, con el mensaje de éxito.

## 3. Resumen por laboratorio

[consumo.dart](../lib/dominio/consumo.dart) suma los litros de cada laboratorio y mantiene visibles los que están en cero. `resumenPorLaboratorio` es un getter derivado en el [ViewModel](../lib/presentacion/consumos_view_model.dart). La vista [ResumenLaboratorios](../lib/presentacion/vistas.dart) recibe solo un mapa de totales; `ResumenCN` y `ResumenProvider` adaptan el mismo ViewModel en cada variante. Dos pruebas temporales de widgets comprobaron que un guardado aparece en la nueva pestaña, tanto en A como en B.

Comparados con el commit de la etapa 6, los tres retos juntos añaden **16 líneas** a `a_change_notifier.dart` y **27 líneas** a `b_provider.dart`, donde también se sustituyeron 5 líneas. El reto 3 por sí solo añadió 16 y 11 líneas, respectivamente; no eliminó líneas de esos adaptadores. Esta diferencia muestra el costo de cableado: A necesita recibir el ViewModel por constructor y escuchar con `ListenableBuilder`; B obtiene la misma instancia del árbol con `context.watch`.

Los tests temporales se ejecutaron fuera del proyecto, en `/private/tmp`, para mantener intacto el kit. Las pruebas originales, el analizador y `verificar_estado.sh` siguen siendo las comprobaciones finales.
