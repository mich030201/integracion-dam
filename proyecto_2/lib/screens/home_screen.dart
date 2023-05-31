import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:provider/provider.dart';

import 'package:productos_app/widgets/widgets.dart';
import 'package:productos_app/services/services.dart';

import '../providers/login_form_provider.dart';


class HomeScreen extends StatelessWidget {
   
  const HomeScreen({Key? key}) : super(key: key);
  static String correoActivo = '';
  
  @override
  Widget build(BuildContext context) {

    final productsService = Provider.of<MarkersService>(context);
    final loginForm = Provider.of<LoginFormProvider>(context); 

    final String emailInUsing = loginForm.email;

    final authService = Provider.of<AuthService>(context, listen: false);

    if(productsService.isLoading) return const LoadingScreen();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spots'),
        backgroundColor: Colors.deepPurple,
      ),

      drawer: const SideMenu(),

      body: ListView.builder(
        itemCount: productsService.markers.length,

        itemBuilder: (BuildContext context, int index) => GestureDetector( //Con el Gesture detector detecta que pulsa en un sitio y podemos redirigirlo a otro Screen
          
          onTap:() {
            
            productsService.selectedMarker = productsService.markers[index].copy();

            if(loginForm.email == productsService.selectedMarker.creatorId) {
              Navigator.pushNamed(context, 'product');
            } else {
              Navigator.pushNamed(context, 'visualizer');
            }
          },

          child: ProductCard(
            marcador: productsService.markers[index],
          )
        ),
      ),

      floatingActionButton: FloatingActionButton(

        child: const Icon(Icons.add),
        backgroundColor: Colors.deepPurple,

        onPressed: () {
          productsService.selectedMarker = Marcador(
            creatorId: emailInUsing,  
            name: 'Spot nuevo',
            description: 'Descripción del lugar',
            adress: 'calle Ejemplo, Tenerife',
          );
          
          print('**************QUIERES VER ESTO:');
          print(loginForm.email);

          print('**************Y ESTO:');
          print(emailInUsing);
          Navigator.pushNamed(context, 'product');
        },
      ),
    );
  }
}