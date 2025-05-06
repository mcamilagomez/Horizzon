//Acá me traigo el contrato de domain/repositories y con las funciones de datasources y models hago lo que quiero
// Guardar el hash en hive
// Guardar un evento en la lista
// Quitar un evento de la lista
import 'package:horizzon/data/datasources/local/user_local.dart';
import 'package:horizzon/data/datasources/remote/remote_datasource.dart';
import 'package:horizzon/domain/entities/user.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final RemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  /// 🔐 Obtiene hash único, crea User y lo guarda en Hive
  @override
  Future<User> createUserWithHash() async {
    final hash = await remoteDataSource.generateHash();
    final user = User(hash: hash, myEvents: []);
    await localDataSource.saveUser(user);
    return user;
  }

  /// ➕ Agrega un evento a la lista del user
  @override
  Future<User> addEventToUser({
    required User user,
    required Event event,
  }) async {
    final updatedEvents = [...user.myEvents, event];
    final updatedUser = User(hash: user.hash, myEvents: updatedEvents);
    await localDataSource.saveUser(updatedUser);
    return updatedUser;
  }

  /// ➖ Elimina un evento de la lista del user
  @override
  Future<User> removeEventFromUser({
    required User user,
    required Event event,
  }) async {
    final updatedEvents = user.myEvents.where((e) => e.id != event.id).toList();
    final updatedUser = User(hash: user.hash, myEvents: updatedEvents);
    await localDataSource.saveUser(updatedUser);
    return updatedUser;
  }

  /// 📦 Obtiene el usuario actual desde Hive
  @override
  Future<User?> getUserFromCache() async {
    return await localDataSource.getUser();
  }
}
