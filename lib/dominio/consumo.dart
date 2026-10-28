/// Laboratorios disponibles para registrar el consumo de agua.
const laboratoriosUtez = ['Lab Química', 'Lab Redes', 'Lab Física'];

/// Un consumo de agua registrado en un laboratorio.
class Consumo {
  const Consumo({required this.laboratorio, required this.litros});

  final String laboratorio;
  final double litros;
}

/// Regresa el motivo de rechazo, o null si los litros son válidos.
String? validarLitros(double? litros) {
  if (litros == null || litros.isNaN) return 'Escribe los litros con número';
  if (litros <= 0) return 'Los litros deben ser mayores que cero';
  if (litros > 10000) return 'Los litros superan el tope de 10000';
  return null;
}

/// Agrupa los litros por laboratorio, incluyendo los que todavía están en cero.
Map<String, double> calcularTotalesPorLaboratorio(Iterable<Consumo> consumos) {
  final totales = {
    for (final laboratorio in laboratoriosUtez) laboratorio: 0.0,
  };
  for (final consumo in consumos) {
    totales.update(
      consumo.laboratorio,
      (litros) => litros + consumo.litros,
      ifAbsent: () => consumo.litros,
    );
  }
  return Map.unmodifiable(totales);
}
