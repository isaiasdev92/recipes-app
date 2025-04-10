import 'package:recipes_app/core/utils/base_usecase.dart';
import 'package:recipes_app/features/recipes/domain/entities/recipe_entity.dart';
import 'package:recipes_app/features/recipes/domain/repositories/abstract_recipes_domain.dart';

class SearchRecipesUc implements UseCase<List<Recipe>, String> {
  final AbstractRecipesDomain repository;

  SearchRecipesUc(this.repository);

  @override
  Future<List<Recipe>> call(String query) async {
    try {
      final result = await repository.searchRecipesApi(query);

      return result.meals;
    } catch (_) {
      return [];
    }
  }
}
