import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipes_app/core/get_instances/get_config.dart';
import 'package:recipes_app/core/routes/nav_app.dart';
import 'package:recipes_app/core/utils/utils.dart';
import 'package:recipes_app/features/recipes/domain/entities/recipe_entity.dart';
import 'package:recipes_app/features/recipes/presentation/bloc/recipe_detail_bloc/recipe_detail_bloc.dart';
import 'package:recipes_app/features/recipes/presentation/page/recipes_home_page.dart';
import 'package:recipes_app/features/recipes/presentation/viewmodels/recipe_view_model.dart';
import 'package:recipes_app/shared/widget/snack_bar_app.dart';

class RecipesDetailsPage extends StatefulWidget {
  static const String path = '/recipes-details/:recipeId';

  final String recipeId;

  const RecipesDetailsPage({super.key, required this.recipeId});

  @override
  State<RecipesDetailsPage> createState() => _RecipesDetailsPageState();
}

class _RecipesDetailsPageState extends State<RecipesDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => NavApp.pushReplacement(RecipesHomePage.path))),
      body: BlocProvider(
        create: (context) => sl<RecipeDetailBloc>()..add(LoadRecipeDetail(widget.recipeId)),
        child: BlocConsumer<RecipeDetailBloc, RecipeDetailState>(
          listener: (context, state) {
            if (state is RecipeDetailError) {
              showSnackbar(state.message);
            }
          },
          builder: (context, state) {
            if (state is RecipeDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is RecipeDetailError) {
              return _buildErrorState(context, state.message);
            } else if (state is RecipeDetailLoaded) {
              return _buildRecipeDetail(context, state.recipe, state.isFavorite);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(message, style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center),
          const SizedBox(height: 24),
          ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Go Back')),
        ],
      ),
    );
  }

  Widget _buildRecipeDetail(BuildContext context, RecipeViewModel recipe, bool isFavorite) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with image and basic info
          _buildRecipeHeader(context, recipe, isFavorite),

          const SizedBox(height: 24),

          // Ingredients section
          _buildIngredientsSection(recipe.ingredients),

          const SizedBox(height: 24),

          // Instructions section
          _buildInstructionsSection(recipe.instructions),

          const SizedBox(height: 24),

          // Additional info
          _buildAdditionalInfo(recipe),
        ],
      ),
    );
  }

  Widget _buildRecipeHeader(BuildContext context, RecipeViewModel recipe, bool isFavorite) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            imageUrl: recipe.thumbnailUrl,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
            errorWidget: (_, __, ___) => Container(height: 200, color: Colors.grey[200], child: const Icon(Icons.image_not_supported_rounded, size: 64)),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(recipe.name, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('${recipe.category} • ${recipe.area}', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[600])),
                ],
              ),
            ),
            IconButton(
              icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: isFavorite ? Colors.red : null),
              onPressed: () => context.read<RecipeDetailBloc>().add(ToggleFavorite()),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIngredientsSection(List<IngredientEntity> ingredients) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Ingredients', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...ingredients.map(
          (ingredient) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                const Icon(Icons.circle, size: 8),
                const SizedBox(width: 8),
                Expanded(child: Text(ingredient.name, style: Theme.of(context).textTheme.bodyMedium)),
                Text(ingredient.measure, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[600])),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInstructionsSection(String instructions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Instructions', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(instructions, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }

  Widget _buildAdditionalInfo(RecipeViewModel recipe) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (recipe.youtubeUrl.isNotEmpty) ...[
          const SizedBox(height: 8),
          Text('Video Tutorial', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => _launchYoutube(recipe.youtubeUrl),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.play_arrow, color: Colors.white),
                  const SizedBox(width: 4),
                  Text('Watch on YouTube', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white)),
                ],
              ),
            ),
          ),
        ],
        if (recipe.source?.isNotEmpty ?? false) ...[
          const SizedBox(height: 16),
          Text('Link', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => _launchUrl(recipe.source!),
            child: Text(recipe.source!, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.blue, decoration: TextDecoration.underline)),
          ),
        ],
      ],
    );
  }

  void _launchYoutube(String url) async {
    UtilApp.launchYoutubeVideo(url);
  }

  void _launchUrl(String url) async {
    UtilApp.launchUrlApp(url);
  }
}
