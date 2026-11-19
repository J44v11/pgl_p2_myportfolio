import 'dart:convert';
import 'package:http/http.dart' as http;
import '../shared/exceptions/app_exception.dart';

class AuthService {
  // Patrón Singleton para mantener una única instancia del servicio en toda la app
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // URL base de la API alojada en Render
  static const String _baseUrl = 'https://my-users-api.onrender.com/users';

  // --- ENDPOINT: REGISTRO ---
  Future<void> register(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/register'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'fullName': name,
          'email': email,
          'pwd': password,
        }),
      );

      _processResponse(response); // Valida el código de estado HTTP
    } catch (e) {
      _handleException(e);
    }
  }

  // --- ENDPOINT: LOGIN ---
  Future<String> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'pwd': password,
        }),
      );

      _processResponse(response);
      final data = jsonDecode(response.body);
      // La API devuelve un token JWT al hacer login correctamente
      return data['token']; 
    } catch (e) {
      _handleException(e);
      return ''; // Retorno de seguridad (nunca debería llegar aquí por el rethrow)
    }
  }

  // --- ENDPOINT: COMPROBAR TOKEN ---
  Future<bool> checkToken(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/check-token'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Se envía el token en la cabecera
        },
      );

      // Si responde 200, el token sigue vivo y es válido
      if (response.statusCode == 200) return true;
      return false;
    } catch (e) {
      return false; // Si no hay internet o el servidor cae, asumimos token inválido temporalmente
    }
  }

  // --- ENDPOINT: BIENVENIDA ---
  Future<String> getWelcomeMessage(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/welcome'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      _processResponse(response);
      final data = jsonDecode(response.body);
      return data['message'];
    } catch (e) {
      _handleException(e);
      return '';
    }
  }

  // --- LÓGICA CENTRALIZADA DE MANEJO DE ERRORES HTTP ---
  void _processResponse(http.Response response) {
    // Si el código es 2xx, la petición fue un éxito
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return; 
    }

    // Imprimimos la respuesta en crudo para ver el error real del backend
    print('ERROR DE LA API: ${response.statusCode} - ${response.body}');
    
    // Si hay error, la API siempre devuelve un JSON con formato {"message": "..."}
    final Map<String, dynamic> errorBody = jsonDecode(response.body);
    final String apiMessage = errorBody['message'] ?? 'Error desconocido del servidor';

    // Lanzamos la excepción correspondiente según el código HTTP devuelto
    switch (response.statusCode) {
      case 400:
      case 409:
        throw BadRequestException(message: apiMessage);
      case 401:
      case 403:
        throw AuthException(message: apiMessage);
      default:
        throw NetworkException(message: apiMessage);
    }
  }

  // --- MANEJADOR DE CATCH GENERAL ---
  void _handleException(dynamic e) {
    if (e is AppException) {
      throw e; // <-- CORRECCIÓN: cambiamos rethrow por throw e
    } else {
      // Si es un error inesperado (ej. SocketException por falta de WiFi)
      throw NetworkException(message: 'No se pudo contactar con el servidor. (¿Render suspendido?)');
    }
  }
}