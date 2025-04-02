import 'package:shared_preferences/shared_preferences.dart';

//Esto es lo que maneja que el usuario exista dentro de la app, es decir, si es primera vez o no
//Sirve para mostrar el tutorial, instanciar el fetch de datos, etc
class LocalPreferences {
  static const String _userKey = 'user';

  // Método para guardar el usuario como logeado (true)
  Future<void> setUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_userKey, true);
  }

  // Método para verificar si el usuario está logeado
  // Retorna false si no existe el valor

  Future<bool> verifyUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_userKey) ?? false;
  }

  // Método para eliminar el estado del usuario

  Future<void> deleteUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }
}
