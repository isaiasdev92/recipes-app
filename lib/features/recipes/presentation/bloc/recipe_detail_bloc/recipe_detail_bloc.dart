import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:recipes_app/features/recipes/domain/usecases/add_recipe_local_uc.dart';
import 'package:recipes_app/features/recipes/domain/usecases/delete_recipe_by_id_local_uc.dart';
import 'package:recipes_app/features/recipes/domain/usecases/get_recipe_detail__api_uc.dart';
import 'package:recipes_app/features/recipes/domain/usecases/get_recipe_id_local_uc.dart';
import 'package:recipes_app/features/recipes/presentation/viewmodels/recipe_view_model.dart';

part 'recipe_detail_event.dart';
part 'recipe_detail_state.dart';

class RecipeDetailBloc extends Bloc<RecipeDetailEvent, RecipeDetailState> {
  final GetRecipeDetailApiUc getRecipeDetailUc;
  final GetRecipeIdLocalUc getRecipeIdLocalUc;
  final AddRecipeLocalUc addRecipeLocalUc;
  final DeleteRecipeByIdLocalUc deleteRecipeByIdLocalUc;

  RecipeDetailBloc({required this.getRecipeDetailUc, required this.getRecipeIdLocalUc, required this.addRecipeLocalUc, required this.deleteRecipeByIdLocalUc})
    : super(RecipeDetailInitial()) {
    on<LoadRecipeDetail>(_onLoadRecipeDetail);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onLoadRecipeDetail(LoadRecipeDetail event, Emitter<RecipeDetailState> emit) async {
    emit(RecipeDetailLoading());
    try {
      // Primero intenta obtener de la API
      final recipe = await getRecipeDetailUc.call(event.recipeId);
      final recipeLocal = await getRecipeIdLocalUc.call(event.recipeId);

      bool isFavorite = recipeLocal == null ? false : true;

      emit(RecipeDetailLoaded(recipe.toViewModel(), isFavorite));
    } catch (apiError) {
      try {
        // Si falla la API, intenta obtener de Hive
        final localRecipe = await getRecipeIdLocalUc.call(event.recipeId);
        if (localRecipe != null) {
          final recipeLocal = await getRecipeIdLocalUc.call(event.recipeId);

          bool isFavorite = recipeLocal == null ? false : true;
          emit(RecipeDetailLoaded(localRecipe.toHiveModel(), isFavorite));
        } else {
          emit(RecipeDetailError('Recipe not found'));
        }
      } catch (localError) {
        emit(RecipeDetailError('Failed to load recipe'));
      }
    }
  }

  Future<void> _onToggleFavorite(ToggleFavorite event, Emitter<RecipeDetailState> emit) async {
    if (state is RecipeDetailLoaded) {
      final currentState = state as RecipeDetailLoaded;
      final recipeLocal = await getRecipeIdLocalUc.call(currentState.recipe.id);

      bool isFavorite = false;
      if (recipeLocal == null) {
        await addRecipeLocalUc.call(currentState.recipe.toEntity());
        isFavorite = true;
      } else {
        deleteRecipeByIdLocalUc.call(currentState.recipe.id);
        isFavorite = false;
      }
      emit(RecipeDetailLoaded(currentState.recipe, isFavorite));
    }
  }
}
