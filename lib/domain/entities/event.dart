class Event {
  final int id;
  final String name;
  final String description;
  final List<String> speakers;
  final List<Feedback> feedbacks;
  final DateTime initialDate;
  final DateTime finalDate;
  final String location;
  final int capacity;
  final int availableSeats;
  final String coverImageUrl;
  final String cardImageUrl;

  Event({
    required this.id,
    required this.name,
    required this.description,
    required this.speakers,
    required this.feedbacks,
    required this.initialDate,
    required this.finalDate,
    required this.location,
    required this.capacity,
    required this.availableSeats,
    required this.coverImageUrl,
    required this.cardImageUrl,
  });
}

class Feedback {
  final String userId;
  final int stars;
  final String comment;

  Feedback({
    required this.userId,
    required this.stars,
    required this.comment,
  });
}
