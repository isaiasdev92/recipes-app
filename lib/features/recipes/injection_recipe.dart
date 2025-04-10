import 'package:recipes_app/core/get_instances/get_config.dart';
import 'package:recipes_app/features/recipes/data/data_sources/remote/impl_recipes_api.dart';
import 'package:recipes_app/features/recipes/data/repositories/impl_recipes_data.dart';
import 'package:recipes_app/features/recipes/domain/repositories/abstract_recipes_domain.dart';
import 'package:recipes_app/features/recipes/domain/usecases/add_recipe_local_uc.dart';
import 'package:recipes_app/features/recipes/domain/usecases/delete_recipe_by_id_local_uc.dart';
import 'package:recipes_app/features/recipes/domain/usecases/fetch_recipes_uc.dart';
import 'package:recipes_app/features/recipes/domain/usecases/get_recipe_detail__api_uc.dart';
import 'package:recipes_app/features/recipes/domain/usecases/get_recipe_id_local_uc.dart';
import 'package:recipes_app/features/recipes/domain/usecases/get_total_local_uc.dart';
import 'package:recipes_app/features/recipes/domain/usecases/search_recipes_local_uc.dart';
import 'package:recipes_app/features/recipes/domain/usecases/search_recipes_uc.dart';
import 'package:recipes_app/features/recipes/presentation/bloc/recipe_detail_bloc/recipe_detail_bloc.dart';
import 'package:recipes_app/features/recipes/presentation/bloc/recipes_list_bloc/home_bloc.dart';

Future<void> initInjectionRecipe() async {
  sl.registerSingleton<ImplRecipesApi>(ImplRecipesApi());
  sl.registerSingleton<AbstractRecipesDomain>(ImplRecipesData(implRecipesApi: sl(), implRecipesLocal: sl()));
  sl.registerSingleton<FetchRecipesUc>(FetchRecipesUc(sl()));
  sl.registerSingleton<GetRecipeDetailApiUc>(GetRecipeDetailApiUc(sl()));
  sl.registerSingleton<SearchRecipesUc>(SearchRecipesUc(sl()));
  sl.registerSingleton<DeleteRecipeByIdLocalUc>(DeleteRecipeByIdLocalUc(sl()));
  sl.registerSingleton<GetRecipeIdLocalUc>(GetRecipeIdLocalUc(sl()));
  sl.registerSingleton<AddRecipeLocalUc>(AddRecipeLocalUc(sl()));
  sl.registerSingleton<GetAllRecipesLocal>(GetAllRecipesLocal(sl()));
  sl.registerSingleton<SearchRecipesLocalUc>(SearchRecipesLocalUc(sl()));

  // Bloc
  sl.registerFactory(
    () => HomeBloc(
      fetchRecipesUc: sl(),
      searchRecipesUc: sl(),
      deleteRecipeByIdLocalUc: sl(),
      getRecipeIdLocalUc: sl(),
      addRecipeLocalUc: sl(),
      getAllRecipesLocal: sl(),
      searchRecipesLocalUc: sl(),
    ),
  );

  sl.registerFactory(
    () => RecipeDetailBloc(
      getRecipeDetailUc: sl(),
      getRecipeIdLocalUc: sl(),
      addRecipeLocalUc: sl(),
      deleteRecipeByIdLocalUc: sl()
    ),
  );  
}
