import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../shared/widgets/app_drawer.dart';
import '../../shared/theme/app_colors.dart';

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
          Image.asset(
            'assets/images/lapalma_lostilos.jpg',
            fit: BoxFit.cover, // Hace que la imagen ocupe toda la pantalla sin deformarse
            color: Colors.black.withValues(alpha: 0.6), // Oscurece la imagen un 60% para que las letras blancas destaquen
            colorBlendMode: BlendMode.darken,
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
                const SizedBox(height: 40),

                Image.asset(
                  'assets/images/icono_walking.png',
                  width: 250, // Ajusta el tamaño según veas en el móvil
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 60),
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