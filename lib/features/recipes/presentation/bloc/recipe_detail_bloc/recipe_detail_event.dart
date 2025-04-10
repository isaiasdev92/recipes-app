part of 'recipe_detail_bloc.dart';

abstract class RecipeDetailEvent extends Equatable {
  const RecipeDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadRecipeDetail extends RecipeDetailEvent {
  final String recipeId;

  const LoadRecipeDetail(this.recipeId);

  @override
  List<Object> get props => [recipeId];
}

class ToggleFavorite extends RecipeDetailEvent {
  const ToggleFavorite();
}