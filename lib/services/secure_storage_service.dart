import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  // Patrón Singleton para usar siempre la misma bóveda
  static final SecureStorageService _instance = SecureStorageService._internal();
  factory SecureStorageService() => _instance;
  SecureStorageService._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  
  static const String _tokenKey = 'jwt_token';

  // Guardar el token
  Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  // Leer el token
  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  // Borrar el token (Cerrar sesión)
  Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }
}