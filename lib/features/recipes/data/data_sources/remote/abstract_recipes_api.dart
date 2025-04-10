import 'package:recipes_app/features/recipes/domain/entities/recipe_entity.dart';

abstract class AbstractRecipesApi {
  Future<MealResponse> searchRecipes(String query);
  Future<MealResponse> getByIdMeal(String mealId);
}