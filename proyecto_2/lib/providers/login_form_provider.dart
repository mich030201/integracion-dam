import 'package:flutter/material.dart';

/// Esta clase se usa para administrar el estado del formulario de inicio de sesión
class LoginFormProvider extends ChangeNotifier {

  // Es la clave global asociada al formulario para manipular y validar el estado del formulario
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Atributos
  String email = '';
  String password = '';
  bool _isLoading = false;

  // Getter y setter del atributo _isLoading
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners(); // Se usa parar actualizar la interfaz del usuario
  }

  // Getter y setter del atributo _email
  String get emailEnUso => email;

  set emailUsado(String value) {
    email = value;
    notifyListeners();
  }

  // Función para validar el formulario con la clave global.
  // Devuelve true si el formulario es válido y false si no lo es
  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}