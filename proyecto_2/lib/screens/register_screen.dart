import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:productos_app/services/services.dart';
import '../providers/login_form_provider.dart';

import '../ui/input_decorations.dart';
import '../widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
   
  const RegisterScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
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
                    Text('Crear cuenta', style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 30),

                    ChangeNotifierProvider(
                      create: ( _ ) => LoginFormProvider(),
                      child: const _LoginForm(),
                    ),
                    
                  ],
                ),
              ),

              const SizedBox(height: 50),

              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, 'login'), // El pushReplacementNamed cambia de pantalla y hace que no pueda volver a la anterior porque rompe el stack de pantallas
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(const StadiumBorder())
                ),
                child: const Text(
                  '¿Ya tiene una cuenta?', 
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

class _LoginForm extends StatelessWidget {
  const _LoginForm({super.key});

  @override
  Widget build(BuildContext context) {

    final loginForm = Provider.of<LoginFormProvider>(context);

    return Container(
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

            // Botón de ingresar
            MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,

              onPressed: loginForm.isLoading ? null : () async {
                FocusScope.of(context).unfocus(); //Desabilita el teclado al pulsar el botón
                final authService = Provider.of<AuthService>(context, listen: false); // Listen en false porque estoy dentro de un método, solo puedo escuchar dentro de un build

                if(!loginForm.isValidForm()) return;

                loginForm.isLoading = true;

                final String? errorMessage = await authService.createUser(loginForm.email, loginForm.password); // Uso await porque createuser devuelve un future

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
    );
  }
}