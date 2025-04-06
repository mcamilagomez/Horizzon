import 'package:horizzon/domain/entities/event.dart';

class User {
  final String hash;
  final List<Event> myConferences;

  User({
    required this.hash,
    required this.myConferences,
  });
}
