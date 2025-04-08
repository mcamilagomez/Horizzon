import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/entities/event_track.dart';

class Master {
  final List<EventTrack> eventTracks;

  Master({
    required this.eventTracks,
  });

  factory Master.createWithSampleData() {
    final eventTracks = [
      EventTrack(
        id: 1,
        name: "Conferencia de Tecnología 2023",
        description: "Los últimos avances en tecnología e innovación",
        coverImageUrl: "assets/images/LE1.jpg",
        overlayImageUrl: "assets/images/LE1.jpg",
        events: [
          Event(
            id: 101,
            name: "Keynote: El futuro de la IA",
            description: "Charla principal sobre inteligencia artificial",
            longDescription: "Exploración de las tendencias en IA para los próximos 5 años con demostraciones en vivo",
            speakers: ["Dr. Alan Smith", "Dra. Emma Johnson"],
            feedbacks: [
              FeedbackbyUser(userId: "user123", stars: 5, comment: "Excelente presentación"),
              FeedbackbyUser(userId: "user456", stars: 4, comment: "Muy técnico pero interesante"),
            ],
            initialDate: DateTime(2023, 11, 15, 10, 0),
            finalDate: DateTime(2023, 11, 15, 12, 0),
            location: "Auditorio Principal",
            capacity: 500,
            availableSeats: 120,
            coverImageUrl: "assets/images/cover.jpeg",
            cardImageUrl: "assets/images/cover.jpeg",
            eventTrackName: "Conferencia de Tecnología 2023",
          ),
          Event(
            id: 102,
            name: "Taller de Flutter Avanzado",
            description: "Aprende técnicas avanzadas de Flutter",
            longDescription: "Workshop práctico con ejemplos reales de apps complejas y mejores prácticas",
            speakers: ["Ing. Carlos García"],
            feedbacks: [
              FeedbackbyUser(userId: "user789", stars: 5, comment: "El mejor taller que he tomado"),
            ],
            initialDate: DateTime(2023, 11, 16, 14, 0),
            finalDate: DateTime(2023, 11, 16, 17, 0),
            location: "Sala de Talleres A",
            capacity: 30,
            availableSeats: 5,
            coverImageUrl: "assets/images/cover.jpeg",
            cardImageUrl: "assets/images/cover.jpeg",
            eventTrackName: "Conferencia de Tecnología 2023",
          ),
          Event(
            id: 103,
            name: "Blockchain en Negocios",
            description: "Aplicaciones prácticas de blockchain",
            longDescription: "Casos de uso reales en diferentes industrias con análisis de ROI",
            speakers: ["Dr. Robert Chen", "MBA Laura Méndez"],
            feedbacks: [],
            initialDate: DateTime(2023, 11, 17, 9, 0),
            finalDate: DateTime(2023, 11, 17, 11, 0),
            location: "Sala B",
            capacity: 150,
            availableSeats: 42,
            coverImageUrl: "assets/images/cover.jpeg",
            cardImageUrl: "assets/images/cover.jpeg",
            eventTrackName: "Conferencia de Tecnología 2023",
          ),
        ],
      ),
      EventTrack(
        id: 2,
        name: "Festival de Música Internacional",
        description: "Disfruta de artistas de todo el mundo",
        coverImageUrl: "assets/images/LE2.jpg",
        overlayImageUrl: "assets/images/LE2.jpg",
        events: [
          Event(
            id: 201,
            name: "Concierto de Jazz",
            description: "Noche de jazz con artistas premiados",
            longDescription: "Presentación especial del trío ganador del Grammy 2023 con repertorio exclusivo",
            speakers: ["The Jazz Trio", "Sarah Vocalist"],
            feedbacks: [],
            initialDate: DateTime(2023, 12, 5, 20, 0),
            finalDate: DateTime(2023, 12, 5, 23, 0),
            location: "Plaza Central",
            capacity: 1000,
            availableSeats: 250,
            coverImageUrl: "assets/images/events/jazz-concert.jpg",
            cardImageUrl: "assets/images/events/jazz-concert-card.jpg",
            eventTrackName: "Festival de Música Internacional",
          ),
          Event(
            id: 202,
            name: "Taller de Percusión",
            description: "Aprende ritmos básicos de percusión",
            longDescription: "Introducción a diferentes instrumentos de percusión mundial con sesión interactiva",
            speakers: ["Prof. Juan Martínez"],
            feedbacks: [
              FeedbackbyUser(userId: "user321", stars: 3, comment: "Esperaba más práctica"),
            ],
            initialDate: DateTime(2023, 12, 6, 16, 0),
            finalDate: DateTime(2023, 12, 6, 18, 0),
            location: "Sala de Talleres Musicales",
            capacity: 30,
            availableSeats: 0,
            coverImageUrl: "assets/images/events/percussion-workshop.jpg",
            cardImageUrl: "assets/images/events/percussion-workshop-card.jpg",
            eventTrackName: "Festival de Música Internacional",
          ),
        ],
      ),
    ];

    return Master(eventTracks: eventTracks);
  }
}