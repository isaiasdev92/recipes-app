// entities/meal_entity.dart

class MealResponse {
  final List<Recipe> meals;

  MealResponse({required this.meals});

  factory MealResponse.fromJson(Map<String, dynamic> json) {
    return MealResponse(
      meals: (json['meals'] as List?)
              ?.map((meal) => Recipe.fromJson(meal))
              .toList() ??
          [],
    );
  }
}

class Recipe {
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

  Recipe({
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

  factory Recipe.fromJson(Map<String, dynamic> json) {
    // Extraer ingredientes y medidas
    List<IngredientEntity> ingredients = [];
    
    for (int i = 1; i <= 20; i++) {
      String? ingredient = json['strIngredient$i'];
      String? measure = json['strMeasure$i'];
      
      if (ingredient != null && ingredient.trim().isNotEmpty) {
        ingredients.add(IngredientEntity(
          name: ingredient.trim(),
          measure: (measure != null && measure.trim().isNotEmpty) 
              ? measure.trim() 
              : '',
        ));
      }
    }

    return Recipe(
      id: json['idMeal'] ?? '',
      name: json['strMeal'] ?? '',
      alternate: json['strMealAlternate'],
      category: json['strCategory'] ?? '',
      area: json['strArea'] ?? '',
      instructions: json['strInstructions'] ?? '',
      thumbnailUrl: json['strMealThumb'] ?? '',
      tags: json['strTags'],
      youtubeUrl: json['strYoutube'] ?? '',
      ingredients: ingredients,
      source: json['strSource'],
      imageSource: json['strImageSource'],
      creativeCommonsConfirmed: json['strCreativeCommonsConfirmed'],
      dateModified: json['dateModified'],
    );
  }  
}

class IngredientEntity {
  final String name;
  final String measure;

  IngredientEntity({
    required this.name,
    required this.measure,
  });
}
