import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:productos_app/providers/product_form_provider.dart';

import 'package:productos_app/services/services.dart';

import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/widgets.dart';

class ProductScreenVisualizer extends StatelessWidget {
   
  const ProductScreenVisualizer({Key? key}) : super(key: key);
  
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
              ],
            ),
            const _MarkerInformation(), 
            
            const SizedBox(height: 100)
          ],
        ),
      ),
    );
  }
}


class _MarkerInformation extends StatelessWidget {
  const _MarkerInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final productForm = Provider.of<MarcadorFormProvider>(context);
    final product = productForm.marcador;

    if(product.position == null) {
      product.position = 'Sin coordenadas';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),

      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        
        child: Column(
            children: [
              const SizedBox(height: 10),

              Text(
                product.name,
                style: const TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 25
                ),
                maxLines: 2,
              ),

              const SizedBox(height: 30),

              Text(
                product.position.toString(),
                style: const TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 13
                ),
                maxLines: 2,
              ),

              const SizedBox(height: 30),

              Text(
                product.adress,
                style: const TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 15
                ),
                maxLines: 3,
              ),

              const SizedBox(height: 30),

              Text(
                product.description,
                style: const TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 15
                ),
                maxLines: null,
              ),

              const SizedBox(height: 30)
            ],
          )
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