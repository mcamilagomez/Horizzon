//Acá hago el contrato de lo que hará master
// Guardar la info
// Hacer un feedback
// Asistir a un evento
// Quitar asistencia a un evento
import 'package:horizzon/domain/entities/master.dart';
import 'package:horizzon/domain/entities/event.dart';

abstract class MasterRepository {
  /// Fetch desde API y guarda en Hive
  Future<void> fetchAndCacheMasterData();

  /// Obtener desde Hive el objeto Master
  Future<Master> getMasterFromCache();

  /// Agrega un feedback a un evento
  Future<void> addFeedback({
    required int eventId,
    required FeedbackbyUser feedback,
  });

  /// Incrementa asientos disponibles
  Future<int> incrementAvailableSeats(int eventId);

  /// Disminuye asientos disponibles
  Future<int> decrementAvailableSeats(int eventId);
}
