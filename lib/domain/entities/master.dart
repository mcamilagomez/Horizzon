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
            longDescription:
                "En esta charla, exploraremos los últimos avances en IA y su impacto en la sociedad.",
            speakers: ["Dr. Smith", "Dra. Johnson"],
            feedbacks: [
              FeedbackbyUser(
                  userId: "user123",
                  stars: 5,
                  comment: "Excelente presentación, muy informativa"),
              FeedbackbyUser(
                  userId: "user456",
                  stars: 4,
                  comment: "Buen contenido pero un poco técnico"),
              FeedbackbyUser(
                  userId: "user456",
                  stars: 4,
                  comment: "Buen contenido pero un poco técnico"),
              FeedbackbyUser(userId: "user456", stars: 4, comment: ""),
            ],
            initialDate: DateTime(2025, 4, 7, 10, 0),
            finalDate: DateTime(2025, 4, 7, 12, 0),
            location: "Auditorio Principal",
            capacity: 500,
            availableSeats: 120,
            coverImageUrl: "https://example.com/tech-keynote.jpg",
            cardImageUrl: "/images/cover.jpeg",
            eventTrackName: "Conferencia de Tecnología 2023",
          ),
          Event(
            id: 102,
            name: "Taller de Flutter Avanzado",
            description: "Aprende técnicas avanzadas de Flutter",
            longDescription:
                "En este taller, profundizaremos en técnicas avanzadas de desarrollo con Flutter.",
            speakers: ["Ing. García"],
            feedbacks: [],
            initialDate: DateTime(2025, 4, 8, 14, 0),
            finalDate: DateTime(2025, 4, 8, 17, 0),
            location: "Sala B",
            capacity: 50,
            availableSeats: 5,
            coverImageUrl: "https://example.com/flutter-workshop.jpg",
            cardImageUrl: "/images/cover.jpeg",
            eventTrackName: "Conferencia de Tecnología 2023",
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
            longDescription:
                "Disfruta de una noche mágica con los mejores músicos de jazz.",
            speakers: ["The Jazz Trio", "Sarah Vocalist"],
            feedbacks: [],
            initialDate: DateTime(2023, 12, 5, 20, 0),
            finalDate: DateTime(2023, 12, 5, 23, 0),
            location: "Plaza Central",
            capacity: 1000,
            availableSeats: 250,
            coverImageUrl: "https://example.com/jazz-concert.jpg",
            cardImageUrl: "https://example.com/jazz-concert-card.jpg",
            eventTrackName: "Festival de Música Internacional",
          ),
        ],
        coverImageUrl: "https://example.com/music-festival.jpg",
      ),
    ];

    return Master(eventTracks: eventTracks);
  }
}
