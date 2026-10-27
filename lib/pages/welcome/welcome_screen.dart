import 'package:flutter/material.dart';
import '../../shared/widgets/app_drawer.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inicio')),
      drawer: const AppDrawer(),
      body: const Center(child: Text('Pantalla de Bienvenida (En construcción)')),
    );
  }
}