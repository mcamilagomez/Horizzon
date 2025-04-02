import 'package:horizzon/domain/entities/user.dart';

abstract class IEventmanagementRepo {
  Future<User> createUser(hash);
  Future<void> subscribe(id);
  Future<void> unsubscribe(id);
  Future<void> addFeedback(feedback);
}
