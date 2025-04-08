import 'package:horizzon/domain/entities/event.dart';

class EventTrack {
  final int id;
  final String name;
  final String description;
  final String coverImageUrl;
  final String overlayImageUrl; // Nueva propiedad
  final List<Event> events;

  EventTrack({
    required this.id,
    required this.name,
    required this.description,
    required this.coverImageUrl,
    required this.overlayImageUrl, // Añadido al constructor
    required this.events,
  });
}