// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flutix_transaction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FlutixTransactionAdapter extends TypeAdapter<FlutixTransaction> {
  @override
  final int typeId = 0;

  @override
  FlutixTransaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FlutixTransaction(
      userID: fields[0] as String,
      title: fields[1] as String,
      subtitle: fields[2] as String,
      amount: fields[3] as int,
      time: fields[4] as DateTime,
      picture: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FlutixTransaction obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.userID)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.subtitle)
      ..writeByte(3)
      ..write(obj.amount)
      ..writeByte(4)
      ..write(obj.time)
      ..writeByte(5)
      ..write(obj.picture);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FlutixTransactionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
