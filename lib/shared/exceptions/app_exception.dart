abstract class AppException implements Exception {
  final String message;
  final dynamic originalError;
  final StackTrace? stackTrace;

  AppException({required this.message, this.originalError, this.stackTrace});

  @override
  String toString() => message;
}

// Excepción para cuando el servidor devuelve un 401 o 403 (Contraseña mal, sin permisos...)
class AuthException extends AppException {
  AuthException({super.message = 'No autorizado.'});
}

// Excepción para cuando el servidor devuelve 400 o 409 (Email repetido, faltan datos...)
class BadRequestException extends AppException {
  BadRequestException({super.message = 'Petición incorrecta.'});
}

// Excepción para caídas de red o servidor apagado (Render suspendido)
class NetworkException extends AppException {
  NetworkException({super.message = 'Error de conexión con el servidor.'});
}