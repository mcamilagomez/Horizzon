// lib/domain/use_case/use_case.dart
import 'package:horizzon/domain/entities/event.dart';

class EventUseCases {
  /// Determina el estado temporal de un evento
  static String whenIs(DateTime initialDate, DateTime finalDate) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final eventStartDay =
        DateTime(initialDate.year, initialDate.month, initialDate.day);

    if (now.isAfter(finalDate)) return "PASADO";
    if (now.isAfter(initialDate) && now.isBefore(finalDate)) return "HOY";

    final difference = eventStartDay.difference(today).inDays;
    if (difference == 0) return "HOY";
    if (difference == 1) return "MAÑANA";
    if (difference > 1) return "PROXIMAMENTE";
    return "PASADO";
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
}
