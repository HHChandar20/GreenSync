// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlantAdapter extends TypeAdapter<Plant> {
  @override
  final int typeId = 0;

  @override
  Plant read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Plant(
      name: fields[0] as String,
      type: fields[1] as String,
      description: fields[2] as String,
      count: fields[3] as int,
      plantedDate: fields[4] as DateTime,
      expectedDate: fields[5] as DateTime,
      progress: fields[6] as double,
      wateringFrequencyInHours: fields[7] as int,
      sunlightRequirements: fields[8] as String,
      weeklyWatering: (fields[9] as List?)?.cast<bool>(),
    );
  }

  @override
  void write(BinaryWriter writer, Plant obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.count)
      ..writeByte(4)
      ..write(obj.plantedDate)
      ..writeByte(5)
      ..write(obj.expectedDate)
      ..writeByte(6)
      ..write(obj.progress)
      ..writeByte(7)
      ..write(obj.wateringFrequencyInHours)
      ..writeByte(8)
      ..write(obj.sunlightRequirements)
      ..writeByte(9)
      ..write(obj.weeklyWatering);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlantAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
