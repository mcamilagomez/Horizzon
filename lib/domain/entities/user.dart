import 'package:horizzon/domain/entities/event.dart';

class User {
  final String hash;
  final List<Event> myEvents;

  User({
    required this.hash,
    required this.myEvents,
  });
}
