import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:recipes_app/core/get_instances/get_config.dart';
import 'package:recipes_app/features/recipes/data/data_sources/local/impl_recipes_local.dart';
import 'package:recipes_app/features/recipes/domain/entities/ingredient_hive_model.dart';
import 'package:recipes_app/features/recipes/domain/entities/recipe_hive_model.dart';

class HiveApp {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive
      ..registerAdapter(IngredientHiveModelAdapter())
      ..registerAdapter(RecipeHiveModelAdapter());

    final localDataSource = await ImplRecipesLocal.create();
    sl.registerSingleton<ImplRecipesLocal>(localDataSource);    

  }
}
