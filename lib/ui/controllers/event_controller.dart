import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/entities/user.dart';
import 'package:horizzon/domain/use_case/use_case.dart';
import 'package:horizzon/domain/repositories/user_repository.dart';
import 'package:horizzon/domain/repositories/master_repository.dart';

class EventController extends ChangeNotifier {
  final User user;
  final UserRepository userRepo;
  final MasterRepository masterRepo;

  final Map<int, bool> _suscripciones = {};

  EventController({
    required this.user,
    required this.userRepo,
    required this.masterRepo,
  });

  /// Verifica si el usuario está suscrito a un evento
  bool isSuscrito(int eventId) => _suscripciones[eventId] ?? false;

  /// Verifica el estado real de suscripción
  bool checkSubscriptionStatus(Event event) {
    return isSuscrito(event.id) ||
        EventUseCases.itsSubscribe(event, user.myEvents);
  }

  /// Alterna la suscripción/desuscripción a un evento
  Future<void> toggleSuscripcion(Event event, BuildContext context) async {
    final connectivity = await Connectivity().checkConnectivity();
    final hasConnection = connectivity != ConnectivityResult.none;

    if (!hasConnection) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Sin conexión"),
            content: const Text(
                "Necesitas conexión a internet para suscribirte o desuscribirte."),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      }
      return;
    }

    final currentlySubscribed = isSuscrito(event.id);

    try {
      if (currentlySubscribed) {
        // DESUSCRIBIRSE
        final updatedUser =
            await userRepo.removeEventFromUser(user: user, event: event);
        final newSeats = await masterRepo.incrementAvailableSeats(event.id);
        event.availableSeats = newSeats;
        user.myEvents = updatedUser.myEvents;
        _suscripciones[event.id] = false;
      } else {
        // SUSCRIBIRSE
        final updatedUser =
            await userRepo.addEventToUser(user: user, event: event);
        final newSeats = await masterRepo.decrementAvailableSeats(event.id);
        event.availableSeats = newSeats;
        user.myEvents = updatedUser.myEvents;
        _suscripciones[event.id] = true;
      }
      notifyListeners();
    } catch (e) {
      print("Error al cambiar suscripción: $e");
    }
  }
}
