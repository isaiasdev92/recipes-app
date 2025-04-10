import 'package:recipes_app/features/recipes/domain/entities/ingredient_hive_model.dart';
import 'package:recipes_app/features/recipes/domain/entities/recipe_entity.dart';
import 'package:recipes_app/features/recipes/domain/entities/recipe_hive_model.dart';

class RecipeViewModel {
  final String id;
  final String name;
  final String? alternate;
  final String category;
  final String area;
  final String instructions;
  final String thumbnailUrl;
  final String? tags;
  final String youtubeUrl;
  final List<IngredientEntity> ingredients;
  final String? source;
  final String? imageSource;
  final String? creativeCommonsConfirmed;
  final String? dateModified;
   bool isFavorite;

  RecipeViewModel({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.thumbnailUrl,
    this.alternate,
    this.creativeCommonsConfirmed,
    this.dateModified,
    this.imageSource,
    this.ingredients = const [],
    this.instructions = "",
    this.isFavorite = false,
    this.source,
    this.tags,
    this.youtubeUrl = "",
  });

  RecipeViewModel copyWith({
    String? id,
    String? name,
    String? alternate,
    String? category,
    String? area,
    String? instructions,
    String? thumbnailUrl,
    String? tags,
    String? youtubeUrl,
    List<IngredientEntity> ingredients = const [],
    String? source,
    String? imageSource,
    String? creativeCommonsConfirmed,
    String? dateModified,
    bool? isFavorite,
  }) {
    return RecipeViewModel(
      id: id ?? this.id,
      name: name ?? this.name,
      alternate: alternate ?? this.alternate,
      category: category ?? this.category,
      area: area ?? this.area,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      isFavorite: isFavorite ?? this.isFavorite,
      creativeCommonsConfirmed: creativeCommonsConfirmed ?? this.creativeCommonsConfirmed,
      dateModified: dateModified ?? this.dateModified,
      imageSource: imageSource ?? this.imageSource,
      ingredients: ingredients,
      instructions: instructions ?? this.instructions,
      source: source ?? this.source,
      tags: tags ?? this.tags,
      youtubeUrl: youtubeUrl ?? this.youtubeUrl,
    );
  }
}

extension RecipeViewModelExtension on Recipe {
  RecipeViewModel toViewModel() {
    return RecipeViewModel(
      id: id,
      name: name,
      alternate: alternate,
      category: category,
      area: area,
      thumbnailUrl: thumbnailUrl,
      creativeCommonsConfirmed: creativeCommonsConfirmed,
      dateModified: dateModified,
      imageSource: imageSource,
      ingredients: ingredients,
      instructions: instructions,
      source: source,
      tags: tags,
      youtubeUrl: youtubeUrl,
    );
  }
}

extension RecipeViewModelLocalExtension on RecipeHiveModel {
  RecipeViewModel toHiveModel() {
    return RecipeViewModel(
      id: id,
      name: name,
      alternate: alternate,
      category: category,
      area: area,
      thumbnailUrl: thumbnailUrl,
      creativeCommonsConfirmed: creativeCommonsConfirmed,
      dateModified: dateModified,
      imageSource: imageSource,
      ingredients: ingredients.map((i) => IngredientEntity(
        name: i.name,
        measure: i.measure,
      )).toList(),
      instructions: instructions,
      source: source,
      tags: tags,
      youtubeUrl: youtubeUrl,
    );
  }
}


extension RecipeEntityExtension on RecipeViewModel {
  RecipeHiveModel toEntity() {
    return RecipeHiveModel(
      id: id,
      name: name,
      alternate: alternate,
      category: category,
      area: area,
      thumbnailUrl: thumbnailUrl,
      creativeCommonsConfirmed: creativeCommonsConfirmed,
      dateModified: dateModified,
      imageSource: imageSource,
      ingredients: ingredients.map((i) => IngredientHiveModel(name: i.name, measure: i.measure)).toList(),
      instructions: instructions,
      source: source,
      tags: tags,
      youtubeUrl: youtubeUrl,
    );
  }
}
