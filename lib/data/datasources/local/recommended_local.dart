//Acá se mete la lista de recomendados en hive
import 'package:horizzon/domain/entities/recommended.dart';

abstract class RecommendedLocalDataSource {
  Future<List<Recommended>> getRecommended();
  Future<void> saveRecommended(List<Recommended> recommendedList);
}
