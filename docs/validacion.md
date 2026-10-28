# Validación por etapas

## Etapa 0 — Preparación

- Proyecto creado con `flutter create --empty --project-name ecotrack_meta ecotrack_meta`.
- Entorno: Flutter 3.47.4, Dart 3.13.3.
- `flutter pub add provider`: correcto; provider 6.1.5+1 resuelto y registrado en el lockfile.
- Integridad: los ocho archivos del kit coinciden con sus hashes Git originales en `kit_integridad.json` (siete archivos Dart y el script).
- `flutter analyze lib`: sin problemas. Esta validación solo cubre la aplicación inicial.
- Pruebas de etapas 1–5: pendientes; sus clases todavía no están implementadas. No se han omitido, alterado ni declarado aprobadas.
- Verificación completa de arquitectura y suite: pendiente para el cierre de la práctica.

## Próxima etapa

Implementar dominio y ejecutar `flutter test test/etapa1_dominio_test.dart -r expanded`.
