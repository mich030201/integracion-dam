import 'package:flutter/material.dart';

/// Clase para establecer un componente de tipo InputDecoration.
/// Se usa en los formularios de registro y de inicio de seión.
class InputDecorations {

  // Constructor
  // Tiene dos atributos requeridos y uno que no es necesario.
  // Devuelve un componente InputDecoration ya configurado con los datos que se le han
  // pasado por el constructor y los que contiene ya la propia clase.
  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
    IconData? prefixIcon
  }) {
    
    return InputDecoration(
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.deepPurple
        )
      ),

      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.deepPurple,
          width: 2
        )
      ),

      hintText: hintText,
      labelText: labelText,
      labelStyle: const TextStyle(
        color: Colors.grey
      ),

      prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: Colors.deepPurple) : null
    );
  }

}