# EcoTrack Meta

Práctica de gestión de estado con Flutter, ChangeNotifier y provider. Registro, Historial y Meta compartirán un mismo ViewModel, con dos variantes de cableado.

## Avance

Etapa 0: proyecto vacío, dependencia provider y kit original del docente. La aplicación todavía muestra la pantalla inicial de Flutter; las funciones se implementarán por etapas.

## Kit de evaluación

Origen: https://github.com/cristiancampos-docente/U1-S03-A02-KIT-ALUMNO

Versión: `817da49f59b3f18dfd9e0fc1fd0be5dc221c4121`.

Se copiaron `kit_alumno/test/` y `kit_alumno/verificar_estado.sh` sin modificar sus contenidos. El repositorio del docente se utiliza exclusivamente como fuente de lectura. Los hashes originales están en `docs/kit_integridad.json`.

## Validación por etapas

```sh
flutter pub get
flutter test test/etapa1_dominio_test.dart -r expanded
flutter test test/etapa2_datos_test.dart -r expanded
flutter test test/etapa3_viewmodel_test.dart -r expanded
flutter test test/etapa4_change_notifier_test.dart -r expanded
flutter test test/etapa5_provider_test.dart -r expanded
```

Cada etapa se valida junto con las anteriores antes de su commit. Las pruebas de etapas futuras se mantienen intactas y pendientes hasta implementar sus contratos.

Al terminar: `flutter analyze`, `bash verificar_estado.sh` y `flutter test`.

## Documentación

- [Tabla de gestión de estado](docs/estado.md)
- [Resultados por etapa](docs/validacion.md)
