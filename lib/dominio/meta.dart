/// Valores fijos de la meta semanal, expresados en litros.
const double metaInicial = 100.0;
const double pasoMeta = 10.0;
const double metaMinima = 10.0;

/// Ajusta la meta sin permitir que baje del mínimo.
double ajustarMeta(double actual, double cambio) {
  final nuevaMeta = actual + cambio;
  return nuevaMeta < metaMinima ? metaMinima : nuevaMeta;
}

/// Fracción de la meta consumida, limitada al intervalo de 0 a 1.
double avanceDeMeta({required double total, required double meta}) {
  if (meta <= 0 || total <= 0) return 0;
  final fraccion = total / meta;
  return fraccion >= 1 ? 1 : fraccion;
}
