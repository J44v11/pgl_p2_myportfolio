import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static late SharedPreferences _prefs;

  // Inicializa la instancia (se llamará al arrancar la app)
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Guardar un String
  static Future<void> saveString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  // Recuperar un String (devuelve null si no existe)
  static String? getString(String key) {
    return _prefs.getString(key);
  }
}