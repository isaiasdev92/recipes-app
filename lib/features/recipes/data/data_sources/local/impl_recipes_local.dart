import 'package:hive_ce/hive.dart';
import 'package:recipes_app/features/recipes/domain/entities/recipe_hive_model.dart';
import 'abstract_recipes_local.dart';

class ImplRecipesLocal implements AbstractRecipesLocal {
  static const _recipesBoxName = 'recipes';
  final Box<RecipeHiveModel> _recipesBox;

  static Future<ImplRecipesLocal> create() async {
    final box = await Hive.openBox<RecipeHiveModel>(_recipesBoxName);
    return ImplRecipesLocal._internal(box);
  }

  ImplRecipesLocal._internal(this._recipesBox);

  @override
  Future<void> saveRecipeLocal(RecipeHiveModel recipe) async {
    await _recipesBox.put(recipe.id, recipe);
  }

  @override
  Future<List<RecipeHiveModel>> getAllRecipesLocal() async {
    return _recipesBox.values.toList();
  }

  @override
  Future<List<RecipeHiveModel>> searchRecipesLocal(String query) async {
    final normalizedQuery = query.toLowerCase();
    return _recipesBox.values.where((recipe) {
      return recipe.name.toLowerCase().contains(normalizedQuery);
    }).toList();
  }

  @override
  Future<RecipeHiveModel?> getRecipeLocal(String id) async {
    try {
      return _recipesBox.values.firstWhere((r) => r.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> deleteRecipeLocal(String id) async {
    await _recipesBox.delete(id);
  }

  Future<void> close() async {
    await _recipesBox.close();
  }
}
