// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StoreHiveModelAdapter extends TypeAdapter<StoreHiveModel> {
  @override
  final int typeId = 2;

  @override
  StoreHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StoreHiveModel(
      bookId: fields[0] as String,
      title: fields[1] as String,
      coverURL: fields[2] as String,
      author: fields[3] as String,
      verifiedStatus: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, StoreHiveModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.bookId)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.coverURL)
      ..writeByte(3)
      ..write(obj.author)
      ..writeByte(4)
      ..write(obj.verifiedStatus);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoreHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
