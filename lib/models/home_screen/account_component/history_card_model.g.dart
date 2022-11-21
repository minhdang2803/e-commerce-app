// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_card_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HistoryCardModelAdapter extends TypeAdapter<HistoryCardModel> {
  @override
  final int typeId = 3;

  @override
  HistoryCardModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HistoryCardModel(
      price: fields[0] as String,
      title: fields[1] as String,
      status: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HistoryCardModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.price)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoryCardModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
