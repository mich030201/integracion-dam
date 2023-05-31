import 'package:flutter/material.dart';

/// Clase para mostrar mensajes rápidos y emergentes.
/// Se utiliza para mostar los mensajes de error del AuthService
class NotificationsService {
  // Propiedad
  // Se usa para poder acceder ScaffoldMessengerState, el cual gestiona los mensajes rápidos
  // en la interfaz del usuario.
  static GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();

  // Muestra el mensaje rápido con el String que se le proporciona
  static showSnackBar(String message) {
    final snackBar = SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white, fontSize: 20))
    );

    // Función que se llama desde cualquier clase para mostrar el mensaje
    messengerKey.currentState!.showSnackBar(snackBar);
  }
}