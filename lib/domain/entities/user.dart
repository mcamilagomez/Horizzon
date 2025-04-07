import 'package:horizzon/domain/entities/event.dart';

class User {
  final String hash;
  List<Event> myEvents;

  User({
    required this.hash,
    required this.myEvents,
  });

  setMyEvents(List<Event> events) {
    myEvents = events;
  }
}
