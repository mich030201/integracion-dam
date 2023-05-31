import 'dart:convert';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:productos_app/providers/login_form_provider.dart';
import 'package:productos_app/screens/home_screen.dart';
import '../models/models.dart';

/// Esta clase se encarga de manejar la carga, creación, actualiación y eliminación de
/// marcadores en la aplicación.
class MarkersService extends ChangeNotifier {

  // Propiedades
  // Almacena el URL para comunicarse con la base de datos
  final String _baseUrl = 'photloc-32648-default-rtdb.europe-west1.firebasedatabase.app';
  // Lista para almacenar los marcadores
  final List<Marcador> markers = [];
  // Almacena el marcador que se seleccione
  late Marcador selectedMarker;
  // Alamacela la instancia de la pantalla principal
  final homeScreen = const HomeScreen();
  // Almacena los tokens de autentificación
  final storage = const FlutterSecureStorage();

  File? newPictureFile;

  // Controlan los estados de carga, guardado y borrado respectivamente
  bool isLoading = true;
  bool isSaving = false;
  bool isDeleting = false;

  // Constructor
  MarkersService() {

    loadMarkers();
  }

  // Función para cargar los marcadores de la base de datos
  Future<List<Marcador>> loadMarkers() async {

    isLoading = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'markers.json', {
      'auth': await storage.read(key: 'token') ?? ''
    }); // Se hace la peticion a ese endpoint

    final respuesta = await http.get(url); // Obtiene la respuesta

    final Map<String ,dynamic> markersMap = json.decode(respuesta.body); // Mapa con las respuestas

    markersMap.forEach((key, value) { // Recorremos el mapa de marcadores
      
      final tempProduct = Marcador.fromMap(value); // Creamos un marcador temporal
      tempProduct.id = key;                       // Le asignamos el id de uno de los marcadores del mapa

      markers.add(tempProduct); // Lo añadimos a la lista markers
    });

    isLoading = false;
    notifyListeners();

    return markers;
  }

  // Función para crear o guardar un marcador.
  // Comprueba si el id del marcador es nulo, si lo es lo crea y sino lo actualiza.
  Future saveOrCreateMarker(Marcador marcadorAGuardar) async {

    isSaving = true;
    notifyListeners();

    if(marcadorAGuardar.id == null) {
      await createMarker(marcadorAGuardar);
    } else {
      await updateMarker(marcadorAGuardar); 
    }

    isSaving = false;
    notifyListeners();
  }

  // Función para actualizar la información de un marcador.
  Future<String> updateMarker(Marcador marcador) async {

    final url = Uri.https(_baseUrl, 'markers/${marcador.id}.json', {
      'auth': await storage.read(key: 'token') ?? ''
    }); // Se hace la peticion al endpoint de un marcador

    final respuesta = await http.put(url, body: marcador.toJson()); // Tiene put para actualizar el registro
    final decodedData = respuesta.body;

    for (var i = 0; i < markers.length; i++) {
      if(markers[i].id == marcador.id) {
        markers[i] = marcador;
      }
    }

    final index = markers.indexWhere((element) => element.id == marcador.id); // Busca el marcador en la lista con el mismo id que tiene el marcador que recibe la funcion
    markers[index] = marcador; // Iguala el marcador de la lista al marcador recibido

    return marcador.id!;
  }

  // Función para borra un marcador.
  Future<String> deleteMarker(Marcador marcador) async {

    isDeleting = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'markers/${marcador.id}.json', {
      'auth': await storage.read(key: 'token') ?? ''
    }); // Se hace la peticion al endpoint de un marcador

    final respuesta = await http.delete(url, body: marcador.toJson()); // Tiene delete para actualizar el registro
    final decodedData = respuesta.body;

    for (var i = 0; i < markers.length; i++) {
      if(markers[i].id == marcador.id) {
        markers[i] = marcador;
      }
    }

    final index = markers.indexWhere((element) => element.id == marcador.id); 
    markers.remove(marcador); // Elimina el marcador de la lista

    isDeleting = false;
    notifyListeners();

    return marcador.id!;
  }


  // Fución para crear un marcador
  Future<String> createMarker(Marcador marcador) async {

    final url = Uri.https(_baseUrl, 'markers.json', {
      'auth': await storage.read(key: 'token') ?? ''
    }); // Se hace la peticion al endpoint
    
    final respuesta = await http.post(url, body: marcador.toJson()); // Tiene post para crear el registro
    final decodedData = json.decode(respuesta.body);

    marcador.id = decodedData['name'];

    markers.add(marcador);

    return marcador.id!;
  }

  // Función para actualizar la imagen de un marcador seleccionado
  void updateSelectedMarkerImage(String path) {

    selectedMarker.picture = path;
    newPictureFile = File.fromUri(Uri(path: path));

    notifyListeners();
  }

  // Funcion para guardar la imagen de un marcador en Cloudinary
  Future<String?> uploadImage() async{

    if(newPictureFile == null) return null; // Si llamamos al método por error le enviamos null para que la app no pete

    isSaving = true;
    notifyListeners();

    final url = Uri.parse('https://api.cloudinary.com/v1_1/dwvoxegkp/image/upload?upload_preset=puvruwat');
    
    final imageUploadRequest = http.MultipartRequest('POST', url);

    // Ponemos la exclamación porque Flutter detecta que ese valor puede ser nulo, pero ya comprobamos que no lo fuera mas arriba
    final file = await http.MultipartFile.fromPath('file', newPictureFile!.path);   

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final reponse = await http.Response.fromStream(streamResponse);

    if(reponse.statusCode != 200 && reponse.statusCode != 201) {
      print('algo salió mal');
      print(reponse.body);
      return null;
    }

    newPictureFile = null; // Limpio esta propiedad ya que ya se subió la imagen

    final decodedData = json.decode(reponse.body);
    return decodedData['secure_url'];
  }

}