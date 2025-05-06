// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommended_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecommendedModelAdapter extends TypeAdapter<RecommendedModel> {
  @override
  final int typeId = 5;

  @override
  RecommendedModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecommendedModel(
      id: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, RecommendedModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecommendedModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
