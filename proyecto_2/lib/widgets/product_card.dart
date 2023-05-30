import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';


class ProductCard extends StatelessWidget {

  final Marcador marcador;

  const ProductCard({
    super.key, 
    required this.marcador
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,

        decoration: _cardBorders(),

        child: Stack(
          alignment: Alignment.bottomLeft,

          children: [
            _BackgroundImage(marcador.picture),

            _ProductDetails(title: marcador.name, subTitle: marcador.adress),
          ],
        ),
      ),
    );
  }

  // Método privado con el estilo de la tarjeta general del producto
  BoxDecoration _cardBorders() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(0, 5),
        blurRadius: 10
      )
    ]
  );
}

class _BackgroundImage extends StatelessWidget {

  final String? url;

  const _BackgroundImage( 
    this.url
  );

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),

      child: Container(
        width: double.infinity,
        height: 400,
        color: Colors.red,

        child: url == null // Comprueba si recibe imagen o no
          ? const Image(image: AssetImage('assets/no-image.png'), fit: BoxFit.cover,) 
          : FadeInImage(
              placeholder: const AssetImage('assets/jar-loading.gif'), 
              image: NetworkImage(url!),
              fit: BoxFit.cover,
          ),

      ),
    );
  }
}


class _ProductDetails extends StatelessWidget {

  final String title;
  final String subTitle;

  //Constructor
  const _ProductDetails({
    super.key, 
    required this.title, 
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 70,

        decoration: _buildBoxDecoration(),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title, 
              style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            Text(
              subTitle, 
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 15, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  // Método con el color y el radio
  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
    color: Colors.indigo,
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), topRight: Radius.circular(25))
  );
}

