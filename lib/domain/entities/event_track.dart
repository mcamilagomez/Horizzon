import 'package:horizzon/domain/entities/event.dart';

class EventTrack {
  final int id;
  final String name;
  final String description;
  final List<Event> events;
  final String coverImageUrl;

  EventTrack({
    required this.id,
    required this.name,
    required this.description,
    required this.events,
    required this.coverImageUrl,
  });
}
