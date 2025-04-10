import 'package:recipes_app/core/utils/base_usecase.dart';
import 'package:recipes_app/features/recipes/domain/entities/recipe_hive_model.dart';
import 'package:recipes_app/features/recipes/domain/repositories/abstract_recipes_domain.dart';

class GetRecipeIdLocalUc implements UseCase<RecipeHiveModel?, String> {
  final AbstractRecipesDomain repository; 
  GetRecipeIdLocalUc(this.repository);
  @override
  Future<RecipeHiveModel?> call(String id) async {
    try {
      return await repository.getRecipeLocal(id);
    } catch (_) {
      return null;
    }
    
  }
}
