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
  final String coverImageUrl;
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
}
