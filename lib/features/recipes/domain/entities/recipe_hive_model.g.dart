// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeHiveModelAdapter extends TypeAdapter<RecipeHiveModel> {
  @override
  final int typeId = 0;

  @override
  RecipeHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecipeHiveModel(
      id: fields[0] as String,
      name: fields[1] as String,
      alternate: fields[2] as String?,
      category: fields[3] as String,
      area: fields[4] as String,
      instructions: fields[5] as String,
      thumbnailUrl: fields[6] as String,
      tags: fields[7] as String?,
      youtubeUrl: fields[8] as String,
      ingredients: (fields[9] as List).cast<IngredientHiveModel>(),
      source: fields[10] as String?,
      imageSource: fields[11] as String?,
      creativeCommonsConfirmed: fields[12] as String?,
      dateModified: fields[13] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, RecipeHiveModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.alternate)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.area)
      ..writeByte(5)
      ..write(obj.instructions)
      ..writeByte(6)
      ..write(obj.thumbnailUrl)
      ..writeByte(7)
      ..write(obj.tags)
      ..writeByte(8)
      ..write(obj.youtubeUrl)
      ..writeByte(9)
      ..write(obj.ingredients)
      ..writeByte(10)
      ..write(obj.source)
      ..writeByte(11)
      ..write(obj.imageSource)
      ..writeByte(12)
      ..write(obj.creativeCommonsConfirmed)
      ..writeByte(13)
      ..write(obj.dateModified);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
