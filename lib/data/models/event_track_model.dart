import 'package:hive/hive.dart';
import 'event_model.dart';
import 'package:horizzon/domain/entities/event_track.dart';

part 'event_track_model.g.dart';

@HiveType(typeId: 2)
class EventTrackModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String coverImageUrl;

  @HiveField(4)
  final String overlayImageUrl;

  @HiveField(5)
  final List<EventModel> events;

  EventTrackModel({
    required this.id,
    required this.name,
    required this.description,
    required this.coverImageUrl,
    required this.overlayImageUrl,
    required this.events,
  });

  EventTrack toEntity() => EventTrack(
        id: id,
        name: name,
        description: description,
        coverImageUrl: coverImageUrl,
        overlayImageUrl: overlayImageUrl,
        events: events.map((e) => e.toEntity()).toList(),
      );

  factory EventTrackModel.fromEntity(EventTrack entity) => EventTrackModel(
        id: entity.id,
        name: entity.name,
        description: entity.description,
        coverImageUrl: entity.coverImageUrl,
        overlayImageUrl: entity.overlayImageUrl,
        events: entity.events.map((e) => EventModel.fromEntity(e)).toList(),
      );
}
