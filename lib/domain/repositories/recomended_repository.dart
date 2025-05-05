//Acá hago el contrato de lo que hará recomendados
// Guardar la info
import 'package:horizzon/domain/entities/recommended.dart';

abstract class RecommendedRepository {
  /// Fetch desde API y guarda en Hive
  Future<void> fetchAndCacheRecommended();

  /// Obtener lista de recomendados desde Hive
  Future<List<Recommended>> getRecommendedFromCache();
}
