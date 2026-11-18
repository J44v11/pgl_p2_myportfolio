import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../services/auth_service.dart';
import '../../services/secure_storage_service.dart';
import '../../shared/exceptions/app_exception.dart';
import '../../shared/theme/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Clave para validar el estado de los inputs
  final _formKey = GlobalKey<FormState>();
  
  // Controladores
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  bool _isLoading = false;

  final AuthService _authService = AuthService();
  final SecureStorageService _secureStorage = SecureStorageService();

  // Función asíncrona para iniciar sesión
  Future<void> _login() async {
    // 1. Valida el formulario
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // 2. Hace la petición de login a la API y recupera el JWT
      final token = await _authService.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      // 3. Guarda el token de forma cifrada en el dispositivo
      await _secureStorage.saveToken(token);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('¡Inicio de sesión exitoso!'),
            backgroundColor: Colors.green,
          ),
        );
        // 4. Redirige a la pantalla de Bienvenida (raíz) al completarse el login
        context.go('/');
      }
    } on AppException catch (e) {
      // Captura los errores 401, 404, o de red controlados
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } catch (e) {
      // Captura otros errores inesperados
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error desconocido al intentar iniciar sesión.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Iniciar sesión', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primary,
        // Al ser la primera pantalla al abrir la app sin sesión, quitamos el botón de volver atrás
        automaticallyImplyLeading: false, 
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.lock_person, size: 80, color: AppColors.primary),
                  const SizedBox(height: 30),

                  // --- INPUT EMAIL ---
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Correo electrónico',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'El correo es obligatorio';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // --- INPUT CONTRASEÑA ---
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Contraseña',
                      prefixIcon: Icon(Icons.key),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'La contraseña es obligatoria';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),

                  // --- BOTÓN LOGIN ---
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: _isLoading ? null : _login,
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Entrar',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // --- BOTÓN IR A REGISTRO ---
                  TextButton(
                    // Navega a la pantalla de registro
                    onPressed: () => context.go('/register'),
                    child: const Text(
                      '¿No tienes cuenta? Regístrate aquí',
                      style: TextStyle(color: AppColors.primaryDark),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}