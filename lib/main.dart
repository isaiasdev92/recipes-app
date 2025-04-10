import 'package:flutter/material.dart';
import 'package:recipes_app/core/get_instances/get_config.dart';
import 'package:recipes_app/core/hive/hive_app.dart';
import 'package:recipes_app/core/routes/routes_app.dart';

final GlobalKey<NavigatorState> rootNavKey = GlobalKey<NavigatorState>(debugLabel: 'root');
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveApp.init();
  await configGetIt();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(title: 'Flutter Demo', theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)), routerConfig: routes);
  }
}
