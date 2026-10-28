import 'package:flutter/material.dart';

import 'datos/lento_consumo_repository.dart';
import 'datos/memoria_consumo_repository.dart';
import 'variantes/b_provider.dart';

void main() {
  runApp(
    AppProvider(
      repositorio: LentoConsumoRepository(MemoriaConsumoRepository()),
    ),
  );
}
