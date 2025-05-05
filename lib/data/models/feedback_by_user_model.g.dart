// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_by_user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FeedbackByUserModelAdapter extends TypeAdapter<FeedbackByUserModel> {
  @override
  final int typeId = 0;

  @override
  FeedbackByUserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FeedbackByUserModel(
      userId: fields[0] as String,
      stars: fields[1] as int,
      comment: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FeedbackByUserModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.stars)
      ..writeByte(2)
      ..write(obj.comment);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeedbackByUserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
