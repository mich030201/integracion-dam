import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import '../screens/screens.dart';
import '../services/services.dart';

/// Clase que sirve para definir el componente del menú lateral.
class SideMenu extends StatelessWidget {

  // Constructor
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {

    // Variable para poder cerrar la sesión
    final authService = Provider.of<AuthService>(context, listen: false);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [

          const _DrawerHeader(), // Instancia de la cabecera

          // Opción 1: Te lleva a la pantalla donde se muestran los marcadores
          ListTile(
            leading: const Icon(Icons.home_rounded),
            title: const Text('Mapa'),

            onTap: () {
              Navigator.pushReplacementNamed(context, 'home');
            },
          ),

          // Opción 2: Te lleva a la pantalla de los ajustes
          ListTile(
            leading: const Icon(Icons.settings_rounded),
            title: const Text('Ajustes'),

            onTap: () {
              Navigator.pushReplacementNamed(context, 'settings');
            },
          ),

          const Divider(), // Divisor para aumentar el espacio entre dos componentes

          // Opción 3: Cierra la sesión y sale de la apliación
          ListTile(
            leading: const Icon(Icons.logout_rounded),
            title: const Text('Cerrar sesión'),

            onTap: () {
              authService.logout();
              SystemNavigator.pop();
            },
          ),
        ],
      ),
    );
  }
}

// Clase privada que sirve para crear la imagen de cabecera del SideMenu
class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/menu-img.jpg'),
          fit: BoxFit.cover
        )
      ),

      child: Container(),
    );
  }
}