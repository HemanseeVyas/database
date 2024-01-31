// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'curd_op2.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class datasAdapter extends TypeAdapter<datas> {
  @override
  final int typeId = 0;

  @override
  datas read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return datas(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, datas obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.contact);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is datasAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
