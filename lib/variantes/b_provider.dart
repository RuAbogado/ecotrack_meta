import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../datos/consumo_repository.dart';
import '../presentacion/consumos_view_model.dart';
import '../presentacion/tema.dart';
import '../presentacion/vistas.dart';

/// Variante B: provider crea, entrega y libera el mismo tipo de ViewModel.
class AppProvider extends StatelessWidget {
  const AppProvider({super.key, required this.repositorio});

  final ConsumoRepository repositorio;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ConsumosViewModel>(
      create: (_) => ConsumosViewModel(repositorio)..cargar(),
      child: MaterialApp(
        theme: temaEcoTrack(),
        home: const PantallasEcoTrack(
          titulo: 'B · provider',
          registro: RegistroProvider(),
          historial: HistorialProvider(),
          meta: MetaProvider(),
          resumen: ResumenProvider(),
        ),
      ),
    );
  }
}

class RegistroProvider extends StatelessWidget {
  const RegistroProvider({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ConsumosViewModel>();
    return FormularioRegistro(
      error: vm.error,
      guardando: vm.guardando,
      alGuardar: (laboratorio, litros) =>
          context.read<ConsumosViewModel>().guardar(laboratorio, litros),
    );
  }
}

class HistorialProvider extends StatelessWidget {
  const HistorialProvider({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ConsumosViewModel>();
    return ListaHistorial(consumos: vm.consumos, total: vm.total);
  }
}

class MetaProvider extends StatelessWidget {
  const MetaProvider({super.key});

  @override
  Widget build(BuildContext context) {
    final datos = context
        .select<
          ConsumosViewModel,
          ({double total, double meta, double avance, bool superada})
        >(
          (vm) => (
            total: vm.total,
            meta: vm.meta,
            avance: vm.avance,
            superada: vm.metaSuperada,
          ),
        );
    return PanelMeta(
      usado: datos.total,
      meta: datos.meta,
      avance: datos.avance,
      superada: datos.superada,
      alSubir: () => context.read<ConsumosViewModel>().subirMeta(),
      alBajar: () => context.read<ConsumosViewModel>().bajarMeta(),
    );
  }
}

class ResumenProvider extends StatelessWidget {
  const ResumenProvider({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ConsumosViewModel>();
    return ResumenLaboratorios(totales: vm.resumenPorLaboratorio);
  }
}
