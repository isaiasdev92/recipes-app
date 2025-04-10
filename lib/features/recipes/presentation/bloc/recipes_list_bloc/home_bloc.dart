import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

import 'package:recipes_app/core/utils/base_usecase.dart';
import 'package:recipes_app/features/recipes/domain/entities/recipe_hive_model.dart';
import 'package:recipes_app/features/recipes/domain/usecases/add_recipe_local_uc.dart';
import 'package:recipes_app/features/recipes/domain/usecases/delete_recipe_by_id_local_uc.dart';
import 'package:recipes_app/features/recipes/domain/usecases/fetch_recipes_uc.dart';
import 'package:recipes_app/features/recipes/domain/usecases/get_recipe_id_local_uc.dart';
import 'package:recipes_app/features/recipes/domain/usecases/get_total_local_uc.dart';
import 'package:recipes_app/features/recipes/domain/usecases/search_recipes_local_uc.dart';
import 'package:recipes_app/features/recipes/domain/usecases/search_recipes_uc.dart';
import 'package:recipes_app/features/recipes/presentation/viewmodels/recipe_view_model.dart';
import 'package:recipes_app/shared/widget/snack_bar_app.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FetchRecipesUc fetchRecipesUc;
  final SearchRecipesUc searchRecipesUc;
  final DeleteRecipeByIdLocalUc deleteRecipeByIdLocalUc;
  final GetRecipeIdLocalUc getRecipeIdLocalUc;
  final AddRecipeLocalUc addRecipeLocalUc;
  final GetAllRecipesLocal getAllRecipesLocal;
  final SearchRecipesLocalUc searchRecipesLocalUc;
  HomeBloc({
    required this.fetchRecipesUc,
    required this.searchRecipesUc,
    required this.deleteRecipeByIdLocalUc,
    required this.getRecipeIdLocalUc,
    required this.addRecipeLocalUc,
    required this.getAllRecipesLocal,
    required this.searchRecipesLocalUc,
  }) : super(RecipesInitial()) {
    on<FetchRecipes>(_onFetchRecipes);
    on<SearchRecipes>(_onSearchRecipes);
    on<ToggleFavorite>(_onToggleFavorite);
    on<LoadFavoritesCount>(_onLoadFavoritesCount);
  }

  Future<void> _onFetchRecipes(FetchRecipes event, Emitter<HomeState> emit) async {
    emit(RecipesLoading());
    try {
      final recipesApi = await fetchRecipesUc.call(NoParams());
      final recipesLocal = await getAllRecipesLocal.call(NoParams());

      final listViewModelApi = recipesApi.map((item) => item.toViewModel()).toSet();
      final listViewModelLocal = recipesLocal.map((item) => item.toHiveModel()).toSet();

      final Map<String, RecipeViewModel> recipeMap = {for (var recipe in listViewModelApi) recipe.id: recipe};

      for (var favRecipe in listViewModelLocal) {
        if (listViewModelApi.isEmpty) {
          favRecipe.isFavorite = true;
          recipeMap[favRecipe.id] = favRecipe;
        } else {
          recipeMap[favRecipe.id] = recipeMap.containsKey(favRecipe.id) ? recipeMap[favRecipe.id]!.copyWith(isFavorite: true) : favRecipe;
        }
      }

      emit(RecipesLoaded(recipes: recipeMap.values.toList(), favoritesCount: recipesLocal.length));
    } catch (e) {
      emit(RecipesError(message: 'Failed to load recipes'));
    }
  }

  Future<void> _onSearchRecipes(SearchRecipes event, Emitter<HomeState> emit) async {
    if (event.query.isEmpty) {
      add(FetchRecipes());
      return;
    }

    emit(RecipesLoading());
    try {
      final recipesApi = await searchRecipesUc.call(event.query);
      final recipesLocal = await searchRecipesLocalUc.call(event.query);

      final listViewModeApi = recipesApi.map((item) => item.toViewModel()).toSet();
      final listViewModelLocal = recipesLocal.map((item) => item.toHiveModel()).toSet();

      final Map<String, RecipeViewModel> recipeMapSearch = {for (var recipe in listViewModeApi) recipe.id: recipe};

      for (var favRecipe in listViewModelLocal) {
        if (recipesApi.isEmpty) {
          favRecipe.isFavorite = true;
          recipeMapSearch[favRecipe.id] = favRecipe;          
        } else {
          recipeMapSearch[favRecipe.id] = recipeMapSearch.containsKey(favRecipe.id) ? recipeMapSearch[favRecipe.id]!.copyWith(isFavorite: true) : favRecipe;
        }
      }
      emit(RecipesLoaded(recipes: recipeMapSearch.values.toList(), favoritesCount: recipesLocal.length, searchQuery: event.query));
    } catch (e) {
      emit(RecipesError(message: 'Failed to search recipes'));
    }
  }

  Future<void> _onToggleFavorite(ToggleFavorite event, Emitter<HomeState> emit) async {
    if (state is RecipesLoaded) {
      final currentState = state as RecipesLoaded;
      final updatedRecipes = currentState.recipes.map((recipe) {
            if (recipe.id == event.recipeId) {
              return recipe.copyWith(isFavorite: !recipe.isFavorite);
            }
            return recipe;
          }).toList();

      final item = updatedRecipes.firstWhereOrNull((r) => r.id == event.recipeId);

      late RecipeHiveModel? recipeLocal;
      if (item != null) {
        recipeLocal = await getRecipeIdLocalUc.call(event.recipeId);

        if (recipeLocal == null) {
          await addRecipeLocalUc.call(item.toEntity());
          showSnackbar("Se agregó a favoritos");
        } else {
          deleteRecipeByIdLocalUc.call(event.recipeId);
          showSnackbar("Se eliminó de favoritos");
        }
      }

      final favoritesCount = (await getAllRecipesLocal.call(NoParams())).length;
      // final favoritesCount = 0;

      emit(currentState.copyWith(recipes: updatedRecipes, favoritesCount: favoritesCount));
    }
  }

  Future<void> _onLoadFavoritesCount(LoadFavoritesCount event, Emitter<HomeState> emit) async {
    if (state is RecipesLoaded) {
      final currentState = state as RecipesLoaded;
      // final favoritesCount = await recipeRepository.getFavoritesCount();
      final favoritesCount = 0;
      emit(currentState.copyWith(favoritesCount: favoritesCount));
    }
  }
}
