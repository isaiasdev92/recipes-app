import 'package:recipes_app/core/utils/base_usecase.dart';
import 'package:recipes_app/features/recipes/domain/entities/recipe_entity.dart';
import 'package:recipes_app/features/recipes/domain/repositories/abstract_recipes_domain.dart';

class FetchRecipesUc implements UseCase<List<Recipe>, NoParams> {
  final AbstractRecipesDomain repository;

  FetchRecipesUc(this.repository);

  @override
  Future<List<Recipe>> call(NoParams params) async {
    try {
      final result = await repository.searchRecipesApi("");
      return result.meals;
    } catch (_) {
      return [];
    }
  }
}
