import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import 'package:productos_app/providers/product_form_provider.dart';

import 'package:productos_app/services/services.dart';

import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
   
  const ProductScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final productSevice = Provider.of<MarkersService>(context);

    return ChangeNotifierProvider(
      create: ( _ ) => MarcadorFormProvider(productSevice.selectedMarker),
      child: _ProductScreenBody(productSevice: productSevice),
    );

  }
}



class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    super.key,
    required this.productSevice,
  });

  final MarkersService productSevice;

  @override
  Widget build(BuildContext context) {

    final productForm = Provider.of<MarcadorFormProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(

        //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,  // Al hacer scroll se oculta el teclado

        child: Column(
          children: [

            Stack(
              children: [
                ProductImage(url: productSevice.selectedMarker.picture),

                Positioned(
                  top: 60,
                  left: 20,

                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, size: 40, color: Colors.white), 
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ),

                Positioned(
                  top: 60,
                  right: 30,

                  child: IconButton(
                    icon: const Icon(Icons.camera_alt_outlined, size: 40, color: Colors.white), 
                    onPressed: () async {

                      final picker = ImagePicker();
                      final PickedFile? pickedFile = await picker.getImage( //Imagen elegida
                        source: ImageSource.camera, // Selecciona para sacar la foto desde la camara
                        //source: ImageSource.gallery, // Selecciona las fotos de la galeria
                        imageQuality: 100
                      );

                      if(pickedFile == null) return;

                      productSevice.updateSelectedMarkerImage(pickedFile.path);
                      
                    },
                  )
                ),
              ],
            ),
            const _ProductForm(), 
            
            const SizedBox(height: 100)
          ],
        ),
      ),

      /**
       * Botón de guardar y eliminar
       */
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,

      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.deepPurple,
        overlayColor: Colors.black,
        overlayOpacity: 0.4,
        spacing: 10,

        children: [
          SpeedDialChild(
            child: productSevice.isSaving
            ? const CircularProgressIndicator(color: Colors.white)
            : const Icon(Icons.save_outlined, color: Colors.white),

            label: 'Guardar',
            backgroundColor: Colors.green,

            onTap: productSevice.isSaving
            ? null
            : () async{

              if(!productForm.isValidForm()) return;

              final String? imageUrl = await productSevice.uploadImage();

              if(imageUrl != null) {
                productForm.marcador.picture = imageUrl;
              }
          
              await productSevice.saveOrCreateMarker(productForm.marcador); //Guarda la info en la BD

              // Navigator.pushReplacementNamed(context, 'home');

              // Fluttertoast.showToast(msg: 'Se ha guardado el spot correctamente');
            },
          ),

          SpeedDialChild(
            child: productSevice.isDeleting
            ? const CircularProgressIndicator(color: Colors.white)
            : const Icon(Icons.delete_forever_outlined, color: Colors.white),

            label: 'Eliminar',
            backgroundColor: Colors.red,

            onTap: productSevice.isDeleting
            ? null
            : () async{

              if(!productForm.isValidForm()) return;

              final String? imageUrl = await productSevice.uploadImage();

              if(imageUrl != null) {
                productForm.marcador.picture = imageUrl;
              }
          
              await productSevice.deleteMarker(productForm.marcador); //Guarda la info en la BD

              // Navigator.pushReplacementNamed(context, 'home');

              // Fluttertoast.showToast(msg: 'Se ha eleminado el spot correctamente');
            },
          )
        ],
      )
    );
  }
}


class _ProductForm extends StatelessWidget {
  const _ProductForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final productForm = Provider.of<MarcadorFormProvider>(context);
    final product = productForm.marcador;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),

      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        
        child: Form(

          key: productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,

          child: Column(
            children: [
              const SizedBox(height: 10),

              TextFormField(
                initialValue: product.name, // Le asigna el nombre del marcador
                onChanged: (value) => product.name = value, // Cambia el nombre del marcador si el usuario escribe o borra
                
                validator: (value) { // Comprueba que el nombre tenga minimo 6 letras
                  if(value == null ||value.length <= 5) {
                    return 'El nombre es obligatorio';
                  }
                },

                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Nombre del producto', 
                  labelText: 'Nombre:'
                ),
              ),

              const SizedBox(height: 30),

              TextFormField(
                initialValue: product.description, // Le asigna el nombre del marcador
                onChanged: (value) => product.description = value, // Cambia el nombre del marcador si el usuario escribe o borra
                
                validator: (value) { // Comprueba que el nombre tenga minimo 10 letras
                  if(value == null ||value.length <= 9) {
                    return 'La descripción es desmasiado corta';
                  }
                },

                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Descripción', 
                  labelText: 'Descripción:'
                ),
              ),

              const SizedBox(height: 30),

              TextFormField(
                initialValue: product.adress, // Le asigna el nombre del marcador
                onChanged: (value) => product.adress = value, // Cambia el nombre del marcador si el usuario escribe o borra
                
                validator: (value) { // Comprueba que el nombre tenga minimo 10 letras
                  if(value == null || value.length <= 9) {
                    return 'La dirección no es válida';
                  }
                },

                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Dirección', 
                  labelText: 'Dirección:'
                ),
              ),

              const SizedBox(height: 30),

              TextFormField(
                initialValue: product.position, // Le asigna el precio del producto

                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^-?\d{1,2}\.\d{4},\s*-?\d{1,2}\.\d{4}$')) // Solo permite numeros y el punto
                ],

                onChanged: (value) {
                  product.position = value; // Cambia el valor de las coordenadas
                }, 

                decoration: InputDecorations.authInputDecoration(
                  hintText: '\$28.287376328637556, -16.768290996750004', 
                  labelText: 'Coordenadas:'
                ),
              ),

              const SizedBox(height: 30),

              // SwitchListTile.adaptive(
              //   value: product.available, 
              //   title: const Text('Disponible:'),
              //   activeColor: Colors.indigo,
              //   onChanged: (value) {
              //     productForm.updateAvailability(value);
              //   }
              // ),

              const SizedBox(height: 30)
            ],
          )
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(0, 5),
        blurRadius: 5
      )
    ]
  );
}