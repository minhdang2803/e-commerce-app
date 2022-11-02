// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goods_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GoodsAdapter extends TypeAdapter<Goods> {
  @override
  final int typeId = 0;

  @override
  Goods read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Goods(
      description: fields[0] as String,
      id: fields[1] as int,
      imgUrl: fields[2] as String,
      productClass: fields[3] as String,
      productLine: fields[4] as String,
      productName: fields[5] as String,
      promotion: fields[6] as String,
      rating: fields[7] as int,
      salePrice: fields[8] as String?,
      truePrice: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Goods obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.description)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.imgUrl)
      ..writeByte(3)
      ..write(obj.productClass)
      ..writeByte(4)
      ..write(obj.productLine)
      ..writeByte(5)
      ..write(obj.productName)
      ..writeByte(6)
      ..write(obj.promotion)
      ..writeByte(7)
      ..write(obj.rating)
      ..writeByte(8)
      ..write(obj.salePrice)
      ..writeByte(9)
      ..write(obj.truePrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoodsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
