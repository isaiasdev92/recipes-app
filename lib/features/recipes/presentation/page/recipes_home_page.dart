// lib/features/recipes/presentation/pages/recipes_home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes_app/core/get_instances/get_config.dart';
import 'package:recipes_app/core/routes/nav_app.dart';
import 'package:recipes_app/features/recipes/presentation/bloc/recipes_list_bloc/home_bloc.dart';
import 'package:recipes_app/features/recipes/presentation/page/recipes_details_page.dart';
import 'package:recipes_app/features/recipes/presentation/widgets/recipe_card_widget.dart';
import 'package:recipes_app/features/recipes/presentation/widgets/recipe_search_bar.dart';

class RecipesHomePage extends StatefulWidget {
  static const String path = '/';

  const RecipesHomePage({super.key});

  @override
  State<RecipesHomePage> createState() => _RecipesHomePageState();
}

class _RecipesHomePageState extends State<RecipesHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeBloc>()..add(FetchRecipes()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Recipes'),
          actions: [
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is RecipesLoaded) {
                  return Stack(
                    children: [
                      const Icon(Icons.favorite),
                      if (state.favoritesCount > 0)
                        Positioned(
                          right: 0,
                          child: CircleAvatar(
                            radius: 8,
                            backgroundColor: Colors.red,
                            child: Text(state.favoritesCount.toString(), style: const TextStyle(fontSize: 10, color: Colors.white)),
                          ),
                        ),
                    ],
                  );
                }
                return const IconButton(icon: Icon(Icons.favorite), onPressed: null);
              },
            ),
          ],
        ),
        body: Column(
          children: [
            const Padding(padding: EdgeInsets.all(8.0), child: RecipeSearchBar()),
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is RecipesInitial || state is RecipesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is RecipesError) {
                    return Center(child: Text(state.message));
                  } else if (state is RecipesLoaded) {
                    if (state.recipes.isEmpty) {
                      return const Center(child: Text('No recipes found'));
                    }
                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<HomeBloc>().add(FetchRecipes());
                      },
                      child: ListView.builder(
                        itemCount: state.recipes.length,
                        itemBuilder: (context, index) {
                          final recipe = state.recipes[index];
                          return RecipeCard(
                            recipe: recipe,
                            onTap: () {
                              NavApp.pushReplacement(RecipesDetailsPage.path, pathParameters: {"recipeId": recipe.id});
                            },
                            onFavoriteToggle: () {
                              context.read<HomeBloc>().add(ToggleFavorite(recipe.id));
                            },
                          );
                        },
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
