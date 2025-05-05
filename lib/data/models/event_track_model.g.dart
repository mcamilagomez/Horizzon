// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_track_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventTrackModelAdapter extends TypeAdapter<EventTrackModel> {
  @override
  final int typeId = 2;

  @override
  EventTrackModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EventTrackModel(
      id: fields[0] as int,
      name: fields[1] as String,
      description: fields[2] as String,
      coverImageUrl: fields[3] as String,
      overlayImageUrl: fields[4] as String,
      events: (fields[5] as List).cast<EventModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, EventTrackModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.coverImageUrl)
      ..writeByte(4)
      ..write(obj.overlayImageUrl)
      ..writeByte(5)
      ..write(obj.events);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventTrackModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
