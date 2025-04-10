part of 'recipe_detail_bloc.dart';

abstract class RecipeDetailState extends Equatable {
  const RecipeDetailState();

  @override
  List<Object> get props => [];
}

class RecipeDetailInitial extends RecipeDetailState {}

class RecipeDetailLoading extends RecipeDetailState {}

class RecipeDetailLoaded extends RecipeDetailState {
  final RecipeViewModel recipe;
  final bool isFavorite;

  const RecipeDetailLoaded(this.recipe, this.isFavorite);

  @override
  List<Object> get props => [recipe, isFavorite];
}

class RecipeDetailError extends RecipeDetailState {
  final String message;

  const RecipeDetailError(this.message);

  @override
  List<Object> get props => [message];
}