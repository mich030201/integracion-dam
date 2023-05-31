import 'package:flutter/material.dart';

/// Clase para crear el componente que se usa para el fondo en las pantallas de 
/// login y registro.
class AuthBackground extends StatelessWidget {

  // Propiedad
  final Widget child;

  // Constructor
  const AuthBackground({
    super.key, 
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,

      child: Stack(
        children: [
          const _PurpleBox(),

          const _HeaderIcon(),

          child,
        ],
      ),
    );
  }
}

/// Clase privada que se usa para la parte superior del fondo de los formularios de registro y login
class _PurpleBox extends StatelessWidget {

  // Constructor
  const _PurpleBox({super.key});

  @override
  Widget build(BuildContext context) {

    // Se usa para calcular el alto del cuadro en función del tamaño de la pantalla
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: _purpleBackground(), 

      child: Stack(
        children: const [
          Positioned(top: 90, right: 30, child: _Bubble()), // Instancias de objetos _Bubble que se colocan el el cuadro morado
          Positioned(top: -40, left: -30, child: _Bubble()),
          Positioned(top: -50, right: -20, child: _Bubble()),
          Positioned(bottom: -50, left: 30, child: _Bubble()),
          Positioned(bottom: 120, right: 20, child: _Bubble()),
        ],
      ),
    );
  }

  // Gradiente de colores
  BoxDecoration _purpleBackground() => const BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color.fromRGBO(63, 63, 156, 1),
        Color.fromRGBO(90, 70, 178, 1)
    ])
  );
}

/// Clase privada que define las burbujas que se usan en cuadro morado
class _Bubble extends StatelessWidget {

  // Constructor
  const _Bubble({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100), // Se le da la forma circular 
        color: const Color.fromRGBO(255, 255, 255, 0.05) // Se le asigna el color y la transparencia
      ),
    );
  }
}

/// Icono que se visualiza en la parte superior del fondo
class _HeaderIcon extends StatelessWidget {

  // Constructor
  const _HeaderIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30),
        child: const Icon(Icons.person_pin, color: Colors.white, size: 100),
      ),
    );
  }
}