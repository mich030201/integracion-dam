import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../share_preferences/preferencias.dart';
import '../widgets/widgets.dart';


class SettingsScreen extends StatefulWidget {

  static const String routeName = 'Settings';
   
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajustes'),
        backgroundColor: Colors.deepPurple,
      ),

      drawer: const SideMenu(),

      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Ajustes', style: TextStyle(fontSize: 45, fontWeight: FontWeight.w300)),
              const Divider(),

              SwitchListTile.adaptive(
                value: Preferences.isDarkMode, 
                title: const Text('Modo oscuro'),
                onChanged: (value) {
                  Preferences.isDarkMode = value;
                  final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

                  value ? themeProvider.setDarkMode() : themeProvider.setLightMode();

                  setState(() { }); //Para redibujar la pantalla
                }
              ),

              const Divider(),

            ],
          ),
        ),
      )
    );
  }
}