import 'dart:io';
import 'package:flutter/material.dart';

/// Clase que se usa para definir el componente donde irá la foto del marcador tanto
/// en la pantalla para visualizar sus datos como en la que se actualizan estos.
class ProductImage extends StatelessWidget {

  // Propiedad
  final String? url;

  // Constructor
  const ProductImage({
    super.key, 
    this.url
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        decoration: _buildBoxDecoration(),
        width: double.infinity,
        height: 450,

        child: Opacity(
          opacity: 0.9,

          child: ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(45), topRight: Radius.circular(45)),
        
            child: getImage(url)
        
          ),
        ),
      ),
    );
  }

  // Método privado que contiene el estilo del componente
  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
    color: Colors.black,

    borderRadius: BorderRadius.only(topLeft: Radius.circular(45), topRight: Radius.circular(45)),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 10,
        offset: Offset(0, 5)
      )
    ]
  );

  // Función para recoger la imagen guarda en Cloudinary y mostrarla.
  // Como lo imagen puede ser nula lo comprueba primero y si lo es pues pone una imagen del
  // proyecto que está por defecto.
  Widget getImage(String? picture) {

    if(picture == null) {
      return const Image(image: AssetImage('assets/no-image.png'), fit: BoxFit.cover);
    } 
    
    // Comprueba si la imagen proviene del sevicio de alamacenaje de imagenes y carga un gif en 
    // lo que se recupera la imagen.
    if(picture.startsWith('https')) {
      return FadeInImage(
        image: NetworkImage(url!),
        placeholder: const AssetImage('assets/jar-loading.gif'), 
        fit: BoxFit.cover,
      );
    }

    return Image.file(
      File(picture),
      fit: BoxFit.cover,
    );
  }
}