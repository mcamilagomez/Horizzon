import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/entities/event_track.dart';
import 'package:horizzon/domain/entities/master.dart';

class ManageData {
  // Función para crear un objeto Master con datos fijos de prueba
  static Master createMasterWithData() {
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
            cardImageUrl: "https://example.com/tech-keynote-card.jpg",
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
            cardImageUrl: "https://example.com/flutter-workshop-card.jpg",
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
            feedbacks: [], // Sin feedbacks
            initialDate: DateTime(2023, 12, 5, 20, 0),
            finalDate: DateTime(2023, 12, 5, 23, 0),
            location: "Plaza Central",
            capacity: 1000,
            availableSeats: 250,
            coverImageUrl: "https://example.com/jazz-concert.jpg",
            cardImageUrl: "https://example.com/jazz-concert-card.jpg",
          ),
          Event(
            id: 202,
            name: "Taller de Percusión",
            description: "Aprende ritmos básicos de percusión",
            speakers: ["Prof. Martínez"],
            feedbacks: [
              Feedback(
                  userId: "user321",
                  stars: 3,
                  comment: "Estuvo bien pero esperaba más práctica"),
              Feedback(
                  userId: "user654", stars: 4, comment: ""), // Comentario vacío
            ],
            initialDate: DateTime(2023, 12, 6, 16, 0),
            finalDate: DateTime(2023, 12, 6, 18, 0),
            location: "Sala B",
            capacity: 30,
            availableSeats: 0,
            coverImageUrl: "https://example.com/percussion-workshop.jpg",
            cardImageUrl: "https://example.com/percussion-workshop-card.jpg",
          ),
          Event(
            id: 203,
            name: "Concierto de Clásicos",
            description: "Los mejores clásicos de todos los tiempos",
            speakers: ["Orquesta Filarmónica"],
            feedbacks: [], // Sin feedbacks
            initialDate: DateTime(2023, 12, 7, 19, 0),
            finalDate: DateTime(2023, 12, 7, 21, 30),
            location: "Teatro Municipal",
            capacity: 800,
            availableSeats: 150,
            coverImageUrl: "https://example.com/classic-concert.jpg",
            cardImageUrl: "https://example.com/classic-concert-card.jpg",
          ),
        ],
        coverImageUrl: "https://example.com/music-festival.jpg",
      ),
      // Puedes añadir más EventTracks aquí si necesitas
    ];

    return Master(eventTracks: eventTracks);
  }
}
