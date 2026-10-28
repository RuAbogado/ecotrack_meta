# Gestión de estado — EcoTrack Meta

**Equipo:** Ruben Gomez Hernandez, Luis Ricardo Medina Villagomez

**Fecha:** 27/10/2026

## Tipos de estado en nuestro código

| Dato | Tipo (efímero, compartido, derivado, persistido) | Dónde vive |
|---|---|---|
| Pestaña activa | Efímero | `_indice` en `_PantallasEcoTrackState`, que lo cambia con `setState` en [vistas.dart](../lib/presentacion/vistas.dart). |
| Texto del campo de litros | Efímero | `_litros`, el `TextEditingController` de `_FormularioRegistroState`, liberado en su `dispose()` en [vistas.dart](../lib/presentacion/vistas.dart). |
| consumos y meta | Compartido | Campos de `ConsumosViewModel`; `cargar`, `guardar`, `subirMeta` y `bajarMeta` los cambian y llaman a `notifyListeners()` en [consumos_view_model.dart](../lib/presentacion/consumos_view_model.dart). |
| total y metaSuperada | Derivado | Getters de `ConsumosViewModel` calculados desde `consumos` y `meta` en [consumos_view_model.dart](../lib/presentacion/consumos_view_model.dart); la prueba «total, avance y metaSuperada se derivan» de [etapa 3](../test/etapa3_viewmodel_test.dart) lo comprueba. |
| Lo que regresa todos() | Persistido | La lista privada `_consumos` de `MemoriaConsumoRepository`, entregada como copia no modificable en [memoria_consumo_repository.dart](../lib/datos/memoria_consumo_repository.dart); dura mientras la app está abierta. |

## Criterios

| Criterio | A · ChangeNotifier puro | B · provider |
|---|---|---|
| Dato compartido | `AppChangeNotifier` crea un solo `_vm` y lo entrega a todas las pestañas en [a_change_notifier.dart](../lib/variantes/a_change_notifier.dart); la [prueba de etapa 4](../test/etapa4_change_notifier_test.dart) ve los mismos 12.5 L en Historial y Meta. | Un solo `ChangeNotifierProvider` arriba de `MaterialApp` comparte la instancia en [b_provider.dart](../lib/variantes/b_provider.dart); la [prueba de etapa 5](../test/etapa5_provider_test.dart) comprueba el mismo dato en las pestañas. |
| Capas | Los adaptadores pasan datos y callbacks a las vistas tontas de [vistas.dart](../lib/presentacion/vistas.dart), que solo importan `material.dart` y `dominio/consumo.dart`; lo comprueba la prueba «Capas» de [etapa 4](../test/etapa4_change_notifier_test.dart). | Las mismas vistas sin cambios; `ConsumosViewModel` conoce el contrato `ConsumoRepository` y no provider, como comprueba la prueba «Capas» de [etapa 5](../test/etapa5_provider_test.dart). |
| Encaje con el diagrama | Vista tonta → `ListenableBuilder` → `ConsumosViewModel` → dominio y repositorio, armado en [a_change_notifier.dart](../lib/variantes/a_change_notifier.dart). | Mismo diagrama; solo cambia el cableado a `ChangeNotifierProvider`, `watch` y `read` en [b_provider.dart](../lib/variantes/b_provider.dart), y [consumos_view_model.dart](../lib/presentacion/consumos_view_model.dart) no cambió entre etapas 4 y 5. |
| Constructores que reciben vm | Cuatro: `RegistroCN`, `HistorialCN`, `MetaCN` y `ResumenCN` en [a_change_notifier.dart](../lib/variantes/a_change_notifier.dart); una subpantalla de detalle sumaría otro. | Ninguno: los adaptadores son `const` y piden el ViewModel al árbol en [b_provider.dart](../lib/variantes/b_provider.dart). |
| Quién libera el ViewModel | El dueño: `_AppChangeNotifierState.dispose()` llama a `_vm.dispose()` en [a_change_notifier.dart](../lib/variantes/a_change_notifier.dart). | `ChangeNotifierProvider` libera la instancia que construyó en `create` ([b_provider.dart](../lib/variantes/b_provider.dart)); no escribimos `dispose()`. |
| Costo de adoptarla ahora | Ninguna dependencia nueva, pero cada pantalla nueva obliga a pasar `vm` por constructor; el reto 3 añadió 16 líneas a [a_change_notifier.dart](../lib/variantes/a_change_notifier.dart). | Una dependencia en [pubspec.yaml](../pubspec.yaml) y aprender `watch`/`read`/`select`; las pantallas nuevas no reciben parámetros, como `ResumenProvider` en [b_provider.dart](../lib/variantes/b_provider.dart). |
| Sustitución de la fuente de datos | `AppChangeNotifier` recibe el contrato y [main_change_notifier.dart](../lib/main_change_notifier.dart) elige la memoria; la prueba «Sustitución» de [etapa 4](../test/etapa4_change_notifier_test.dart) funciona con `RepositorioEspia`. | `AppProvider` recibe el mismo contrato; [main.dart](../lib/main.dart) usa `LentoConsumoRepository` sin tocar pantallas y la prueba «Sustitución» de [etapa 5](../test/etapa5_provider_test.dart) pasa con `RepositorioEspia`. |

## Elección

Elegimos: provider, porque los adaptadores toman la misma instancia del árbol sin recibir `vm` por constructor ([b_provider.dart](../lib/variantes/b_provider.dart)).

Se mantiene esta pieza del diagrama: `ConsumosViewModel` y las vistas tontas, idénticos en las dos variantes ([consumos_view_model.dart](../lib/presentacion/consumos_view_model.dart), [vistas.dart](../lib/presentacion/vistas.dart)).

Esta pieza es la que podría sustituirse después: la implementación de `ConsumoRepository`, que hoy es memoria y se elige solo en [main.dart](../lib/main.dart) y [main_change_notifier.dart](../lib/main_change_notifier.dart).

Resultados por etapa: [validacion.md](validacion.md). Retos extra: [extras.md](extras.md).
