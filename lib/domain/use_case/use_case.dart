import 'package:shared_preferences/shared_preferences.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/entities/user.dart';
import 'package:horizzon/domain/entities/master.dart';
import 'package:horizzon/domain/repositories/master_repository.dart';
import 'package:horizzon/domain/repositories/user_repository.dart';

class AppInitializationUseCase {
  final MasterRepository masterRepository;
  final UserRepository userRepository;

  Master? _cachedMaster;
  User? _cachedUser;

  AppInitializationUseCase({
    required this.masterRepository,
    required this.userRepository,
  });

  Future<void> initializeApp() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstRun = true;

    if (isFirstRun) {
      // 🔁 Obtener datos iniciales
      await masterRepository.fetchAndCacheMasterData();
      _cachedMaster = await masterRepository.getMasterFromCache();

      _cachedUser = await userRepository.createUserWithHash();
      await prefs.setBool('isFirstRun', false);
    } else {
      // 📦 Cargar desde cache
      _cachedMaster = await masterRepository.getMasterFromCache();
      _cachedUser = await userRepository.getUserFromCache();
    }

    if (_cachedUser == null || _cachedMaster == null) {
      throw Exception("Error inicializando datos locales.");
    }
  }

  Master get master => _cachedMaster!;
  User get user => _cachedUser!;
}

class EventUseCases {
  /// Devuelve una etiqueta de tiempo para el evento: HOY, MAÑANA o FECHA
  static String whenIs(DateTime initialDate, DateTime finalDate) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final eventStartDay =
        DateTime(initialDate.year, initialDate.month, initialDate.day);

    if (now.isAfter(initialDate) && now.isBefore(finalDate)) return "HOY";

    final difference = eventStartDay.difference(today).inDays;
    if (difference == 0) return "HOY";
    if (difference == 1) return "MAÑANA";

    const monthNames = [
      "ENE",
      "FEB",
      "MAR",
      "ABR",
      "MAY",
      "JUN",
      "JUL",
      "AGS",
      "SEP",
      "OCT",
      "NOV",
      "DIC"
    ];

    return "${initialDate.day} ${monthNames[initialDate.month - 1]}";
  }

  /// Formatea fecha dd/mm/yyyy
  static String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  /// Verifica si un evento está en la lista de eventos del usuario
  static bool itsSubscribe(Event event, List<Event> subscribedEvents) {
    return subscribedEvents.any((e) => e.id == event.id);
  }

  /// Verifica si el evento ya terminó
  static bool isOver(DateTime finalDate) {
    return DateTime.now().isAfter(finalDate);
  }

  /// Verifica si está disponible para suscripción
  static bool isAvailable(Event event, User user) {
    final isSubscribed = itsSubscribe(event, user.myEvents);
    return event.availableSeats > 0 && !isSubscribed;
  }

  /// (DEPRECATED) Suscribe a un evento localmente (no usar)
  @Deprecated('Usar EventController + repositorio para modificar eventos')
  static List<Event> subscribe(Event event, List<Event> subscribedEvents) {
    if (!itsSubscribe(event, subscribedEvents)) {
      return [...subscribedEvents, event];
    }
    return subscribedEvents;
  }

  /// (DEPRECATED) Desuscribe de un evento localmente (no usar)
  @Deprecated('Usar EventController + repositorio para modificar eventos')
  static List<Event> unsubscribe(Event event, List<Event> subscribedEvents) {
    return subscribedEvents.where((e) => e.id != event.id).toList();
  }

  /// Inserta un nuevo feedback en la lista local del evento
  /// Nota: El envío al servidor debe hacerse desde el repositorio o controlador
  static void addFeedback(String comment, Event event, int stars, String hash) {
    if (stars < 1 || stars > 5) {
      throw Exception('El rating debe estar entre 1 y 5 estrellas');
    }

    final newFeedback = FeedbackbyUser(
      userId: hash,
      stars: stars,
      comment: comment,
    );

    event.feedbacks.insert(0, newFeedback);
  }
}
