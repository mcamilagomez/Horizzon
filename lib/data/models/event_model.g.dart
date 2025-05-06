// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventModelAdapter extends TypeAdapter<EventModel> {
  @override
  final int typeId = 1;

  @override
  EventModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EventModel(
      id: fields[0] as int,
      name: fields[1] as String,
      description: fields[2] as String,
      longDescription: fields[3] as String,
      speakers: (fields[4] as List).cast<String>(),
      feedbacks: (fields[5] as List).cast<FeedbackByUserModel>(),
      initialDate: fields[6] as DateTime,
      finalDate: fields[7] as DateTime,
      location: fields[8] as String,
      capacity: fields[9] as int,
      availableSeats: fields[10] as int,
      coverImageUrl: fields[11] as String,
      cardImageUrl: fields[12] as String,
      eventTrackName: fields[13] as String,
      eventTrackId: fields[14] as int,
    );
  }

  @override
  void write(BinaryWriter writer, EventModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.longDescription)
      ..writeByte(4)
      ..write(obj.speakers)
      ..writeByte(5)
      ..write(obj.feedbacks)
      ..writeByte(6)
      ..write(obj.initialDate)
      ..writeByte(7)
      ..write(obj.finalDate)
      ..writeByte(8)
      ..write(obj.location)
      ..writeByte(9)
      ..write(obj.capacity)
      ..writeByte(10)
      ..write(obj.availableSeats)
      ..writeByte(11)
      ..write(obj.coverImageUrl)
      ..writeByte(12)
      ..write(obj.cardImageUrl)
      ..writeByte(13)
      ..write(obj.eventTrackName)
      ..writeByte(14)
      ..write(obj.eventTrackId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
