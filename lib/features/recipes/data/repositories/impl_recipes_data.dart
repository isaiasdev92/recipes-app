import 'package:flutter/widgets.dart';
import 'package:recipes_app/core/utils/connectivity_internet_app.dart';
import 'package:recipes_app/core/utils/exceptions_app.dart';
import 'package:recipes_app/features/recipes/data/data_sources/local/impl_recipes_local.dart';
import 'package:recipes_app/features/recipes/data/data_sources/remote/impl_recipes_api.dart';
import 'package:recipes_app/features/recipes/domain/entities/recipe_entity.dart';
import 'package:recipes_app/features/recipes/domain/entities/recipe_hive_model.dart';
import 'package:recipes_app/features/recipes/domain/repositories/abstract_recipes_domain.dart';

class ImplRecipesData extends AbstractRecipesDomain {
  final ImplRecipesLocal implRecipesLocal;
  final ImplRecipesApi implRecipesApi;

  ImplRecipesData({required this.implRecipesApi, required this.implRecipesLocal});

  @override
  Future<MealResponse> getByIdMealApi(String mealId) async {
    try {
      if (!await ConnectivityInternetApp.hasConnection()) {
        throw NetworkException("No tienes conexión a internet");
      }
      final result = await implRecipesApi.getByIdMeal(mealId);

      return result;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<MealResponse> searchRecipesApi(String query) async {
    try {
      if (!await ConnectivityInternetApp.hasConnection()) {
        throw NetworkException("No tienes conexión a internet");
      }

      final result = await implRecipesApi.searchRecipes(query);

      return result;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> deleteRecipeLocal(String id) async {
    try {
      await implRecipesLocal.deleteRecipeLocal(id);
    } catch (_) {
      throw ExceptionGeneral(message: "Error al eliminar la receta");
    }
  }

  @override
  Future<List<RecipeHiveModel>> getAllRecipesLocal() async {
    try {
      return await implRecipesLocal.getAllRecipesLocal();
    } catch (_) {
      throw ExceptionGeneral(message: "Error al obtener las recetas");
    }
  }

  @override
  Future<RecipeHiveModel?> getRecipeLocal(String id) async {
    try {
      return await implRecipesLocal.getRecipeLocal(id);
    } catch (e) {
      debugPrint(e.toString());
      throw ExceptionGeneral(message: "Error al obtener el elemento");
    }
  }

  @override
  Future<void> saveRecipeLocal(RecipeHiveModel recipe) async {
    try {
      return await implRecipesLocal.saveRecipeLocal(recipe);
    } catch (_) {
      throw ExceptionGeneral(message: "Error al guardar");
    }
  }
  
  @override
  Future<List<RecipeHiveModel>> searchRecipesLocal(String query) async{
    return await implRecipesLocal.searchRecipesLocal(query);
  }
}