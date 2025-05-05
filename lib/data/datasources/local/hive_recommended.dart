import 'package:hive/hive.dart';
import 'package:horizzon/data/models/recommended_model.dart';
import 'package:horizzon/domain/entities/recommended.dart';
import 'recommended_local.dart';

class HiveRecommendedLocalDataSource implements RecommendedLocalDataSource {
  final Box<RecommendedModel> recommendedBox;

  HiveRecommendedLocalDataSource(this.recommendedBox);

  @override
  Future<List<Recommended>> getRecommended() async {
    return recommendedBox.values.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> saveRecommended(List<Recommended> recommendedList) async {
    await recommendedBox.clear(); // opción simple por ahora
    for (var i = 0; i < recommendedList.length; i++) {
      await recommendedBox.put(
          i, RecommendedModel.fromEntity(recommendedList[i]));
    }
  }
}
