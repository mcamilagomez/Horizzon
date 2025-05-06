import 'package:horizzon/domain/entities/event.dart';

class EventTrack {
  final int id;
  final String name;
  final String description;
  final String coverImageUrl;
  final String overlayImageUrl;
  final List<Event> events;

  EventTrack({
    required this.id,
    required this.name,
    required this.description,
    required this.coverImageUrl,
    required this.overlayImageUrl,
    required this.events,
  });

  factory EventTrack.fromJson(Map<String, dynamic> json) {
    return EventTrack(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      coverImageUrl: json['cover_image'] ?? '',
      overlayImageUrl: json['overlay_image'] ?? '',
      events: (json['events'] as List<dynamic>)
          .map((e) => Event.fromJson(e))
          .toList(),
    );
  }
}
