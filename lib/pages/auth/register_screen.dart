import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../services/auth_service.dart';
import '../../shared/exceptions/app_exception.dart';
import '../../shared/theme/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Clave global para identificar y validar el formulario completo
  final _formKey = GlobalKey<FormState>();
  
  // Controladores para capturar el texto de los inputs
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  // Estado de carga para deshabilitar el botón mientras se espera a la API
  bool _isLoading = false;

  // Instancia de nuestro servicio HTTP
  final AuthService _authService = AuthService();

  // Función asíncrona para registrar al usuario
  Future<void> _register() async {
    // 1. Valida todos los inputs. Si alguno falla, detiene la ejecución.
    if (!_formKey.currentState!.validate()) return;

    // 2. Cambia el estado a "cargando" para repintar la UI y bloquear el botón
    setState(() => _isLoading = true);

    try {
      // 3. Llama al endpoint de la API usando el servicio
      await _authService.register(
        _nameController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      // 4. Si la petición fue exitosa, muestra mensaje y navega al login
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('¡Registro exitoso! Por favor, inicia sesión.'),
            backgroundColor: Colors.green,
          ),
        );
        // Redirige a la pantalla de login (que crearemos en el próximo paso)
        context.go('/login');
      }
    } on AppException catch (e) {
      // 5a. Captura nuestras excepciones personalizadas (errores HTTP esperados)
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } catch (e) {
      // 5b. Captura cualquier otro error imprevisto
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ha ocurrido un error inesperado.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      // 6. Ocurra un error o un éxito, devolvemos el estado de carga a falso
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    // Buena práctica: liberar la memoria de los controladores al destruir la pantalla
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Crear cuenta', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      // SafeArea y SingleChildScrollView evitan el temido "overflow" provocado por el teclado táctil
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.person_add_alt_1, size: 80, color: AppColors.primary),
                  const SizedBox(height: 30),
                  
                  // --- INPUT NOMBRE ---
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nombre completo',
                      prefixIcon: Icon(Icons.badge),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'El nombre es obligatorio';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

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
                      // Expresión regular para validar formato de email
                      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Introduce un correo válido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // --- INPUT CONTRASEÑA ---
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true, // Oculta el texto para contraseñas
                    decoration: const InputDecoration(
                      labelText: 'Contraseña',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'La contraseña es obligatoria';
                      }
                      if (value.length < 6) {
                        return 'La contraseña debe tener al menos 6 caracteres';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),

                  // --- BOTÓN REGISTRAR ---
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
                      // Si está cargando, el botón se deshabilita (onPressed = null)
                      onPressed: _isLoading ? null : _register,
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Registrarse',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Enlace rápido para volver al login si el usuario ya tiene cuenta
                  TextButton(
                    onPressed: () => context.go('/login'),
                    child: const Text(
                      '¿Ya tienes cuenta? Inicia sesión aquí',
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