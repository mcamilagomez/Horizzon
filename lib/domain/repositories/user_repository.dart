//Acá hago los contratos de todo lo que hará user
//Guardar un usuario
//Agregarle un evento
//Quitarle un evento
import 'package:horizzon/domain/entities/user.dart';
import 'package:horizzon/domain/entities/event.dart';

abstract class UserRepository {
  /// Genera un hash desde el backend, crea un usuario nuevo en Hive, y lo retorna
  Future<User> createUserWithHash();

  /// Agrega un evento a la lista de eventos del usuario (actualiza en Hive y en memoria)
  Future<User> addEventToUser({
    required User user,
    required Event event,
  });

  /// Elimina un evento de la lista de eventos del usuario (actualiza en Hive y en memoria)
  Future<User> removeEventFromUser({
    required User user,
    required Event event,
  });

  /// ✅ Obtiene el usuario desde Hive
  Future<User?> getUserFromCache();
}
