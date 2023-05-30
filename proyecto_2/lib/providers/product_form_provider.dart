import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';


class MarcadorFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  Marcador marcador;

  MarcadorFormProvider(this.marcador); //Cosntructor


  // updateAvailability(bool value) {
  //   product.available = value;
  //   notifyListeners();
  // }

  bool isValidForm() {

    return formKey.currentState?.validate() ?? false;
  }
}