//Acá va el coger lo de la base de datos y meterlo en el objeto master
import 'package:hive/hive.dart';
import 'event_track_model.dart';
import 'package:horizzon/domain/entities/master.dart';

part 'master_model.g.dart';

@HiveType(typeId: 3)
class MasterModel extends HiveObject {
  @HiveField(0)
  final List<EventTrackModel> eventTracks;

  MasterModel({required this.eventTracks});

  Master toEntity() => Master(
        eventTracks: eventTracks.map((e) => e.toEntity()).toList(),
      );

  factory MasterModel.fromEntity(Master entity) => MasterModel(
        eventTracks: entity.eventTracks
            .map((e) => EventTrackModel.fromEntity(e))
            .toList(),
      );
}
