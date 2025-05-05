import 'package:horizzon/data/datasources/local/master_local.dart';
import 'package:horizzon/data/datasources/remote/remote_datasource.dart';
import 'package:horizzon/domain/entities/event.dart';

import 'package:horizzon/domain/entities/master.dart';
import 'package:horizzon/domain/repositories/master_repository.dart';

class MasterRepositoryImpl implements MasterRepository {
  final RemoteDataSource _remoteDataSource;
  final MasterLocalDataSource _localDataSource;

  MasterRepositoryImpl({
    required RemoteDataSource remoteDataSource,
    required MasterLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  /// Exponer el local datasource si llegas a necesitarlo (opcional)
  MasterLocalDataSource get local => _localDataSource;

  /// 🔁 Obtener de la API y guardar en Hive
  @override
  Future<void> fetchAndCacheMasterData() async {
    final master = await _remoteDataSource.getFullData();
    await _localDataSource.saveMaster(master);
  }

  /// 📦 Obtener Master desde Hive
  @override
  Future<Master> getMasterFromCache() async {
    final cachedMaster = await _localDataSource.getMaster();
    if (cachedMaster == null) {
      throw Exception("No hay datos de master en cache");
    }
    return cachedMaster;
  }

  /// 💬 Agregar feedback a un evento
  @override
  Future<void> addFeedback({
    required int eventId,
    required FeedbackbyUser feedback,
  }) async {
    await _remoteDataSource.addFeedback(feedback, eventId);
  }

  /// ➕ Incrementar asientos
  @override
  Future<int> incrementAvailableSeats(int eventId) async {
    return await _remoteDataSource.incrementAvailableSeats(eventId);
  }

  /// ➖ Reducir asientos
  @override
  Future<int> decrementAvailableSeats(int eventId) async {
    return await _remoteDataSource.decrementAvailableSeats(eventId);
  }
}
