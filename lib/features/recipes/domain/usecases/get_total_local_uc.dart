import 'package:recipes_app/core/utils/base_usecase.dart';
import 'package:recipes_app/features/recipes/domain/entities/recipe_hive_model.dart';
import 'package:recipes_app/features/recipes/domain/repositories/abstract_recipes_domain.dart';

class GetAllRecipesLocal implements UseCase<List<RecipeHiveModel>, NoParams> {
  final AbstractRecipesDomain repository;
  GetAllRecipesLocal(this.repository);

  @override
  Future<List<RecipeHiveModel>> call(NoParams params) async {
    try {
      return (await repository.getAllRecipesLocal());
    } catch (_) {
      return [];
    }
  }
}
