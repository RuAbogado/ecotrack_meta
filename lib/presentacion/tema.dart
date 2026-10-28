import 'package:flutter/material.dart';

/// Apariencia compartida por ambas variantes de la aplicación.
ThemeData temaEcoTrack() {
  final colores = ColorScheme.fromSeed(
    seedColor: const Color(0xFF087E8B),
    secondary: const Color(0xFF4D9D75),
  );
  return ThemeData(
    useMaterial3: true,
    colorScheme: colores,
    scaffoldBackgroundColor: const Color(0xFFF3F8F7),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFF3F8F7),
      centerTitle: false,
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF3F8F7),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
