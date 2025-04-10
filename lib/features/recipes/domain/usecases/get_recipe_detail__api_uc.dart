import 'package:recipes_app/core/utils/base_usecase.dart';
import 'package:recipes_app/core/utils/exceptions_app.dart';
import 'package:recipes_app/features/recipes/domain/entities/recipe_entity.dart';
import 'package:recipes_app/features/recipes/domain/repositories/abstract_recipes_domain.dart';

class GetRecipeDetailApiUc implements UseCase<Recipe, String> {
  final AbstractRecipesDomain repository;
  GetRecipeDetailApiUc(this.repository);

  @override
  Future<Recipe> call(String id) async {
    try {
      final result = await repository.getByIdMealApi(id);

      return result.meals.first;
    } catch (_) {
      throw ExceptionGeneral(message: "Error al obtener los datos");
    }
  }
}
