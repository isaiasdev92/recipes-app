import 'package:hive_ce/hive.dart';

part 'ingredient_hive_model.g.dart';

@HiveType(typeId: 1)
class IngredientHiveModel {
  @HiveField(0)
  final String name;
  
  @HiveField(1)
  final String measure;

  IngredientHiveModel({
    required this.name,
    required this.measure,
  });
}
