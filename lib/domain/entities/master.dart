import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/entities/event_track.dart';

class Master {
  final List<EventTrack> eventTracks;

  Master({
    required this.eventTracks,
  });

  // Factory constructor para crear datos de prueba
  factory Master.createWithSampleData() {
    final eventTracks = [
      EventTrack(
        id: 1,
        name: "Conferencia de Tecnología 2023",
        description: "Los últimos avances en tecnología e innovación",
        events: [
          Event(
            id: 101,
            name: "Keynote: El futuro de la IA",
            description: "Charla principal sobre inteligencia artificial",
            speakers: ["Dr. Smith", "Dra. Johnson"],
            feedbacks: [
              Feedback(
                  userId: "user123",
                  stars: 5,
                  comment: "Excelente presentación, muy informativa"),
              Feedback(
                  userId: "user456",
                  stars: 4,
                  comment: "Buen contenido pero un poco técnico"),
            ],
            initialDate: DateTime(2023, 11, 15, 10, 0),
            finalDate: DateTime(2023, 11, 15, 12, 0),
            location: "Auditorio Principal",
            capacity: 500,
            availableSeats: 120,
            coverImageUrl: "https://example.com/tech-keynote.jpg",
            cardImageUrl: "/images/cover.jpeg",
          ),
          Event(
            id: 102,
            name: "Taller de Flutter Avanzado",
            description: "Aprende técnicas avanzadas de Flutter",
            speakers: ["Ing. García"],
            feedbacks: [
              Feedback(
                  userId: "user789",
                  stars: 5,
                  comment: "El mejor taller al que he asistido"),
            ],
            initialDate: DateTime(2023, 11, 16, 14, 0),
            finalDate: DateTime(2023, 11, 16, 17, 0),
            location: "Sala A",
            capacity: 50,
            availableSeats: 5,
            coverImageUrl: "https://example.com/flutter-workshop.jpg",
            cardImageUrl: "/images/cover.jpeg",
          ),
        ],
        coverImageUrl: "https://example.com/tech-conference.jpg",
      ),
      EventTrack(
        id: 2,
        name: "Festival de Música Internacional",
        description: "Disfruta de artistas de todo el mundo",
        events: [
          Event(
            id: 201,
            name: "Concierto de Jazz",
            description: "Noche de jazz con artistas premiados",
            speakers: ["The Jazz Trio", "Sarah Vocalist"],
            feedbacks: [],
            initialDate: DateTime(2023, 12, 5, 20, 0),
            finalDate: DateTime(2023, 12, 5, 23, 0),
            location: "Plaza Central",
            capacity: 1000,
            availableSeats: 250,
            coverImageUrl: "https://example.com/jazz-concert.jpg",
            cardImageUrl: "https://example.com/jazz-concert-card.jpg",
          ),
        ],
        coverImageUrl: "https://example.com/music-festival.jpg",
      ),
    ];

    return Master(eventTracks: eventTracks);
  }
}
