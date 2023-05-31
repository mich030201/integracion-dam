import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:productos_app/providers/login_form_provider.dart';
import 'package:productos_app/providers/theme_provider.dart';

import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';

import 'package:productos_app/share_preferences/preferencias.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized(); // Se asegura que de Flutter esté inicializado

  await Preferences.init(); // Inicializa las preferencias del usuario

  runApp(const AppState()); // Ejecuta la aplicación

} 

class AppState extends StatelessWidget {
  const AppState({super.key});

  // Proveedores
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => ThemeProvider(isDarkMode: Preferences.isDarkMode)), // Maneja el tema de la aplicación
        ChangeNotifierProvider(create: ( _ ) => MarkersService()), // Maneja la lógica de los marcadores
        ChangeNotifierProvider(create: ( _ ) => AuthService()), // Maneja la lógica y estado de autentificación
        ChangeNotifierProvider(create: ( _ ) => LoginFormProvider()), // Maneja el estado de los formularios de inicio de sesión
      ],

      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos App',

      initialRoute: 'login', // Ruta en la que inicia la aplicación
      routes:  { // Rutas de las diferentes pantallas
        'checking': ( _ ) => const CheckScreen(),

        'login': ( _ ) => LoginScreen(),
        'register': ( _ ) => const RegisterScreen(),

        'home': ( _ ) => const HomeScreen(),

        'product': ( _ ) => const ProductScreen(),
        'visualizer': ( _ ) => const ProductScreenVisualizer(),

        'settings': ( _ ) => const SettingsScreen(),
      },

      scaffoldMessengerKey: NotificationsService.messengerKey, // Establece la clave global para el servicio de mensajes rápidos

      theme: Provider.of<ThemeProvider>(context).currentTheme, // Utiliza el tema proporcionado por ThemeProvider
      
    );
  }
}