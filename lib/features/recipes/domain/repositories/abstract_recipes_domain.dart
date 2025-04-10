import 'package:recipes_app/features/recipes/domain/entities/recipe_entity.dart';
import 'package:recipes_app/features/recipes/domain/entities/recipe_hive_model.dart';

abstract class AbstractRecipesDomain {
  Future<MealResponse> searchRecipesApi(String query);
  Future<MealResponse> getByIdMealApi(String mealId);

  Future<void> saveRecipeLocal(RecipeHiveModel recipe);
  Future<List<RecipeHiveModel>> getAllRecipesLocal();
  Future<RecipeHiveModel?> getRecipeLocal(String id);
  Future<void> deleteRecipeLocal(String id);
  Future<List<RecipeHiveModel>> searchRecipesLocal(String query);

}