import 'package:hive/hive.dart';
import 'feedback_by_user_model.dart';
import 'package:horizzon/domain/entities/event.dart';

part 'event_model.g.dart';

@HiveType(typeId: 1)
class EventModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String longDescription;

  @HiveField(4)
  final List<String> speakers;

  @HiveField(5)
  final List<FeedbackByUserModel> feedbacks;

  @HiveField(6)
  final DateTime initialDate;

  @HiveField(7)
  final DateTime finalDate;

  @HiveField(8)
  final String location;

  @HiveField(9)
  final int capacity;

  @HiveField(10)
  int availableSeats;

  @HiveField(11)
  final String coverImageUrl;

  @HiveField(12)
  final String cardImageUrl;

  @HiveField(13)
  final String eventTrackName;

  EventModel({
    required this.id,
    required this.name,
    required this.description,
    required this.longDescription,
    required this.speakers,
    required this.feedbacks,
    required this.initialDate,
    required this.finalDate,
    required this.location,
    required this.capacity,
    required this.availableSeats,
    required this.coverImageUrl,
    required this.cardImageUrl,
    required this.eventTrackName,
  });

  Event toEntity() => Event(
        id: id,
        name: name,
        description: description,
        longDescription: longDescription,
        speakers: speakers,
        feedbacks: feedbacks.map((e) => e.toEntity()).toList(),
        initialDate: initialDate,
        finalDate: finalDate,
        location: location,
        capacity: capacity,
        availableSeats: availableSeats,
        coverImageUrl: coverImageUrl,
        cardImageUrl: cardImageUrl,
        eventTrackName: eventTrackName,
      );

  factory EventModel.fromEntity(Event entity) => EventModel(
        id: entity.id,
        name: entity.name,
        description: entity.description,
        longDescription: entity.longDescription,
        speakers: entity.speakers,
        feedbacks: entity.feedbacks
            .map((e) => FeedbackByUserModel.fromEntity(e))
            .toList(),
        initialDate: entity.initialDate,
        finalDate: entity.finalDate,
        location: entity.location,
        capacity: entity.capacity,
        availableSeats: entity.availableSeats,
        coverImageUrl: entity.coverImageUrl,
        cardImageUrl: entity.cardImageUrl,
        eventTrackName: entity.eventTrackName,
      );
}
