part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class FetchRecipes extends HomeEvent {}

class SearchRecipes extends HomeEvent {
  final String query;

  const SearchRecipes(this.query);

  @override
  List<Object> get props => [query];
}

class ToggleFavorite extends HomeEvent {
  final String recipeId;

  const ToggleFavorite(this.recipeId);

  @override
  List<Object> get props => [recipeId];
}

class LoadFavoritesCount extends HomeEvent {}