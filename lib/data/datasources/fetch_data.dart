import 'package:horizzon/domain/repositories/fetch_repo.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/entities/user.dart';

class ManageData implements FetchRepo {
  // 1. Función para suscribir un usuario a un evento
  @override
  Future<void> subscribe(Event event, User user) async {
    try {
      // Verificar si el evento ya está en la lista del usuario
      if (!user.myEvents.any((e) => e.id == event.id)) {
        user.myEvents.add(event);
        // Aquí podrías añadir lógica para actualizar availableSeats si es necesario
      }
    } catch (e) {
      throw Exception('Error al suscribir al evento: $e');
    }
  }

  // 2. Función para cancelar la suscripción de un usuario a un evento
  @override
  Future<void> unsubscribe(Event event, User user) async {
    try {
      user.myEvents.removeWhere((e) => e.id == event.id);
      // Aquí podrías añadir lógica para actualizar availableSeats si es necesario
    } catch (e) {
      throw Exception('Error al cancelar suscripción: $e');
    }
  }

  // 3. Función para añadir feedback a un evento
  @override
  Future<void> addFeedback(
      String comment, Event event, int stars, String hash) async {
    try {
      // Validar que las estrellas estén en un rango válido (ej. 1-5)
      if (stars < 1 || stars > 5) {
        throw Exception('El rating debe estar entre 1 y 5 estrellas');
      }

      // Crear el nuevo feedback
      final newFeedback = Feedback(
        userId: hash,
        stars: stars,
        comment: comment,
      );

      // Añadir el feedback al evento
      event.feedbacks.add(newFeedback);
    } catch (e) {
      throw Exception('Error al añadir feedback: $e');
    }
  }
}
