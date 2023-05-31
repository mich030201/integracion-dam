import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';

/// Esta clase se usa para administrar el estado de un marcador
class MarcadorFormProvider extends ChangeNotifier {

  // Es la clave global asociada al marcador para manipular y validar el estado del objeto
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  // Atributos
  Marcador marcador;

  // Constructor
  MarcadorFormProvider(this.marcador); 

  // Función para validar el marcador con la clave global.
  // Devuelve true si este es válido y false si no lo es
  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}