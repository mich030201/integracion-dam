import 'package:flutter/material.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:provider/provider.dart';

class CheckScreen extends StatelessWidget {
   
  const CheckScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readToken(),

          builder: (context, snapshot) {

            if(!snapshot.hasData) {
              return const Text('Espere un momento...');
            } 

            if(snapshot.data == '') {

              Future.microtask(() {
                Navigator.pushReplacement(context, PageRouteBuilder(
                  pageBuilder: (_, __, ___) => LoginScreen(),
                  transitionDuration: const Duration(seconds: 0)
                ));
              });

            } else {

              Future.microtask(() {
                Navigator.pushReplacement(context, PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const HomeScreen(),
                  transitionDuration: const Duration(seconds: 0)
                ));
              });

            }

            return Container();
          },

        ),
      ),
    );
  }
}