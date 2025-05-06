// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'master_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MasterModelAdapter extends TypeAdapter<MasterModel> {
  @override
  final int typeId = 3;

  @override
  MasterModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MasterModel(
      eventTracks: (fields[0] as List).cast<EventTrackModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, MasterModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.eventTracks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MasterModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
