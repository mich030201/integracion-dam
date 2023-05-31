import 'package:shared_preferences/shared_preferences.dart';

/// Esta clase se usa para administrar las preferencias compartidas de la aplicación, para que
/// estas se guarden y se mantengan aunque esta se cierre
class Preferences {
  // Atributos
  // Se iguala a las preferencias compartidas que esten
  static late SharedPreferences _prefs;
  // Establece el estado inicial del DarkMode a false
  static bool _isDarkMode = false;

  // Función para iguala el atributo _prefs a las preferencias compartidas
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }


  // Getter y setter del atributo _isDarkMode
  // Sirve para recoger el estado del DarkMode de la aplicaion.
  // Si este es nulo devuelve el establecido por defecto
  static bool get isDarkMode {
    return _prefs.getBool('isDarkMode') ?? _isDarkMode;
  }

  // Establece el estado del DarkMode de las preferencias compartidas y
  // actualiza la variable
  static set isDarkMode(bool isDarkMode) {
    _isDarkMode = isDarkMode;
    _prefs.setBool('isDarkMode', isDarkMode);
  }
}