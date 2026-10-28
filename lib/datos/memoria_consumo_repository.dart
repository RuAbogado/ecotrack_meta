import '../dominio/consumo.dart';
import 'consumo_repository.dart';

/// Guarda consumos durante la ejecución de la aplicación.
class MemoriaConsumoRepository implements ConsumoRepository {
  final List<Consumo> _consumos = [];

  @override
  Future<void> guardar(Consumo consumo) async {
    _consumos.add(consumo);
  }

  @override
  Future<List<Consumo>> todos() async => List<Consumo>.unmodifiable(_consumos);
}
