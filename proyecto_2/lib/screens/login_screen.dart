import 'package:flutter/material.dart';
import 'package:productos_app/providers/login_form_provider.dart';
import 'package:productos_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/widgets.dart';

import '../services/services.dart';

class LoginScreen extends StatelessWidget {
   
   LoginScreen({Key? key}) : super(key: key);

  final home = HomeScreen();
  
  @override
  Widget build(BuildContext context) {

    final loginForm = Provider.of<LoginFormProvider>(context);

    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 250),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text('Login', style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 30),

                    ChangeNotifierProvider(
                      create: ( _ ) => LoginFormProvider(),
                      child: Form(

        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,

        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: 'alguien@gmail.com',
                labelText: 'Correo electrónico',
                prefixIcon: Icons.alternate_email_rounded
              ),
              onChanged: (value) => loginForm.email = value,
              validator: (value) {
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp  = new RegExp(pattern);

                return regExp.hasMatch(value ?? '') ? null : 'El valor ingresado no es un correo válido.';
              },
            ),

            const SizedBox(height: 30),

            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: '******',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_outline_rounded
              ),
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                
                if(value != null && value.length >= 6) return null;

                return 'La contraseña debe tener al menos 6 caracteres';
              },
            ),

            const SizedBox(height: 30),

            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,

              onPressed: loginForm.isLoading ? null : () async {
                FocusScope.of(context).unfocus(); //Desabilita el teclado al pulsar el botón
                final authService = Provider.of<AuthService>(context, listen: false); // Listen en false porque estoy dentro de un método, solo puedo escuchar dentro de un build

                if(!loginForm.isValidForm()) return; // Por si le damos al botón de ingresar sin tener todos los parametros

                loginForm.isLoading = true;

                print('-------> MIRA ESTE EMAIL:');
                print(loginForm.email);

                final String? errorMessage = await authService.login(loginForm.email, loginForm.password); // Uso await porque createuser devuelve un future

                if(errorMessage == null) {

                  Navigator.pushReplacementNamed(context, 'home');
                  
                } else {
                  //print(errorMessage);
                  NotificationsService.showSnackBar(errorMessage);
                  loginForm.isLoading = false;
                }
              },
              
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),

                child: Text(
                  loginForm.isLoading ? 'Espere' : 'Ingresar',
                  style: const TextStyle(color: Colors.white),
                ),
              )
            )
          ],
        )
      ),
                    ),
                    
                  ],
                ),
              ),

              const SizedBox(height: 50),

              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, 'register'), 
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(const StadiumBorder())
                ),
                child: const Text(
                  'Crear una nueva cuenta', 
                  style: TextStyle(fontSize: 18, color: Colors.black87)
                ),
              )

              //const SizedBox(height: 200),

            ],
          ),
        )
      )
    );
  }
}

// class _LoginForm extends StatelessWidget {
//   const _LoginForm({super.key});

//   @override
//   Widget build(BuildContext context) {

//     final loginForm = Provider.of<LoginFormProvider>(context);

//     return Container(
//       child: Form(

//         key: loginForm.formKey,
//         autovalidateMode: AutovalidateMode.onUserInteraction,

//         child: Column(
//           children: [
//             TextFormField(
//               autocorrect: false,
//               keyboardType: TextInputType.emailAddress,
//               decoration: InputDecorations.authInputDecoration(
//                 hintText: 'alguien@gmail.com',
//                 labelText: 'Correo electrónico',
//                 prefixIcon: Icons.alternate_email_rounded
//               ),
//               onChanged: (value) => loginForm.email = value,
//               validator: (value) {
//                 String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//                 RegExp regExp  = new RegExp(pattern);

//                 return regExp.hasMatch(value ?? '') ? null : 'El valor ingresado no es un correo válido.';
//               },
//             ),

//             const SizedBox(height: 30),

//             TextFormField(
//               autocorrect: false,
//               obscureText: true,
//               keyboardType: TextInputType.emailAddress,
//               decoration: InputDecorations.authInputDecoration(
//                 hintText: '******',
//                 labelText: 'Contraseña',
//                 prefixIcon: Icons.lock_outline_rounded
//               ),
//               onChanged: (value) => loginForm.password = value,
//               validator: (value) {
                
//                 if(value != null && value.length >= 6) return null;

//                 return 'La contraseña debe tener al menos 6 caracteres';
//               },
//             ),

//             const SizedBox(height: 30),

//             MaterialButton(
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//               disabledColor: Colors.grey,
//               elevation: 0,
//               color: Colors.deepPurple,

//               onPressed: loginForm.isLoading ? null : () async {
//                 FocusScope.of(context).unfocus(); //Desabilita el teclado al pulsar el botón
//                 final authService = Provider.of<AuthService>(context, listen: false); // Listen en false porque estoy dentro de un método, solo puedo escuchar dentro de un build

//                 if(!loginForm.isValidForm()) return; // Por si le damos al botón de ingresar sin tener todos los parametros

//                 loginForm.isLoading = true;

//                 final String? errorMessage = await authService.login(loginForm.email, loginForm.password); // Uso await porque createuser devuelve un future

//                 if(errorMessage == null) {

//                   Navigator.pushReplacementNamed(context, 'home');
                  
//                 } else {
//                   //print(errorMessage);
//                   NotificationsService.showSnackBar(errorMessage);
//                   loginForm.isLoading = false;
//                 }
//               },
              
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),

//                 child: Text(
//                   loginForm.isLoading ? 'Espere' : 'Ingresar',
//                   style: const TextStyle(color: Colors.white),
//                 ),
//               )
//             )
//           ],
//         )
//       ),
//     );
//   }
// }