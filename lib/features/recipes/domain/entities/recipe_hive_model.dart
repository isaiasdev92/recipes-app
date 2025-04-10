import 'package:hive_ce/hive.dart';
import 'ingredient_hive_model.dart';

part 'recipe_hive_model.g.dart';

@HiveType(typeId: 0)
class RecipeHiveModel extends HiveObject {
  @HiveField(0)
  final String id;
  
  @HiveField(1)
  final String name;
  
  @HiveField(2)
  final String? alternate;
  
  @HiveField(3)
  final String category;
  
  @HiveField(4)
  final String area;
  
  @HiveField(5)
  final String instructions;
  
  @HiveField(6)
  final String thumbnailUrl;
  
  @HiveField(7)
  final String? tags;
  
  @HiveField(8)
  final String youtubeUrl;
  
  @HiveField(9)
  final List<IngredientHiveModel> ingredients;
  
  @HiveField(10)
  final String? source;
  
  @HiveField(11)
  final String? imageSource;
  
  @HiveField(12)
  final String? creativeCommonsConfirmed;
  
  @HiveField(13)
  final String? dateModified;

  RecipeHiveModel({
    required this.id,
    required this.name,
    this.alternate,
    required this.category,
    required this.area,
    required this.instructions,
    required this.thumbnailUrl,
    this.tags,
    required this.youtubeUrl,
    required this.ingredients,
    this.source,
    this.imageSource,
    this.creativeCommonsConfirmed,
    this.dateModified,
  });
}
