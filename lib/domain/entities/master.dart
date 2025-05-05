//Entidad master
import 'package:horizzon/domain/entities/event_track.dart';

class Master {
  final List<EventTrack> eventTracks;

  Master({required this.eventTracks});

  factory Master.fromJson(List<dynamic> jsonList) {
    return Master(
      eventTracks:
          jsonList.map((trackJson) => EventTrack.fromJson(trackJson)).toList(),
    );
  }
}
