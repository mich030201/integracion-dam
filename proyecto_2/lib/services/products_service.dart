import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:productos_app/providers/login_form_provider.dart';
import 'package:productos_app/screens/home_screen.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';

import 'package:http/http.dart' as http;


class ProductsService extends ChangeNotifier {

  // final String _baseUrl = 'flutter-varios-90556-default-rtdb.europe-west1.firebasedatabase.app';
  final String _baseUrl = 'photloc-32648-default-rtdb.europe-west1.firebasedatabase.app';
  final List<Marcador> products = [];
  late Marcador selectedProduct;

  final homeScreen = HomeScreen();

  final storage = const FlutterSecureStorage();

  File? newPictureFile;

  bool isLoading = true;
  bool isSaving = false;
  bool isDeleting = false;

  ProductsService() {

    loadProducts();
  }

  
  Future<List<Marcador>> loadProducts() async {

    isLoading = true;
    notifyListeners(); //Notifica a otros widgets que les pueda interesar que estoy cargando la informacion

    final url = Uri.https(_baseUrl, 'markers.json', {
      'auth': await storage.read(key: 'token') ?? ''
    }); // Se hace la peticion a ese endpoint

    final respuesta = await http.get(url); // Obtiene la respuesta

    final Map<String ,dynamic> productsMap = json.decode(respuesta.body); // Mapa con las respuestas

    productsMap.forEach((key, value) { // Recorremos el mapa de productos
      
      final tempProduct = Marcador.fromMap(value); // Creamos un producto temporal
      tempProduct.id = key;                       // Le asignamos el id de uno de los productos del mapa

      products.add(tempProduct); // Lo añadimos a la lista products
    });

    isLoading = false;
    notifyListeners();

    return products;
  }


  Future saveOrCreateProduct(Marcador marcadorAGuardar) async {

    isSaving = true;
    notifyListeners();

    if(marcadorAGuardar.id == null) {
      await createProduct(marcadorAGuardar);
    } else {
      await updateProduct(marcadorAGuardar); 
    }

    isSaving = false;
    notifyListeners();
  }


  Future<String> updateProduct(Marcador marcador) async {

    final url = Uri.https(_baseUrl, 'markers/${marcador.id}.json', {
      'auth': await storage.read(key: 'token') ?? ''
    }); // Se hace la peticion al endpoint de un producto

    final respuesta = await http.put(url, body: marcador.toJson()); // Tiene put para actualizar el registro
    final decodedData = respuesta.body;

    for (var i = 0; i < products.length; i++) {
      if(products[i].id == marcador.id) {
        products[i] = marcador;
      }
    }

    final index = products.indexWhere((element) => element.id == marcador.id); // Busca el producto en la lista con el mismo id que tiene el producto que recibe la funcion
    products[index] = marcador; // Iguala el producto de la lista al producto recibido

    return marcador.id!;
  }

  Future<String> deleteProduct(Marcador marcador) async {

    isDeleting = true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'markers/${marcador.id}.json', {
      'auth': await storage.read(key: 'token') ?? ''
    }); // Se hace la peticion al endpoint de un producto

    final respuesta = await http.delete(url, body: marcador.toJson()); // Tiene put para actualizar el registro
    final decodedData = respuesta.body;

    for (var i = 0; i < products.length; i++) {
      if(products[i].id == marcador.id) {
        products[i] = marcador;
      }
    }

    final index = products.indexWhere((element) => element.id == marcador.id); // Busca el producto en la lista con el mismo id que tiene el producto que recibe la funcion
    products.remove(marcador); // Iguala el producto de la lista al producto recibido

    isDeleting = false;
    notifyListeners();

    return marcador.id!;
  }


  Future<String> createProduct(Marcador marcador) async {

    final url = Uri.https(_baseUrl, 'markers.json', {
      'auth': await storage.read(key: 'token') ?? ''
    }); // Se hace la peticion al endpoint
    
    final respuesta = await http.post(url, body: marcador.toJson()); // Tiene post para crear el registro
    final decodedData = json.decode(respuesta.body);

    marcador.id = decodedData['name'];

    products.add(marcador);

    return marcador.id!;
  }


  void updateSelectedProductImage(String path) {

    selectedProduct.picture = path;
    newPictureFile = File.fromUri(Uri(path: path));

    notifyListeners();
  }


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