import 'package:get_it/get_it.dart';
import 'package:recipes_app/features/recipes/injection_recipe.dart';

final sl = GetIt.instance;

Future<void> configGetIt() async {
  initInjectionRecipe();
}