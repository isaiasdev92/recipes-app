import 'package:recipes_app/core/utils/base_usecase.dart';
import 'package:recipes_app/features/recipes/domain/repositories/abstract_recipes_domain.dart';

class DeleteRecipeByIdLocalUc implements UseCase<void, String> {
  final AbstractRecipesDomain repository;

  DeleteRecipeByIdLocalUc(this.repository);

  @override
  Future<void> call(String recipeId) async {
    final item = await repository.getRecipeLocal(recipeId);

    if (item != null) {
      await repository.deleteRecipeLocal(item.key);
    }
  }
}
