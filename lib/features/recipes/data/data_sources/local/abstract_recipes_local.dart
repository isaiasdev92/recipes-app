import 'package:recipes_app/features/recipes/domain/entities/recipe_hive_model.dart';

abstract class AbstractRecipesLocal {
  Future<void> saveRecipeLocal(RecipeHiveModel recipe);
  Future<List<RecipeHiveModel>> getAllRecipesLocal();
  Future<List<RecipeHiveModel>> searchRecipesLocal(String query);
  Future<RecipeHiveModel?> getRecipeLocal(String id);
  Future<void> deleteRecipeLocal(String id);
}