import 'package:horizzon/domain/entities/event.dart';

class EventTrack {
  final int id;
  final String name;
  final String description;
  final List<Event> conferences;
  final String coverImageUrl;

  EventTrack({
    required this.id,
    required this.name,
    required this.description,
    required this.conferences,
    required this.coverImageUrl,
  });
}
