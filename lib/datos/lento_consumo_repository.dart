import '../dominio/consumo.dart';
import 'consumo_repository.dart';

/// Simula una fuente de datos que tarda un segundo en guardar.
class LentoConsumoRepository implements ConsumoRepository {
  LentoConsumoRepository(this._origen);

  final ConsumoRepository _origen;

  @override
  Future<void> guardar(Consumo consumo) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    await _origen.guardar(consumo);
  }

  @override
  Future<List<Consumo>> todos() => _origen.todos();
}
