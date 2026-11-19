import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../shared/widgets/app_drawer.dart';
import '../../shared/theme/app_colors.dart';
import '../../services/auth_service.dart';
import '../../services/secure_storage_service.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _isLoadingWelcome = false;

  // Requisito 4: Función para cerrar sesión
  Future<void> _logout() async {
    await SecureStorageService().deleteToken();
    if (mounted) context.go('/login');
  }

  // Requisito 5: Probar API Bienvenida
  Future<void> _fetchWelcomeMessage() async {
    setState(() => _isLoadingWelcome = true);
    
    final token = await SecureStorageService().getToken();
    
    if (token != null) {
      final message = await AuthService().getWelcomeMessage(token);
      if (mounted && message.isNotEmpty) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Mensaje de la API'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cerrar'),
              ),
            ],
          ),
        );
      }
    }
    
    if (mounted) setState(() => _isLoadingWelcome = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          // Botón de Cerrar Sesión en la esquina superior derecha
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            tooltip: 'Cerrar sesión',
            onPressed: _logout,
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/lapalma_lostilos.jpg',
            fit: BoxFit.cover,
            color: Colors.black.withValues(alpha: 0.6),
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
                  style: TextStyle(fontSize: 18, color: Colors.white70),
                ),
                const SizedBox(height: 40),

                Image.asset(
                  'assets/images/icono_walking.png',
                  width: 250, 
                  fit: BoxFit.contain,
                ),

                const SizedBox(height: 40),
                
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed: () => context.go('/portfolio'),
                  child: const Text('Empezar', style: TextStyle(fontSize: 22, color: Colors.white)),
                ),
                
                const SizedBox(height: 30),
                
                // Botón extra para lanzar el endpoint de bienvenida
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  onPressed: _isLoadingWelcome ? null : _fetchWelcomeMessage,
                  icon: _isLoadingWelcome 
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : const Icon(Icons.api),
                  label: const Text('Probar API Bienvenida'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}