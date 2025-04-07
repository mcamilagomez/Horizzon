import 'package:flutter/material.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/entities/user.dart';
import 'package:horizzon/domain/use_case/use_case.dart';

class EventController extends ChangeNotifier {
  final User user;
  final Map<int, bool> _suscripciones = {};

  EventController({required this.user});

  bool isSuscrito(int eventId) => _suscripciones[eventId] ?? false;

  void toggleSuscripcion(Event event) {
    final eventId = event.id;
    final currentlySubscribed = isSuscrito(eventId);

    // Actualizar lista de eventos del usuario
    user.myEvents = currentlySubscribed
        ? EventUseCases.unsubscribe(event, user.myEvents)
        : EventUseCases.subscribe(event, user.myEvents);

    // Actualizar estado interno
    _suscripciones[eventId] = !currentlySubscribed;
    notifyListeners();
  }

  // Verificar suscripción considerando ambos sistemas
  bool checkSubscriptionStatus(Event event) {
    return isSuscrito(event.id) ||
        EventUseCases.itsSubscribe(event, user.myEvents);
  }
}
