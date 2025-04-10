import 'package:recipes_app/core/utils/base_usecase.dart';
import 'package:recipes_app/features/recipes/domain/entities/recipe_hive_model.dart';
import 'package:recipes_app/features/recipes/domain/repositories/abstract_recipes_domain.dart';

class SearchRecipesLocalUc implements UseCase<List<RecipeHiveModel>, String> {
  final AbstractRecipesDomain repository;
  SearchRecipesLocalUc(this.repository);

  @override
  Future<List<RecipeHiveModel>> call(String query) async {
    try {
      return await repository.searchRecipesLocal(query);
    } catch (_) {
      return [];
    }
  }
}
