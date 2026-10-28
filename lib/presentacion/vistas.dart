import 'package:flutter/material.dart';

import '../dominio/consumo.dart';

/// Captura un consumo. Solo conserva el laboratorio y el texto del formulario.
class FormularioRegistro extends StatefulWidget {
  const FormularioRegistro({
    super.key,
    required this.alGuardar,
    required this.error,
    required this.guardando,
  });

  final Future<bool> Function(String laboratorio, String litros) alGuardar;
  final String? error;
  final bool guardando;

  @override
  State<FormularioRegistro> createState() => _FormularioRegistroState();
}

class _FormularioRegistroState extends State<FormularioRegistro> {
  final _litros = TextEditingController();
  String _laboratorio = laboratoriosUtez.first;

  @override
  void dispose() {
    _litros.dispose();
    super.dispose();
  }

  Future<void> _guardar() async {
    final guardado = await widget.alGuardar(_laboratorio, _litros.text);
    if (!mounted || !guardado) return;
    _litros.clear();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Consumo guardado')));
  }

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Icon(Icons.water_drop_rounded, size: 48, color: colores.primary),
        const SizedBox(height: 12),
        Text(
          'Registra el agua utilizada',
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Cada registro ayuda a cuidar nuestros laboratorios.',
          style: TextStyle(color: colores.onSurfaceVariant),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DropdownButtonFormField<String>(
                  initialValue: _laboratorio,
                  decoration: const InputDecoration(
                    labelText: 'Laboratorio',
                    prefixIcon: Icon(Icons.science_outlined),
                  ),
                  items: [
                    for (final laboratorio in laboratoriosUtez)
                      DropdownMenuItem(
                        value: laboratorio,
                        child: Text(laboratorio),
                      ),
                  ],
                  onChanged: (valor) {
                    if (valor != null) setState(() => _laboratorio = valor);
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  key: const Key('litros'),
                  controller: _litros,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Litros',
                    prefixIcon: const Icon(Icons.water_drop_outlined),
                    errorText: widget.error,
                  ),
                ),
                const SizedBox(height: 20),
                FilledButton.icon(
                  onPressed: widget.guardando ? null : _guardar,
                  icon: const Icon(Icons.add_circle_outline),
                  label: const Text('Guardar'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// Muestra una copia de los consumos que recibe y su total.
class ListaHistorial extends StatelessWidget {
  const ListaHistorial({
    super.key,
    required this.consumos,
    required this.total,
  });

  final List<Consumo> consumos;
  final double total;

  @override
  Widget build(BuildContext context) {
    if (consumos.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.water_drop_outlined,
              size: 56,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 12),
            const Text('Sin consumos'),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Agua registrada'),
                const SizedBox(height: 8),
                Text(
                  'Total: ${total.toStringAsFixed(1)} L',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        for (final consumo in consumos)
          Card(
            child: ListTile(
              leading: Icon(
                Icons.water_drop,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text('${consumo.litros.toStringAsFixed(1)} L'),
              subtitle: Text(consumo.laboratorio),
            ),
          ),
      ],
    );
  }
}

/// Presenta el avance de la meta y delega los ajustes a sus callbacks.
class PanelMeta extends StatelessWidget {
  const PanelMeta({
    super.key,
    required this.usado,
    required this.meta,
    required this.avance,
    required this.superada,
    required this.alSubir,
    required this.alBajar,
  });

  final double usado;
  final double meta;
  final double avance;
  final bool superada;
  final VoidCallback alSubir;
  final VoidCallback alBajar;

  @override
  Widget build(BuildContext context) {
    final colores = Theme.of(context).colorScheme;
    return LayoutBuilder(
      builder: (context, espacio) {
        final compacto = espacio.maxHeight < 380;
        return ListView(
          padding: EdgeInsets.all(compacto ? 8 : 20),
          children: [
            Card(
              color: const Color(0xFFDAF2EF),
              child: Padding(
                padding: EdgeInsets.all(compacto ? 12 : 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!compacto) ...[
                      Icon(
                        Icons.spa_outlined,
                        color: colores.primary,
                        size: 40,
                      ),
                      const SizedBox(height: 16),
                    ],
                    Text(
                      'Meta semanal',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: compacto ? 6 : 12),
                    Text(
                      'Usado: ${usado.toStringAsFixed(1)} de ${meta.toStringAsFixed(1)} L',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(height: compacto ? 8 : 18),
                    LinearProgressIndicator(
                      value: avance,
                      minHeight: compacto ? 8 : 12,
                      borderRadius: BorderRadius.circular(8),
                      backgroundColor: Colors.white,
                      color: superada ? colores.error : colores.primary,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: compacto ? 8 : 16),
            Card(
              child: ListTile(
                dense: compacto,
                leading: Icon(
                  superada ? Icons.warning_amber_rounded : Icons.eco_outlined,
                  color: superada ? colores.error : colores.secondary,
                ),
                title: Text(
                  superada ? 'Te pasaste de la meta' : 'Dentro de la meta',
                ),
              ),
            ),
            SizedBox(height: compacto ? 8 : 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    key: const Key('bajarMeta'),
                    onPressed: alBajar,
                    icon: const Icon(Icons.remove),
                    label: const Text('Bajar meta'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    key: const Key('subirMeta'),
                    onPressed: alSubir,
                    icon: const Icon(Icons.add),
                    label: const Text('Subir meta'),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

/// Mantiene montadas las tres pestañas mientras cambia la visible.
class PantallasEcoTrack extends StatefulWidget {
  const PantallasEcoTrack({
    super.key,
    required this.titulo,
    required this.registro,
    required this.historial,
    required this.meta,
  });

  final String titulo;
  final Widget registro;
  final Widget historial;
  final Widget meta;

  @override
  State<PantallasEcoTrack> createState() => _PantallasEcoTrackState();
}

class _PantallasEcoTrackState extends State<PantallasEcoTrack> {
  int _indice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.titulo)),
      body: IndexedStack(
        index: _indice,
        children: [widget.registro, widget.historial, widget.meta],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indice,
        onDestinationSelected: (indice) => setState(() => _indice = indice),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.add_circle_outline),
            label: 'Registro',
          ),
          NavigationDestination(icon: Icon(Icons.history), label: 'Historial'),
          NavigationDestination(icon: Icon(Icons.track_changes), label: 'Meta'),
        ],
      ),
    );
  }
}
