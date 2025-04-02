import 'package:horizzon/domain/entities/conference.dart';

class Event {
  final int id;
  final String name;
  final String description;
  final List<Conference> conferences;
  final String coverImageUrl;

  Event({
    required this.id,
    required this.name,
    required this.description,
    required this.conferences,
    required this.coverImageUrl,
  });
}
