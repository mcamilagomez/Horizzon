class Event {
  final int id;
  final String name;
  final String description;
  final String longDescription;
  final List<String> speakers;
  final List<FeedbackbyUser> feedbacks;
  final DateTime initialDate;
  final DateTime finalDate;
  final String location;
  final int capacity;
  int availableSeats;
  final String coverImageUrl; // Aquí será base64 temporalmente
  final String cardImageUrl;
  final String eventTrackName;

  Event({
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

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      longDescription: json['long_description'],
      speakers: List<String>.from(json['speakers'] ?? []),
      feedbacks: (json['feedbacks'] as List<dynamic>?)
              ?.map((e) => FeedbackbyUser.fromJson(e))
              .toList() ??
          [],
      initialDate: DateTime.parse(json['initial_date']),
      finalDate: DateTime.parse(json['final_date']),
      location: json['location'],
      capacity: json['capacity'],
      availableSeats: json['available_seats'],
      coverImageUrl: json['cover_image'] ?? '',
      cardImageUrl: json['card_image'] ?? '',
      eventTrackName: json['event_track_name'],
    );
  }
}

class FeedbackbyUser {
  final String userId;
  final int stars;
  final String comment;

  FeedbackbyUser({
    required this.userId,
    required this.stars,
    required this.comment,
  });

  factory FeedbackbyUser.fromJson(Map<String, dynamic> json) {
    return FeedbackbyUser(
      userId: json['user_id'],
      stars: json['stars'],
      comment: json['comment'],
    );
  }
}
