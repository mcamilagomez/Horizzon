//Acá se mete en hive el user
import 'package:horizzon/domain/entities/user.dart';

abstract class UserLocalDataSource {
  Future<User?> getUser();
  Future<void> saveUser(User user);
}
