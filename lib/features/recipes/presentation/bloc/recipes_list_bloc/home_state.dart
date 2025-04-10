
part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class RecipesInitial extends HomeState {}

class RecipesLoading extends HomeState {}

class RecipesLoaded extends HomeState {
  final List<RecipeViewModel> recipes;
  final int favoritesCount;
  final String? searchQuery;

  const RecipesLoaded({
    required this.recipes,
    required this.favoritesCount,
    this.searchQuery,
  });

  RecipesLoaded copyWith({
    List<RecipeViewModel>? recipes,
    int? favoritesCount,
    String? searchQuery,
  }) {
    return RecipesLoaded(
      recipes: recipes ?? this.recipes,
      favoritesCount: favoritesCount ?? this.favoritesCount,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object> get props => [recipes, favoritesCount, searchQuery ?? ''];
}

class RecipesError extends HomeState {
  final String message;

  const RecipesError({required this.message});

  @override
  List<Object> get props => [message];
}