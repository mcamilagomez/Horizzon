import 'package:flutter/material.dart';

class EventController extends ChangeNotifier {
  final Map<int, bool> _suscripciones = {};

  bool isSuscrito(int eventId) => _suscripciones[eventId] ?? false;

  void toggleSuscripcion(int eventId) {
    _suscripciones[eventId] = !isSuscrito(eventId);
    notifyListeners();
  }
}
