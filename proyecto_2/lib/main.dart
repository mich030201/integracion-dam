import 'package:flutter/material.dart';
import 'package:productos_app/providers/login_form_provider.dart';
import 'package:productos_app/providers/theme_provider.dart';

import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/share_preferences/preferencias.dart';

import 'package:provider/provider.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Preferences.init();

  runApp(const AppState());

} 

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => ThemeProvider(isDarkMode: Preferences.IsDarkMode)),
        ChangeNotifierProvider(create: ( _ ) => ProductsService()),
        ChangeNotifierProvider(create: ( _ ) => AuthService()),
        ChangeNotifierProvider(create: ( _ ) => LoginFormProvider()),
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

      initialRoute: 'login',
      routes:  {
        'checking': ( _ ) => const CheckScreen(),

        'login': ( _ ) => LoginScreen(),
        'register': ( _ ) => const RegisterScreen(),

        'home': ( _ ) => const HomeScreen(),

        'product': ( _ ) => const ProductScreen(),
        'visualizer': ( _ ) => const ProductScreenVisualizer(),

        'settings': ( _ ) => const SettingsScreen(),
      },

      scaffoldMessengerKey: NotificationsService.messengerKey,

      // theme: ThemeData.light().copyWith(
      //   scaffoldBackgroundColor: Colors.grey[300],

      //   appBarTheme: const AppBarTheme(
      //     elevation: 0,
      //     color: Colors.indigo
      //   ),

      //   floatingActionButtonTheme: const FloatingActionButtonThemeData(
      //     backgroundColor: Colors.indigo,
      //     elevation: 0
      //   )
      // ),

      theme: Provider.of<ThemeProvider>(context).currentTheme,
      
    );
  }
}