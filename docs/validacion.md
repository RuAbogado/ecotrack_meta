# Validación por etapas

Proyecto: `ecotrack_meta`. Entorno usado: Flutter 3.47.4 y Dart 3.13.3.

| Etapa | Prueba original | Resultado | Commit |
|---|---|---|---|
| 0 — Arranque | `flutter analyze lib` | Sin problemas; provider 6.1.5+1 resuelto. | `9d9fe8c` |
| 1 — Dominio | `flutter test test/etapa1_dominio_test.dart -r expanded` | 10 de 10 aprobadas. | `7e88ffd` |
| 2 — Datos | `flutter test test/etapa2_datos_test.dart -r expanded` | 4 de 4 aprobadas; 14 acumuladas. | `01f79a8` |
| 3 — ViewModel | `flutter test test/etapa3_viewmodel_test.dart -r expanded` | 11 de 11 aprobadas; 25 acumuladas. | `292aa8a` |
| 4 — ChangeNotifier puro | `flutter test test/etapa4_change_notifier_test.dart -r expanded` | 5 de 5 aprobadas; 30 acumuladas. | `7f226af` |
| 5 — provider | `flutter test test/etapa5_provider_test.dart -r expanded` | 5 de 5 aprobadas; 35 acumuladas. | `831ce92` |
| 6 — Documentación | `flutter test`, `flutter analyze`, `bash verificar_estado.sh` | 35 pruebas, análisis sin problemas y verificador todo OK. | `docs: comparación de gestores con evidencia` |

## Flujo comprobado en macOS

En la variante A se guardaron 12.5 L y el mismo consumo apareció en Historial y Meta. En la variante B se guardaron 120 L, Meta avisó el rebase y al subirla a 120 L cambió a «Dentro de la meta». Las pruebas originales cubren además la carga inicial desde otra fuente, errores de validación y actualización de ambas variantes.

## Integridad del kit

Los cinco archivos `test/etapa*.dart`, los dos de `test/soporte/` y `verificar_estado.sh` coinciden byte por byte con los hashes Git originales de [kit_integridad.json](kit_integridad.json), tomados del commit `817da49f59b3f18dfd9e0fc1fd0be5dc221c4121` del kit del docente. El repositorio del profesor se usó solo como fuente de lectura.
