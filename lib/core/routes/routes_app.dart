import 'package:go_router/go_router.dart';
import 'package:recipes_app/features/recipes/presentation/page/recipes_details_page.dart';
import 'package:recipes_app/features/recipes/presentation/page/recipes_home_page.dart';
import 'package:recipes_app/main.dart';

// routes.dart
final routes = GoRouter(
  initialLocation: '/',
  navigatorKey: rootNavKey,
  routes: [
    GoRoute(
      name: 'home',
      path: RecipesHomePage.path,
      builder: (context, state) => const RecipesHomePage(),
    ),
    GoRoute(
      name: 'detailsRecipes',
      path: RecipesDetailsPage.path, 
      builder: (context, state) {
        final recipeId = state.pathParameters['recipeId']!;
        return RecipesDetailsPage(recipeId: recipeId);
      },
    ),
  ],
);