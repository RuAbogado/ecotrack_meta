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
  if (litros == null) return 'Escribe los litros con número';
  if (litros <= 0) return 'Los litros deben ser mayores que cero';
  if (litros > 10000) return 'Los litros superan el tope de 10000';
  return null;
}
