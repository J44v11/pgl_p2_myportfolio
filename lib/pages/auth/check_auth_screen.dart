import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../services/auth_service.dart';
import '../../services/secure_storage_service.dart';
import '../../shared/theme/app_colors.dart';

class CheckAuthScreen extends StatefulWidget {
  const CheckAuthScreen({super.key});

  @override
  State<CheckAuthScreen> createState() => _CheckAuthScreenState();
}

class _CheckAuthScreenState extends State<CheckAuthScreen> {
  @override
  void initState() {
    super.initState();
    // Ejecutamos la validación nada más cargar la pantalla
    _checkTokenAndRedirect();
  }

  Future<void> _checkTokenAndRedirect() async {
    final secureStorage = SecureStorageService();
    final authService = AuthService();

    final token = await secureStorage.getToken();

    // Si no hay token guardado, mandamos directamente al login
    if (token == null) {
      if (mounted) context.go('/login');
      return;
    }

    // Si hay token, preguntamos a la API si sigue siendo válido
    final isValid = await authService.checkToken(token);

    if (mounted) {
      if (isValid) {
        // Token vivo: saltamos la autenticación y vamos a Bienvenida
        context.go('/');
      } else {
        // Token caducado o inválido: lo borramos y pedimos login de nuevo
        await secureStorage.deleteToken();
        context.go('/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.white),
            SizedBox(height: 20),
            Text(
              'Verificando sesión...',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '(Puede tardar hasta 60s si el servidor está suspendido)',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}