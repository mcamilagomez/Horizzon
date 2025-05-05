//Acá se guarda los recomendados como objeto o como lista
import 'package:hive/hive.dart';
import 'package:horizzon/domain/entities/recommended.dart';

part 'recommended_model.g.dart';

@HiveType(typeId: 5)
class RecommendedModel extends HiveObject {
  @HiveField(0)
  final int id;

  RecommendedModel({required this.id});

  Recommended toEntity() => Recommended(id: id);

  factory RecommendedModel.fromEntity(Recommended entity) =>
      RecommendedModel(id: entity.id);
}
