import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import 'package:preferences_user/screens/screens.dart';
// import 'package:preferences_user/services/services.dart';
import 'package:provider/provider.dart';

import '../screens/screens.dart';
import '../services/services.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [

          _DrawerHeader(),

          ListTile(
            leading: const Icon(Icons.home_rounded),
            title: const Text('Mapa'),

            onTap: () {
              Navigator.pushReplacementNamed(context, 'home');
            },
          ),

          ListTile(
            leading: const Icon(Icons.settings_rounded),
            title: const Text('Ajustes'),

            onTap: () {
              Navigator.pushReplacementNamed(context, 'settings');
            },
          ),

          const Divider(),

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



class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      child: Container(),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/menu-img.jpg'),
          fit: BoxFit.cover
        )
      ),
    );
  }
}