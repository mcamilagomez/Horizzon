//Acá tomo el contrato de domain/repositories y con las funciones de datasources y models hago lo que quiero
// Guardar recomendados
// fetch a recomendados
import 'package:horizzon/data/datasources/local/recommended_local.dart';
import 'package:horizzon/data/datasources/remote/remote_datasource.dart';
import 'package:horizzon/domain/entities/recommended.dart';
import 'package:horizzon/domain/repositories/recomended_repository.dart';

class RecommendedRepositoryImpl implements RecommendedRepository {
  final RemoteDataSource remoteDataSource;
  final RecommendedLocalDataSource localDataSource;

  RecommendedRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  /// 🔁 Obtener desde backend y guardar en Hive
  @override
  Future<void> fetchAndCacheRecommended() async {
    final recommendedList = await remoteDataSource.getRecommended();
    await localDataSource.saveRecommended(recommendedList);
  }

  /// 📦 Obtener desde Hive
  @override
  Future<List<Recommended>> getRecommendedFromCache() async {
    return await localDataSource.getRecommended();
  }
}
