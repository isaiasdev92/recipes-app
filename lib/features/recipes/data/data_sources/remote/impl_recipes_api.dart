import 'dart:convert';

import 'package:recipes_app/core/network/api_path.dart';
import 'package:recipes_app/core/network/http_app_cient.dart';
import 'package:recipes_app/core/utils/exceptions_app.dart';
import 'package:recipes_app/features/recipes/data/data_sources/remote/abstract_recipes_api.dart';
import 'package:recipes_app/features/recipes/domain/entities/recipe_entity.dart';

class ImplRecipesApi extends AbstractRecipesApi {
  @override
  Future<MealResponse> getByIdMeal(String mealId) async {
    try {
      final path = getByMeadId;
      final response = await HttpAppClient.get(path, queryParameters: {"i": mealId});

      if (response.statusCode != 200) {
        throw ExceptionGeneral(message: "Error al cargar los datos");
      }
      final data = json.decode(response.body);
      final mealResponse = MealResponse.fromJson(data);
      return mealResponse;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<MealResponse> searchRecipes(String query) async {
    try {
      final path = getSearchMeals;
      final response = await HttpAppClient.get(path, queryParameters: {"s": query});

      if (response.statusCode != 200) {
        throw ExceptionGeneral(message: "Error al cargar los datos");
      }
      final data = json.decode(response.body);
      final mealResponse = MealResponse.fromJson(data);
      return mealResponse;
    } catch (_) {
      rethrow;
    }
  }
}