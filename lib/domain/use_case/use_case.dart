//Acá coloco las funciones finales, es decir esto es lo que va a hablar con la UI
// puedo consumir data/repositories y hacer otras funciones por acá
// lib/domain/use_case/use_case.dart

//Esto es lo viejo de use case
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/entities/user.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:horizzon/domain/entities/master.dart';
import 'package:horizzon/domain/entities/user.dart';
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
    final isFirstRun = prefs.getBool('isFirstRun') ?? true;

    if (isFirstRun) {
      // 🔁 Fetch y guardar master
      await masterRepository.fetchAndCacheMasterData();
      _cachedMaster = await masterRepository.getMasterFromCache();

      // 🔐 Crear y guardar usuario
      _cachedUser = await userRepository.createUserWithHash();

      // 🚩 Marcar que ya no es la primera vez
      await prefs.setBool('isFirstRun', false);
    } else {
      // 📦 Cargar desde Hive
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
  /// Determina el estado temporal de un evento
  static String whenIs(DateTime initialDate, DateTime finalDate) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final eventStartDay =
        DateTime(initialDate.year, initialDate.month, initialDate.day);

    // Casos especiales que mantienen texto descriptivo
    if (now.isAfter(initialDate) && now.isBefore(finalDate)) return "HOY";

    final difference = eventStartDay.difference(today).inDays;
    if (difference == 0) return "HOY";
    if (difference == 1) return "MAÑANA";

    // Formato de fecha para todos los demás casos (pasados o futuros)
    final monthNames = [
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

  /// Formatea la fecha en formato dd/mm/yyyy
  static String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  /// Verifica si un evento está en la lista de suscripciones
  static bool itsSubscribe(Event event, List<Event> subscribedEvents) {
    return subscribedEvents.any((e) => e.id == event.id);
  }

  /// Suscribe a un evento
  static List<Event> subscribe(Event event, List<Event> subscribedEvents) {
    event.availableSeats = event.availableSeats - 1;
    if (!itsSubscribe(event, subscribedEvents)) {
      return [...subscribedEvents, event];
    }
    return subscribedEvents;
  }

  /// Desuscribe de un evento
  static List<Event> unsubscribe(Event event, List<Event> subscribedEvents) {
    event.availableSeats = event.availableSeats + 1;
    return subscribedEvents.where((e) => e.id != event.id).toList();
  }

  static void addFeedback(String comment, Event event, int stars, String hash) {
    // Validar que las estrellas estén en un rango válido (ej. 1-5)
    if (stars < 1 || stars > 5) {
      throw Exception('El rating debe estar entre 1 y 5 estrellas');
    }

    // Crear el nuevo feedback
    final newFeedback = FeedbackbyUser(
      userId: hash,
      stars: stars,
      comment: comment,
    );

    // Insertar el feedback al principio de la lista
    event.feedbacks.insert(0, newFeedback);
  }

  /// Verifica si el evento ya terminó
  static bool isOver(DateTime finalDate) {
    return DateTime.now().isAfter(finalDate);
  }

  /// Verifica si el evento está disponible para suscripción
  static bool isAvailable(Event event, User user) {
    final isNotSubscribed = !user.myEvents.any((e) => e.id == event.id);
    final hasAvailableSeats = event.availableSeats > 0;
    return isNotSubscribed && hasAvailableSeats;
  }
}
