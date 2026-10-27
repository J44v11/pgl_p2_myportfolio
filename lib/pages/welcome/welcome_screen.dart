import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../shared/widgets/app_drawer.dart';
import '../shared/theme/app_colors.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Permite que el fondo ocupe toda la pantalla detrás del AppBar
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const AppDrawer(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Fondo verde bosque (Sustituir por Image.asset si configuras las imágenes locales)
          Container(
            color: const Color(0xFF1B2E1E),
          ), 
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Senderos de\nCanarias',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 38, 
                    color: Colors.white, 
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  '¡Descubre la naturaleza\nde nuestras islas!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18, 
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 50),
                // Ilustración temporal centrada
                Container(
                  padding: const EdgeInsets.all(35),
                  decoration: const BoxDecoration(
                    color: Colors.white24,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.hiking, 
                    size: 110, 
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 70),
                // Botón de navegación principal
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () => context.go('/portfolio'),
                  child: const Text(
                    'Empezar', 
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}