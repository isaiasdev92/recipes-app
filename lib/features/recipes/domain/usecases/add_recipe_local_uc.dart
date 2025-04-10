import 'package:recipes_app/core/utils/base_usecase.dart';
import 'package:recipes_app/features/recipes/domain/entities/recipe_hive_model.dart';
import 'package:recipes_app/features/recipes/domain/repositories/abstract_recipes_domain.dart';

class AddRecipeLocalUc implements UseCase<void, RecipeHiveModel> {
  final AbstractRecipesDomain repository;

  AddRecipeLocalUc(this.repository);

  @override
  Future<void> call(RecipeHiveModel recipe) async {
    await repository.saveRecipeLocal(recipe);
  }
}
