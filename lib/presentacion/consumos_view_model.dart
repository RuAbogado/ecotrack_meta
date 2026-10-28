import 'package:flutter/foundation.dart';

import '../datos/consumo_repository.dart';
import '../dominio/consumo.dart';
import '../dominio/meta.dart';

/// Estado compartido de Registro, Historial y Meta.
class ConsumosViewModel extends ChangeNotifier {
  ConsumosViewModel(this._repositorio);

  final ConsumoRepository _repositorio;

  List<Consumo> consumos = [];
  String? error;
  bool guardando = false;
  double meta = metaInicial;

  double get total =>
      consumos.fold<double>(0, (suma, consumo) => suma + consumo.litros);
  double get avance => avanceDeMeta(total: total, meta: meta);
  bool get metaSuperada => total > meta;
  Map<String, double> get resumenPorLaboratorio =>
      calcularTotalesPorLaboratorio(consumos);

  /// Recupera lo que ya existía en la fuente de datos.
  Future<void> cargar() async {
    consumos = await _repositorio.todos();
    notifyListeners();
  }

  /// Valida y guarda un consumo; indica si la operación tuvo éxito.
  Future<bool> guardar(String laboratorio, String litrosTexto) async {
    final litros = double.tryParse(litrosTexto.trim().replaceAll(',', '.'));
    final motivo = validarLitros(litros);
    if (motivo != null) {
      error = motivo;
      notifyListeners();
      return false;
    }

    guardando = true;
    error = null;
    notifyListeners();

    try {
      await _repositorio.guardar(
        Consumo(laboratorio: laboratorio, litros: litros!),
      );
      consumos = await _repositorio.todos();
      return true;
    } finally {
      guardando = false;
      notifyListeners();
    }
  }

  void subirMeta() {
    meta = ajustarMeta(meta, pasoMeta);
    notifyListeners();
  }

  void bajarMeta() {
    meta = ajustarMeta(meta, -pasoMeta);
    notifyListeners();
  }
}
