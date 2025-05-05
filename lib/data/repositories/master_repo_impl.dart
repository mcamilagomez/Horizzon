import 'package:horizzon/data/datasources/local/master_local.dart';
import 'package:horizzon/data/datasources/remote/remote_datasource.dart';
import 'package:horizzon/domain/entities/master.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/domain/repositories/master_repository.dart';
import 'package:horizzon/utils/image_utils.dart'; // Aquí guardamos nuestra utilidad

class MasterRepositoryImpl implements MasterRepository {
  final RemoteDataSource _remoteDataSource;
  final MasterLocalDataSource _localDataSource;

  MasterRepositoryImpl({
    required RemoteDataSource remoteDataSource,
    required MasterLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  MasterLocalDataSource get local => _localDataSource;

  @override
  Future<void> fetchAndCacheMasterData() async {
    final master = await _remoteDataSource.getFullData();

    // Procesar imágenes antes de guardar en Hive
    for (final track in master.eventTracks) {
      final newCoverPath = await saveBase64ImageToFile(
        track.coverImageUrl,
        'track-${track.id}-cover.png',
      );
      final newOverlayPath = await saveBase64ImageToFile(
        track.overlayImageUrl,
        'track-${track.id}-overlay.png',
      );

      // ⚠️ hack temporal para sobrescribir atributos finales (porque son final)
      (track as dynamic).coverImageUrl = newCoverPath ?? '';
      (track as dynamic).overlayImageUrl = newOverlayPath ?? '';

      for (final event in track.events) {
        final newCardPath = await saveBase64ImageToFile(
          event.cardImageUrl,
          'event-${event.id}-card.png',
        );
        final newCoverPath = await saveBase64ImageToFile(
          event.coverImageUrl,
          'event-${event.id}-cover.png',
        );

        (event as dynamic).cardImageUrl = newCardPath ?? '';
        (event as dynamic).coverImageUrl = newCoverPath ?? '';
      }
    }

    await _localDataSource.saveMaster(master);
  }

  @override
  Future<Master> getMasterFromCache() async {
    final cachedMaster = await _localDataSource.getMaster();
    if (cachedMaster == null) {
      throw Exception("No hay datos de master en cache");
    }
    return cachedMaster;
  }

  @override
  Future<void> addFeedback({
    required int eventId,
    required FeedbackbyUser feedback,
  }) async {
    await _remoteDataSource.addFeedback(feedback, eventId);
  }

  @override
  Future<int> incrementAvailableSeats(int eventId) async {
    return await _remoteDataSource.incrementAvailableSeats(eventId);
  }

  @override
  Future<int> decrementAvailableSeats(int eventId) async {
    return await _remoteDataSource.decrementAvailableSeats(eventId);
  }
}
