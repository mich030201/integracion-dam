import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
   
  const LoadingScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Spots'),
        backgroundColor: Colors.deepPurple,
      ),

      body: const Center(
         child: CircularProgressIndicator(
          color: Colors.indigo,
         ),
      ),
    );
  }
}