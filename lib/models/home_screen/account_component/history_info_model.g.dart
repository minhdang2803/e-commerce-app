// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_info_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HistoryInfoModelAdapter extends TypeAdapter<HistoryInfoModel> {
  @override
  final int typeId = 2;

  @override
  HistoryInfoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HistoryInfoModel(
      time: fields[0] as String,
      historyCardModel: (fields[1] as List).cast<HistoryCardModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, HistoryInfoModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.time)
      ..writeByte(1)
      ..write(obj.historyCardModel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoryInfoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
