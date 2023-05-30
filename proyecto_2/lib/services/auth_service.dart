import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {

  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyCbAMTzbtdE2gUGq08SPKJyixlMGekMtC0';

  final storage = const FlutterSecureStorage();


  Future<String?> createUser(String email, String password) async {

    // Creamos la informacion del post
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

    print(decodedResp);

    if(decodedResp.containsKey('idToken')) {

      await storage.write(key: 'token', value: decodedResp['idToken']);
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

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

    print(decodedResp);

    if(decodedResp.containsKey('idToken')) {
      await storage.write(key: 'token', value: decodedResp['idToken']);
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  } 


  Future logout() async {
    await storage.delete(key: 'token');

    return;
  }


  Future<String> readToken() async {

    return await storage.read(key: 'token') ?? ''; // Como read puede devolver null compruebo si lo es y si es asi devulevo un string vacio
  }
}