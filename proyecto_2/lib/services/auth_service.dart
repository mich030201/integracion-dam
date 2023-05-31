import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

/// Esta clase sirve para la gestión de autentificación del formulario de login y registro.
/// Implementa ChangeNotifier para poder avisar a los widgets en el cambio en la autenficación.
class AuthService extends ChangeNotifier {

  // Propiedades
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyCbAMTzbtdE2gUGq08SPKJyixlMGekMtC0';
  final storage = const FlutterSecureStorage();

  // Función para crear un nuevo usuario.
  Future<String?> createUser(String email, String password) async {

    // Creamos la informacion del post
    // Devuelve una cadena que indica si se realizó con éxito o si se produjo algún error
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    // Creamos el http del postman
    final url = Uri.https(_baseUrl, '/v1/accounts:signUp', {
      'key': _firebaseToken
    });

    // Disparamos la peticion http
    final resp = await http.post(url, body: json.encode(authData));
    // Decodificamos resp (String) y lo guardamos en un mapa
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    /** print(decodedResp); */

    if(decodedResp.containsKey('idToken')) {
      await storage.write(key: 'token', value: decodedResp['idToken']);
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  // Función para el inicio de sesión.
  // Devuelve una cadena que indica si se realizó con éxito o si se produjo algún error
  Future<String?> login(String email, String password) async {

    // Creamos la informacion del post
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    // Creamos el http del postman
    final url = Uri.https(_baseUrl, '/v1/accounts:signInWithPassword', {
      'key': _firebaseToken
    });

    // Disparamos la peticion http
    final resp = await http.post(url, body: json.encode(authData));
    // Decodificamos resp (String) y lo guardamos en un mapa
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    /** print(decodedResp); */

    if(decodedResp.containsKey('idToken')) {
      await storage.write(key: 'token', value: decodedResp['idToken']);
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  } 

  // Función para cerrar la sesión del usuario elimiando el token de autenficacio´n
  Future logout() async {
    await storage.delete(key: 'token');
    return;
  }

  // Lee el token almacenado en FlutterSecureStorage
  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? ''; // Como read puede devolver null compruebo si lo es y si es asi devulevo un string vacio
  }
}