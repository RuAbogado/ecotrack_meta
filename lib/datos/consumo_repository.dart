import '../dominio/consumo.dart';

/// Contrato de la fuente de consumos. No depende de cómo se almacenan.
abstract class ConsumoRepository {
  Future<void> guardar(Consumo consumo);

  Future<List<Consumo>> todos();
}
