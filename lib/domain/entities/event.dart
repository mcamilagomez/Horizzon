class Event {
  final int id;
  final int eventTrackId;
  final String name;
  final String description;
  final String longDescription;
  final List<String> speakers;
  final DateTime initialDate;
  final DateTime finalDate;
  final String location;
  final int capacity;
  int availableSeats;
  final String coverImageUrl;
  final String cardImageUrl;
  final String eventTrackName;
  final List<FeedbackbyUser> feedbacks;

  Event({
    required this.id,
    required this.eventTrackId,
    required this.name,
    required this.description,
    required this.longDescription,
    required this.speakers,
    required this.initialDate,
    required this.finalDate,
    required this.location,
    required this.capacity,
    required this.availableSeats,
    required this.coverImageUrl,
    required this.cardImageUrl,
    required this.eventTrackName,
    required this.feedbacks,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      eventTrackId: json['event_track_id'],
      name: json['name'],
      description: json['description'],
      longDescription: json['long_description'],
      speakers: List<String>.from(json['speakers']),
      initialDate: DateTime.parse(json['initial_date']),
      finalDate: DateTime.parse(json['final_date']),
      location: json['location'],
      capacity: json['capacity'],
      availableSeats: json['available_seats'],
      coverImageUrl: json['cover_image'] ?? '',
      cardImageUrl: json['card_image'] ?? '',
      eventTrackName: json['event_track_name'],
      feedbacks: (json['feedbacks'] as List<dynamic>)
          .map((f) => FeedbackbyUser.fromJson(f))
          .toList(),
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
      userId: "user_22354334234",
      stars: json['stars'],
      comment: json['comment'],
    );
  }
}
