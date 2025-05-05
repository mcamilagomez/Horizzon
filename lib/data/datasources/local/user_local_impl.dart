import 'package:hive/hive.dart';
import 'package:horizzon/data/models/user_model.dart';
import 'package:horizzon/domain/entities/user.dart';
import 'user_local.dart';

class HiveUserLocalDataSource implements UserLocalDataSource {
  final Box<UserModel> userBox;

  HiveUserLocalDataSource(this.userBox);

  @override
  Future<void> saveUser(User user) async {
    final userModel = UserModel.fromEntity(user);
    await userBox.put('current_user', userModel);
  }

  @override
  Future<User?> getUser() async {
    final model = userBox.get('current_user');
    return model?.toEntity();
  }
}
