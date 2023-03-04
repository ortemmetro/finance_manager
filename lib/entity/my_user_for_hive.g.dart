// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_user_for_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyUserForHiveAdapter extends TypeAdapter<MyUserForHive> {
  @override
  final int typeId = 4;

  @override
  MyUserForHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyUserForHive(
      id: fields[0] as String,
      firstName: fields[1] as String,
      lastName: fields[2] as String,
      age: fields[3] as int,
      expenses: (fields[4] as HiveList?)?.castHiveList(),
      ownCategories: (fields[5] as HiveList?)?.castHiveList(),
    );
  }

  @override
  void write(BinaryWriter writer, MyUserForHive obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.age)
      ..writeByte(4)
      ..write(obj.expenses)
      ..writeByte(5)
      ..write(obj.ownCategories);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyUserForHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
