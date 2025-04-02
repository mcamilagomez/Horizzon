import 'package:horizzon/domain/entities/event.dart';

class Eventsapp {
  List<Event> events;

  // 1. Constructor privado
  Eventsapp._internal({
    required this.events,
  });

  // 2. Instancia estática privada
  static final Eventsapp _instance = Eventsapp._internal(
    events: [],
  );

  // 3. Getter público para acceder a la instancia
  static Eventsapp get instance => _instance;

  // Métodos adicionales (opcional)
  void setEvents(List<Event> newEvents) {
    events = newEvents;
  }

  void addEvent(Event event) {
    events.add(event);
  }

  void clearEvents() {
    events.clear();
  }
}
