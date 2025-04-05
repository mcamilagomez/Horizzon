import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/entities/user.dart';

abstract class FetchRepo {
  Future<void> subscribe(Event event, User user);
  Future<void> unsubscribe(Event event, User user);
  Future<void> addFeedback(String comment, Event event, int stars, String hash);
}
