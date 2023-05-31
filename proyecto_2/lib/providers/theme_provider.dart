import 'package:flutter/material.dart';

/// Esta clase se usa para administrar el estado de un marcador
/// En la apliucación se usa para la función del modo oscuro de la pantalla de ajustes
class ThemeProvider extends ChangeNotifier {

  // Atributo que almacena el tema actual de la aplicación
  ThemeData currentTheme;

  // Constructor
  ThemeProvider({
    required bool isDarkMode
  }): currentTheme = isDarkMode ? ThemeData.dark() : ThemeData.light();

  // Función para establecer el tema claro
  // Iguala el tema actual al tema claro y usa notifyListeners() para redibujar la ibterfaz del usuario
  setLightMode() {
    currentTheme = ThemeData.light();
    notifyListeners();
  }

  // Función para establecer el tema oscuro
  // Iguala el tema actual al tema oscuro y usa notifyListeners() para redibujar la ibterfaz del usuario
  setDarkMode() {
    currentTheme = ThemeData.dark();
    notifyListeners();
  }
}