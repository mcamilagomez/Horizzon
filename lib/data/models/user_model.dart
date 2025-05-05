//Aca tengo que poner que lo de la bd de hive meterlo en user el objeto
import 'package:hive/hive.dart';
import 'event_model.dart';
import 'package:horizzon/domain/entities/user.dart';

part 'user_model.g.dart';

@HiveType(typeId: 4)
class UserModel extends HiveObject {
  @HiveField(0)
  final String hash;

  @HiveField(1)
  final List<EventModel> myEvents;

  UserModel({required this.hash, required this.myEvents});

  User toEntity() => User(
        hash: hash,
        myEvents: myEvents.map((e) => e.toEntity()).toList(),
      );

  factory UserModel.fromEntity(User entity) => UserModel(
        hash: entity.hash,
        myEvents: entity.myEvents.map((e) => EventModel.fromEntity(e)).toList(),
      );
}
