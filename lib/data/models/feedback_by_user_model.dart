import 'package:hive/hive.dart';
import 'package:horizzon/domain/entities/event.dart';

part 'feedback_by_user_model.g.dart';

@HiveType(typeId: 0)
class FeedbackByUserModel extends HiveObject {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final int stars;

  @HiveField(2)
  final String comment;

  FeedbackByUserModel({
    required this.userId,
    required this.stars,
    required this.comment,
  });

  FeedbackbyUser toEntity() => FeedbackbyUser(
        userId: userId,
        stars: stars,
        comment: comment,
      );

  factory FeedbackByUserModel.fromEntity(FeedbackbyUser entity) =>
      FeedbackByUserModel(
        userId: entity.userId,
        stars: entity.stars,
        comment: entity.comment,
      );
}
