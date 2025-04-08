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
        name: "Congreso de Inteligencia Artificial",
        description: "Explorando el futuro de la IA y sus aplicaciones",
        coverImageUrl: "assets/images/LE1.jpg",
        overlayImageUrl: "assets/images/LE1.jpg",
        events: [
          Event(
            id: 101,
            name: "Ética en el Desarrollo de IA",
            description: "Discusión sobre los aspectos éticos en IA",
            longDescription:
                "Un análisis profundo de los dilemas éticos que enfrentamos al desarrollar sistemas de inteligencia artificial, con casos prácticos de la industria y posibles soluciones para garantizar un desarrollo responsable.",
            speakers: ["Dra. Elena Morales", "Dr. James Wilson"],
            feedbacks: [
              FeedbackbyUser(
                  userId: "user101", stars: 4, comment: "Muy informativo"),
              FeedbackbyUser(
                  userId: "user102", stars: 5, comment: "Excelentes ponentes"),
            ],
            initialDate: DateTime(2025, 4, 10, 9, 0),
            finalDate: DateTime(2025, 4, 10, 11, 30),
            location: "Sala Principal",
            capacity: 300,
            availableSeats: 45,
            coverImageUrl: "assets/images/ethics_ai.jpg",
            cardImageUrl: "assets/images/ethics_ai.jpg",
            eventTrackName: "Congreso de Inteligencia Artificial",
          ),
          Event(
            id: 102,
            name: "IA en el Sector Salud",
            description: "Aplicaciones médicas de la inteligencia artificial",
            longDescription:
                "Descubre cómo la IA está revolucionando el diagnóstico médico, el desarrollo de fármacos y la atención al paciente, con demostraciones de sistemas actualmente en uso en hospitales líderes.",
            speakers: ["Dr. Carlos Méndez"],
            feedbacks: [],
            initialDate: DateTime(2025, 4, 10, 14, 0),
            finalDate: DateTime(2025, 4, 10, 16, 0),
            location: "Sala B",
            capacity: 150,
            availableSeats: 0,
            coverImageUrl: "assets/images/ai_health.jpg",
            cardImageUrl: "assets/images/ai_healthjpg",
            eventTrackName: "Congreso de Inteligencia Artificial",
          ),
          Event(
            id: 103,
            name: "Machine Learning Avanzado",
            description: "Técnicas modernas de aprendizaje automático",
            longDescription:
                "Taller práctico donde exploraremos arquitecturas de redes neuronales avanzadas, técnicas de optimización y casos de uso en la industria para resolver problemas complejos con machine learning.",
            speakers: ["Dr. Samuel Zhang", "Dra. Laura Kim"],
            feedbacks: [
              FeedbackbyUser(
                  userId: "user103",
                  stars: 5,
                  comment: "Contenido de primer nivel"),
              FeedbackbyUser(
                  userId: "user104",
                  stars: 5,
                  comment: "Los ejercicios prácticos fueron muy útiles"),
              FeedbackbyUser(
                  userId: "user105",
                  stars: 4,
                  comment: "Un poco avanzado para mi nivel"),
            ],
            initialDate: DateTime(2025, 4, 11, 10, 0),
            finalDate: DateTime(2025, 4, 11, 13, 0),
            location: "Laboratorio de Computación",
            capacity: 40,
            availableSeats: 8,
            coverImageUrl: "assets/images/ml_advanced.jpg",
            cardImageUrl: "assets/images/ml_advanced.jpg",
            eventTrackName: "Congreso de Inteligencia Artificial",
          ),
          Event(
            id: 104,
            name: "Chatbots y Asistentes Virtuales",
            description: "Diseño e implementación de conversaciones IA",
            longDescription:
                "Aprende las mejores prácticas para crear chatbots efectivos, desde el diseño de la conversación hasta la implementación con frameworks modernos y técnicas de procesamiento de lenguaje natural.",
            speakers: ["Ing. Patricia Gómez"],
            feedbacks: [
              FeedbackbyUser(
                  userId: "user106",
                  stars: 4,
                  comment: "Buen contenido práctico"),
            ],
            initialDate: DateTime(2025, 4, 11, 15, 0),
            finalDate: DateTime(2025, 4, 11, 17, 0),
            location: "Sala C",
            capacity: 80,
            availableSeats: 22,
            coverImageUrl: "assets/images/chatbots.jpg",
            cardImageUrl: "assets/images/chatbots.jpg",
            eventTrackName: "Congreso de Inteligencia Artificial",
          ),
          Event(
            id: 105,
            name: "El Futuro del Trabajo con IA",
            description: "Cómo la IA transformará las profesiones",
            longDescription:
                "Panel de discusión sobre los impactos de la inteligencia artificial en el mercado laboral, qué habilidades serán más valiosas y cómo prepararse para los cambios que vienen en la próxima década.",
            speakers: [
              "Dra. María Fernández",
              "Lic. Roberto Castro",
              "Dr. Alan Park"
            ],
            feedbacks: [
              FeedbackbyUser(
                  userId: "user107",
                  stars: 5,
                  comment: "Perspectivas muy valiosas"),
              FeedbackbyUser(
                  userId: "user108",
                  stars: 3,
                  comment: "Me hubiera gustado más datos concretos"),
              FeedbackbyUser(
                  userId: "user109",
                  stars: 4,
                  comment: "Interesante discusión"),
            ],
            initialDate: DateTime(2025, 4, 12, 11, 0),
            finalDate: DateTime(2025, 4, 12, 13, 0),
            location: "Auditorio Principal",
            capacity: 250,
            availableSeats: 45,
            coverImageUrl: "assets/images/future_work.jpg",
            cardImageUrl: "assets/images/future_work_card.jpg",
            eventTrackName: "Congreso de Inteligencia Artificial",
          ),
        ],
      ),
      EventTrack(
        id: 2,
        name: "Festival Gastronómico Internacional",
        description: "Sabores del mundo en un solo lugar",
        coverImageUrl: "assets/images/food_festival.jpg",
        overlayImageUrl: "assets/images/food_festival_overlay.jpg",
        events: [
          Event(
            id: 201,
            name: "Taller de Cocina Japonesa",
            description: "Aprende los fundamentos de la cocina japonesa",
            longDescription:
                "Masterclass práctica donde aprenderás a preparar sushi auténtico, ramen y otros platos tradicionales japoneses, con ingredientes frescos y técnicas profesionales.",
            speakers: ["Chef Takashi Yamamoto"],
            feedbacks: [
              FeedbackbyUser(
                  userId: "user201",
                  stars: 5,
                  comment: "Increíble experiencia"),
              FeedbackbyUser(
                  userId: "user202", stars: 4, comment: "Muy bien organizado"),
              FeedbackbyUser(
                  userId: "user203",
                  stars: 5,
                  comment: "El chef fue excelente"),
            ],
            initialDate: DateTime(2025, 4, 15, 10, 0),
            finalDate: DateTime(2025, 4, 15, 13, 0),
            location: "Cocina Principal",
            capacity: 20,
            availableSeats: 0,
            coverImageUrl: "assets/images/japanese_cooking.jpg",
            cardImageUrl: "assets/images/japanese_cooking.jpg",
            eventTrackName: "Festival Gastronómico Internacional",
          ),
          Event(
            id: 202,
            name: "Maridaje de Vinos y Quesos",
            description: "Descubre las mejores combinaciones",
            longDescription:
                "Degustación guiada por un sommelier experto donde aprenderás a combinar diferentes tipos de vinos con quesos artesanales para realzar los sabores de ambos productos.",
            speakers: ["Sommelier Andrea Rojas"],
            feedbacks: [
              FeedbackbyUser(
                  userId: "user204",
                  stars: 5,
                  comment: "Experiencia sensorial única"),
              FeedbackbyUser(
                  userId: "user205", stars: 4, comment: "Muy buen ambiente"),
            ],
            initialDate: DateTime(2025, 4, 15, 17, 0),
            finalDate: DateTime(2025, 4, 15, 19, 0),
            location: "Salón de Degustación",
            capacity: 30,
            availableSeats: 5,
            coverImageUrl: "assets/images/wine_cheese.jpg",
            cardImageUrl: "assets/images/wine_cheesejpg",
            eventTrackName: "Festival Gastronómico Internacional",
          ),
          Event(
            id: 203,
            name: "Cocina Molecular para Principiantes",
            description: "Introducción a las técnicas vanguardistas",
            longDescription:
                "Taller interactivo donde experimentarás con esferificaciones, aires y otros efectos sorprendentes de la cocina molecular, usando ingredientes y equipos accesibles para principiantes.",
            speakers: ["Chef Daniel Molina"],
            feedbacks: [],
            initialDate: DateTime(2025, 4, 16, 11, 0),
            finalDate: DateTime(2025, 4, 16, 14, 0),
            location: "Laboratorio de Cocina",
            capacity: 15,
            availableSeats: 0,
            coverImageUrl: "assets/images/molecular.jpg",
            cardImageUrl: "assets/images/molecular_card.jpg",
            eventTrackName: "Festival Gastronómico Internacional",
          ),
          Event(
            id: 204,
            name: "Postres Sin Gluten",
            description: "Delicias para intolerantes al gluten",
            longDescription:
                "Demostración en vivo de cómo preparar postres deliciosos sin gluten, con alternativas de harinas y técnicas especiales para lograr texturas perfectas sin comprometer el sabor.",
            speakers: ["Repostera Luisa Martínez"],
            feedbacks: [
              FeedbackbyUser(
                  userId: "user206",
                  stars: 5,
                  comment: "Finalmente puedo comer postres ricos"),
              FeedbackbyUser(
                  userId: "user207",
                  stars: 5,
                  comment: "Recetas fáciles de seguir"),
            ],
            initialDate: DateTime(2025, 4, 16, 16, 0),
            finalDate: DateTime(2025, 4, 16, 18, 0),
            location: "Cocina Dulce",
            capacity: 25,
            availableSeats: 10,
            coverImageUrl: "assets/images/gluten_free.jpg",
            cardImageUrl: "assets/images/gluten_free_card.jpg",
            eventTrackName: "Festival Gastronómico Internacional",
          ),
          Event(
            id: 205,
            name: "Cata de Café de Especialidad",
            description: "Descubre los sabores del café gourmet",
            longDescription:
                "Recorrido por los principales orígenes de café de especialidad, aprendiendo a distinguir sus características de aroma, sabor y cuerpo, con métodos de preparación artesanales.",
            speakers: ["Barista Jorge Silva"],
            feedbacks: [
              FeedbackbyUser(
                  userId: "user208",
                  stars: 4,
                  comment: "Aprendí mucho sobre café"),
              FeedbackbyUser(
                  userId: "user209",
                  stars: 5,
                  comment: "El barista es muy conocedor"),
              FeedbackbyUser(
                  userId: "user210",
                  stars: 3,
                  comment: "Demasiada información técnica"),
            ],
            initialDate: DateTime(2025, 4, 17, 10, 0),
            finalDate: DateTime(2025, 4, 17, 12, 0),
            location: "Cafetería Central",
            capacity: 20,
            availableSeats: 3,
            coverImageUrl: "assets/images/coffee.jpg",
            cardImageUrl: "assets/images/coffee_card.jpg",
            eventTrackName: "Festival Gastronómico Internacional",
          ),
          Event(
            id: 206,
            name: "Cocina Vegana Creativa",
            description: "Platos innovadores sin productos animales",
            longDescription:
                "Demostración de cómo preparar platos veganos que sorprenden por su sabor y presentación, usando técnicas profesionales e ingredientes poco convencionales en la cocina vegetal.",
            speakers: ["Chef Valentina Ríos"],
            feedbacks: [
              FeedbackbyUser(
                  userId: "user211",
                  stars: 5,
                  comment: "Increíble lo que se puede hacer sin carne"),
            ],
            initialDate: DateTime(2025, 4, 17, 15, 0),
            finalDate: DateTime(2025, 4, 17, 17, 30),
            location: "Cocina Verde",
            capacity: 30,
            availableSeats: 12,
            coverImageUrl: "assets/images/vegan.jpg",
            cardImageUrl: "assets/images/vegan_card.jpg",
            eventTrackName: "Festival Gastronómico Internacional",
          ),
        ],
      ),
      EventTrack(
        id: 3,
        name: "Cumbre de Energías Renovables",
        description: "Innovación en energía sostenible",
        coverImageUrl: "assets/images/renewable_energy.jpg",
        overlayImageUrl: "assets/images/renewable_energy_overlay.jpg",
        events: [
          Event(
            id: 301,
            name: "El Futuro de la Energía Solar",
            description: "Avances tecnológicos en paneles solares",
            longDescription:
                "Exploración de las últimas innovaciones en tecnología solar, incluyendo paneles de alta eficiencia y sistemas de almacenamiento, con proyecciones de costos para los próximos años.",
            speakers: ["Ing. Sofía Ramírez", "Dr. Hans Müller"],
            feedbacks: [
              FeedbackbyUser(
                  userId: "user301",
                  stars: 3,
                  comment: "Interesante pero muy técnico"),
            ],
            initialDate: DateTime(2025, 4, 20, 9, 0),
            finalDate: DateTime(2025, 4, 20, 11, 0),
            location: "Auditorio Verde",
            capacity: 200,
            availableSeats: 75,
            coverImageUrl: "assets/images/solar_energy.jpg",
            cardImageUrl: "assets/images/solar_energy_card.jpg",
            eventTrackName: "Cumbre de Energías Renovables",
          ),
          Event(
            id: 302,
            name: "Energía Eólica Offshore",
            description: "Parques eólicos marinos a gran escala",
            longDescription:
                "Análisis de los desafíos técnicos y logísticos de instalar y mantener parques eólicos en el mar, con casos de estudio de proyectos europeos y su aplicabilidad en nuestra región.",
            speakers: ["Ing. Carlos Bertolini"],
            feedbacks: [],
            initialDate: DateTime(2025, 4, 20, 14, 0),
            finalDate: DateTime(2025, 4, 20, 16, 0),
            location: "Sala Eólica",
            capacity: 150,
            availableSeats: 42,
            coverImageUrl: "assets/images/wind_energy.jpg",
            cardImageUrl: "assets/images/wind_energy_card.jpg",
            eventTrackName: "Cumbre de Energías Renovables",
          ),
          Event(
            id: 303,
            name: "Almacenamiento de Energía",
            description: "Tecnologías para guardar energía renovable",
            longDescription:
                "Comparativa de las diferentes tecnologías de almacenamiento energético, desde baterías de ion-litio hasta sistemas hidráulicos y de aire comprimido, con sus ventajas y limitaciones.",
            speakers: ["Dra. Laura Chen", "Ing. Marco Pérez"],
            feedbacks: [
              FeedbackbyUser(
                  userId: "user302",
                  stars: 5,
                  comment: "Contenido muy actualizado"),
              FeedbackbyUser(
                  userId: "user303",
                  stars: 4,
                  comment: "Buen balance entre teoría y práctica"),
            ],
            initialDate: DateTime(2025, 4, 21, 10, 0),
            finalDate: DateTime(2025, 4, 21, 12, 30),
            location: "Sala de Tecnología",
            capacity: 180,
            availableSeats: 25,
            coverImageUrl: "assets/images/energy_storage.jpg",
            cardImageUrl: "assets/images/energy_storage_card.jpg",
            eventTrackName: "Cumbre de Energías Renovables",
          ),
          Event(
            id: 304,
            name: "Hidrógeno Verde",
            description: "El combustible del futuro",
            longDescription:
                "Explicación detallada de cómo se produce el hidrógeno mediante electrólisis usando energías renovables, sus aplicaciones potenciales y los desafíos para su adopción masiva.",
            speakers: ["Dr. Robert Fischer"],
            feedbacks: [
              FeedbackbyUser(
                  userId: "user304",
                  stars: 5,
                  comment: "El ponente es un experto reconocido"),
              FeedbackbyUser(
                  userId: "user305",
                  stars: 4,
                  comment: "Me gustaron los ejemplos prácticos"),
              FeedbackbyUser(
                  userId: "user306",
                  stars: 3,
                  comment: "Demasiado enfocado en Europa"),
            ],
            initialDate: DateTime(2025, 4, 21, 15, 0),
            finalDate: DateTime(2025, 4, 21, 17, 0),
            location: "Auditorio Principal",
            capacity: 250,
            availableSeats: 18,
            coverImageUrl: "assets/images/green_hydrogen.jpg",
            cardImageUrl: "assets/images/green_hydrogen_card.jpg",
            eventTrackName: "Cumbre de Energías Renovables",
          ),
          Event(
            id: 305,
            name: "Políticas Públicas para la Transición",
            description: "Cómo acelerar el cambio a energías limpias",
            longDescription:
                "Panel de discusión con expertos en políticas energéticas sobre las medidas que pueden tomar los gobiernos para incentivar la adopción de energías renovables y desincentivar los combustibles fósiles.",
            speakers: [
              "Dip. Ana Vargas",
              "Dr. Klaus Schmidt",
              "Lic. Pedro Rojas"
            ],
            feedbacks: [
              FeedbackbyUser(
                  userId: "user307",
                  stars: 4,
                  comment: "Interesante perspectiva política"),
              FeedbackbyUser(
                  userId: "user308", stars: 2, comment: "Demasiado teórico"),
            ],
            initialDate: DateTime(2025, 4, 22, 11, 0),
            finalDate: DateTime(2025, 4, 22, 13, 0),
            location: "Sala de Conferencias",
            capacity: 200,
            availableSeats: 65,
            coverImageUrl: "assets/images/energy_policy.jpg",
            cardImageUrl: "assets/images/energy_policy_card.jpg",
            eventTrackName: "Cumbre de Energías Renovables",
          ),
        ],
      ),
      EventTrack(
        id: 4,
        name: "Congreso de Medicina Avanzada",
        description: "Innovaciones en el campo de la salud",
        coverImageUrl: "assets/images/medical_congress.jpg",
        overlayImageUrl: "assets/images/medical_congress_overlay.jpg",
        events: [
          Event(
            id: 401,
            name: "Avances en Oncología",
            description: "Nuevos tratamientos contra el cáncer",
            longDescription:
                "Revisión de las terapias más prometedoras en desarrollo, incluyendo inmunoterapias y tratamientos personalizados basados en genética, con casos de éxito recientes.",
            speakers: ["Dr. Laura Méndez", "Dr. Robert Chen"],
            feedbacks: [
              FeedbackbyUser(
                  userId: "user401",
                  stars: 5,
                  comment: "Contenido esperanzador"),
              FeedbackbyUser(
                  userId: "user402", stars: 4, comment: "Muy bien documentado"),
            ],
            initialDate: DateTime(2025, 5, 5, 9, 0),
            finalDate: DateTime(2025, 5, 5, 11, 30),
            location: "Auditorio Central",
            capacity: 300,
            availableSeats: 45,
            coverImageUrl: "assets/images/oncology.jpg",
            cardImageUrl: "assets/images/oncology_card.jpg",
            eventTrackName: "Congreso de Medicina Avanzada",
          ),
          Event(
            id: 402,
            name: "Cirugía Robótica",
            description: "El futuro de las intervenciones quirúrgicas",
            longDescription:
                "Demostración en vivo de sistemas quirúrgicos robóticos, con análisis de sus ventajas en precisión, tiempo de recuperación y resultados para diferentes tipos de procedimientos.",
            speakers: ["Dr. Carlos Yamamoto"],
            feedbacks: [],
            initialDate: DateTime(2025, 5, 5, 14, 0),
            finalDate: DateTime(2025, 5, 5, 16, 0),
            location: "Sala de Demostraciones",
            capacity: 150,
            availableSeats: 0,
            coverImageUrl: "assets/images/robotic_surgery.jpg",
            cardImageUrl: "assets/images/robotic_surgery_card.jpg",
            eventTrackName: "Congreso de Medicina Avanzada",
          ),
          Event(
            id: 403,
            name: "Neurociencia Cognitiva",
            description: "Descifrando los misterios del cerebro",
            longDescription:
                "Exploración de los últimos descubrimientos sobre cómo funciona la mente humana, desde procesos de memoria hasta toma de decisiones, con implicaciones para educación y salud mental.",
            speakers: ["Dra. Ana Sánchez", "Dr. James Wilson"],
            feedbacks: [
              FeedbackbyUser(
                  userId: "user403", stars: 5, comment: "Fascinante"),
            ],
            initialDate: DateTime(2025, 5, 6, 10, 0),
            finalDate: DateTime(2025, 5, 6, 12, 0),
            location: "Sala Neuro",
            capacity: 200,
            availableSeats: 28,
            coverImageUrl: "assets/images/neuroscience.jpg",
            cardImageUrl: "assets/images/neuroscience_card.jpg",
            eventTrackName: "Congreso de Medicina Avanzada",
          ),
        ],
      ),
      EventTrack(
        id: 5,
        name: "Festival de Cine Independiente",
        description: "Lo mejor del cine alternativo mundial",
        coverImageUrl: "assets/images/film_festival.jpg",
        overlayImageUrl: "assets/images/film_festival_overlay.jpg",
        events: [
          Event(
            id: 501,
            name: "Proyección: 'Voces del Silencio'",
            description: "Documental premiado internacionalmente",
            longDescription:
                "Historia íntima de una comunidad indígena luchando por preservar su cultura en el mundo moderno, seguida de Q&A con el director y protagonistas.",
            speakers: ["Director Alejandro Gómez", "Protagonista María López"],
            feedbacks: [
              FeedbackbyUser(
                  userId: "user501", stars: 5, comment: "Conmovedor y hermoso"),
              FeedbackbyUser(
                  userId: "user502",
                  stars: 4,
                  comment: "Fotografía impresionante"),
            ],
            initialDate: DateTime(2025, 6, 10, 18, 0),
            finalDate: DateTime(2025, 6, 10, 20, 30),
            location: "Cine Principal",
            capacity: 250,
            availableSeats: 12,
            coverImageUrl: "assets/images/voices_silence.jpg",
            cardImageUrl: "assets/images/voices_silence_card.jpg",
            eventTrackName: "Festival de Cine Independiente",
          ),
          Event(
            id: 502,
            name: "Taller de Guión Cinematográfico",
            description: "De la idea al guión final",
            longDescription:
                "Workshop interactivo donde desarrollarás un cortometraje desde cero, aprendiendo estructura narrativa, desarrollo de personajes y diálogos efectivos.",
            speakers: ["Guionista Patricia Ríos"],
            feedbacks: [],
            initialDate: DateTime(2025, 6, 11, 10, 0),
            finalDate: DateTime(2025, 6, 11, 13, 0),
            location: "Sala de Talleres",
            capacity: 30,
            availableSeats: 5,
            coverImageUrl: "assets/images/screenwriting.jpg",
            cardImageUrl: "assets/images/screenwriting_card.jpg",
            eventTrackName: "Festival de Cine Independiente",
          ),
        ],
      ),
      EventTrack(
        id: 6,
        name: "Convención de Videojuegos",
        description: "El universo gamer en un solo lugar",
        coverImageUrl: "assets/images/gaming_convention.jpg",
        overlayImageUrl: "assets/images/gaming_convention_overlay.jpg",
        events: [
          Event(
            id: 601,
            name: "Lanzamiento: 'Cyber Odyssey'",
            description: "Presentación exclusiva del nuevo RPG",
            longDescription:
                "Los desarrolladores revelarán gameplay inédito, mecánicas innovadoras y harán demostraciones en vivo de este esperado juego de mundo abierto con elementos cyberpunk.",
            speakers: [
              "Director Creativo Mark Johnson",
              "Productora Lisa Chen"
            ],
            feedbacks: [
              FeedbackbyUser(
                  userId: "user601", stars: 5, comment: "Se ve increíble!"),
              FeedbackbyUser(
                  userId: "user602",
                  stars: 5,
                  comment: "No puedo esperar para jugarlo"),
            ],
            initialDate: DateTime(2025, 7, 15, 16, 0),
            finalDate: DateTime(2025, 7, 15, 18, 0),
            location: "Main Stage",
            capacity: 500,
            availableSeats: 0,
            coverImageUrl: "assets/images/cyber_odyssey.jpg",
            cardImageUrl: "assets/images/cyber_odyssey_card.jpg",
            eventTrackName: "Convención de Videojuegos",
          ),
          Event(
            id: 602,
            name: "Competencia eSports",
            description: "Torneo de Valorant profesional",
            longDescription:
                "Enfrentamientos entre los mejores equipos regionales con premios en efectivo, comentado por expertos del mundo de los eSports y transmisión en vivo.",
            speakers: ["Comentarista Alex 'Raptor' Morales"],
            feedbacks: [],
            initialDate: DateTime(2025, 7, 16, 12, 0),
            finalDate: DateTime(2025, 7, 16, 20, 0),
            location: "Arena eSports",
            capacity: 1000,
            availableSeats: 150,
            coverImageUrl: "assets/images/esports.jpg",
            cardImageUrl: "assets/images/esports_card.jpg",
            eventTrackName: "Convención de Videojuegos",
          ),
        ],
      ),
      EventTrack(
        id: 7,
        name: "Foro de Emprendimiento",
        description: "Herramientas para hacer crecer tu negocio",
        coverImageUrl: "assets/images/entrepreneurship.jpg",
        overlayImageUrl: "assets/images/entrepreneurship_overlay.jpg",
        events: [
          Event(
            id: 701,
            name: "Financiamiento para Startups",
            description: "Cómo conseguir inversión para tu proyecto",
            longDescription:
                "Panel con inversionistas ángeles y venture capitalists explicando qué buscan en un emprendimiento, cómo preparar tu pitch y errores comunes a evitar.",
            speakers: ["Inversionista María Fernández", "VC Carlos Zhang"],
            feedbacks: [
              FeedbackbyUser(
                  userId: "user701", stars: 4, comment: "Consejos prácticos"),
              FeedbackbyUser(
                  userId: "user702",
                  stars: 5,
                  comment: "Perspectivas valiosas"),
            ],
            initialDate: DateTime(2025, 8, 5, 10, 0),
            finalDate: DateTime(2025, 8, 5, 12, 0),
            location: "Sala Principal",
            capacity: 200,
            availableSeats: 35,
            coverImageUrl: "assets/images/startup_funding.jpg",
            cardImageUrl: "assets/images/startup_funding_card.jpg",
            eventTrackName: "Foro de Emprendimiento",
          ),
        ],
      ),
      EventTrack(
        id: 8,
        name: "Expo Tecnología Educativa",
        description: "Innovación para transformar la educación",
        coverImageUrl: "assets/images/edtech.jpg",
        overlayImageUrl: "assets/images/edtech_overlay.jpg",
        events: [
          Event(
            id: 801,
            name: "Realidad Virtual en el Aula",
            description: "Experiencias inmersivas para educación",
            longDescription:
                "Demostración de cómo implementar VR para enseñar desde historia hasta biología, con casos reales de escuelas que han mejorado engagement y resultados.",
            speakers: ["Dra. Elena Castro", "Ing. David Kim"],
            feedbacks: [
              FeedbackbyUser(
                  userId: "user801",
                  stars: 5,
                  comment: "El futuro de la educación"),
            ],
            initialDate: DateTime(2025, 9, 12, 11, 0),
            finalDate: DateTime(2025, 9, 12, 13, 0),
            location: "Sala Innovación",
            capacity: 100,
            availableSeats: 0,
            coverImageUrl: "assets/images/vr_education.jpg",
            cardImageUrl: "assets/images/vr_education_card.jpg",
            eventTrackName: "Expo Tecnología Educativa",
          ),
          Event(
            id: 802,
            name: "Gamificación del Aprendizaje",
            description: "Cómo hacer que aprender sea divertido",
            longDescription:
                "Taller práctico donde diseñarás experiencias educativas basadas en juegos, aplicando principios de psicología y diseño de juegos para aumentar la motivación.",
            speakers: ["Diseñador Juan Pérez"],
            feedbacks: [],
            initialDate: DateTime(2025, 9, 12, 15, 0),
            finalDate: DateTime(2025, 9, 12, 17, 0),
            location: "Taller Creativo",
            capacity: 40,
            availableSeats: 12,
            coverImageUrl: "assets/images/gamification.jpg",
            cardImageUrl: "assets/images/gamification_card.jpg",
            eventTrackName: "Expo Tecnología Educativa",
          ),
        ],
      ),
      EventTrack(
        id: 20,
        name: "Exposición de Arte Contemporáneo",
        description: "Obras innovadoras de artistas emergentes",
        coverImageUrl: "assets/images/art_exhibition.jpg",
        overlayImageUrl: "assets/images/art_exhibition_overlay.jpg",
        events: [
          Event(
            id: 2001,
            name: "Charla con los Artistas",
            description: "Diálogo con los creadores de las obras",
            longDescription:
                "Los artistas participantes compartirán sus procesos creativos, inspiraciones y los desafíos de crear arte en el mundo contemporáneo, con espacio para preguntas del público.",
            speakers: ["Ana López", "Carlos Vega", "Marta Chen"],
            feedbacks: [
              FeedbackbyUser(
                  userId: "user2001", stars: 5, comment: "Muy inspirador"),
              FeedbackbyUser(
                  userId: "user2002",
                  stars: 4,
                  comment: "Interesantes perspectivas"),
              FeedbackbyUser(
                  userId: "user2003",
                  stars: 5,
                  comment: "Me encantó conocer a los artistas"),
              FeedbackbyUser(
                  userId: "user2004",
                  stars: 3,
                  comment: "Algunos artistas no eran muy comunicativos"),
            ],
            initialDate: DateTime(2025, 5, 10, 18, 0),
            finalDate: DateTime(2025, 5, 10, 20, 0),
            location: "Sala de Conferencias",
            capacity: 100,
            availableSeats: 25,
            coverImageUrl: "assets/images/artist_talk.jpg",
            cardImageUrl: "assets/images/artist_talk_card.jpg",
            eventTrackName: "Exposición de Arte Contemporáneo",
          ),
          Event(
            id: 2002,
            name: "Taller de Arte Digital",
            description: "Introducción al arte con herramientas digitales",
            longDescription:
                "Sesión práctica donde aprenderás los fundamentos del arte digital, desde el uso de tabletas gráficas hasta software especializado, con ejercicios guiados por artistas profesionales.",
            speakers: ["Artista Digital Juan Morales"],
            feedbacks: [
              FeedbackbyUser(
                  userId: "user2005",
                  stars: 5,
                  comment: "Excelente introducción"),
            ],
            initialDate: DateTime(2025, 5, 11, 10, 0),
            finalDate: DateTime(2025, 5, 11, 13, 0),
            location: "Sala Multimedia",
            capacity: 15,
            availableSeats: 0,
            coverImageUrl: "assets/images/digital_art.jpg",
            cardImageUrl: "assets/images/digital_art_card.jpg",
            eventTrackName: "Exposición de Arte Contemporáneo",
          ),
          Event(
            id: 2003,
            name: "Performance: Fronteras del Arte",
            description: "Espectáculo de arte en vivo",
            longDescription:
                "Experiencia inmersiva donde los artistas crearán obras en tiempo real, combinando pintura, movimiento y tecnología interactiva, desafiando los límites tradicionales del arte.",
            speakers: ["Colectivo Artístico Liminal"],
            feedbacks: [],
            initialDate: DateTime(2025, 5, 11, 19, 0),
            finalDate: DateTime(2025, 5, 11, 21, 0),
            location: "Plaza Central",
            capacity: 200,
            availableSeats: 80,
            coverImageUrl: "assets/images/art_performance.jpg",
            cardImageUrl: "assets/images/art_performance_card.jpg",
            eventTrackName: "Exposición de Arte Contemporáneo",
          ),
          Event(
            id: 2004,
            name: "Arte y Activismo",
            description: "Cómo el arte puede cambiar la sociedad",
            longDescription:
                "Panel de discusión sobre el papel del arte en los movimientos sociales contemporáneos, con ejemplos de proyectos artísticos que han generado impacto real en sus comunidades.",
            speakers: [
              "Activista Marta Sánchez",
              "Artista Luis Rojas",
              "Curadora Ana Kim"
            ],
            feedbacks: [
              FeedbackbyUser(
                  userId: "user2006", stars: 5, comment: "Muy motivador"),
              FeedbackbyUser(
                  userId: "user2007",
                  stars: 4,
                  comment: "Buen balance de opiniones"),
            ],
            initialDate: DateTime(2025, 5, 12, 16, 0),
            finalDate: DateTime(2025, 5, 12, 18, 0),
            location: "Auditorio de Arte",
            capacity: 120,
            availableSeats: 35,
            coverImageUrl: "assets/images/art_activism.jpg",
            cardImageUrl: "assets/images/art_activism_card.jpg",
            eventTrackName: "Exposición de Arte Contemporáneo",
          ),
          Event(
            id: 2005,
            name: "Técnicas Mixtas Innovadoras",
            description: "Explorando nuevos materiales en el arte",
            longDescription:
                "Demostración en vivo de cómo combinar materiales tradicionales con elementos inusuales para crear texturas y efectos visuales sorprendentes en obras de arte contemporáneo.",
            speakers: ["Artista Experimental Clara Núñez"],
            feedbacks: [
              FeedbackbyUser(
                  userId: "user2008",
                  stars: 4,
                  comment: "Técnicas muy creativas"),
              FeedbackbyUser(
                  userId: "user2009",
                  stars: 5,
                  comment: "La artista es muy talentosa"),
              FeedbackbyUser(
                  userId: "user2010",
                  stars: 3,
                  comment: "Demasiado abstracto para mi gusto"),
            ],
            initialDate: DateTime(2025, 5, 13, 11, 0),
            finalDate: DateTime(2025, 5, 13, 13, 0),
            location: "Taller de Arte",
            capacity: 30,
            availableSeats: 8,
            coverImageUrl: "assets/images/mixed_media.jpg",
            cardImageUrl: "assets/images/mixed_media_card.jpg",
            eventTrackName: "Exposición de Arte Contemporáneo",
          ),
        ],
      ),
    ];

    return Master(eventTracks: eventTracks);
  }
}
