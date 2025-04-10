import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:recipes_app/main.dart';

class NavApp {
  static void go(String path, {Map<String, dynamic> queryParameters = const {}}) {
    final context = rootNavKey.currentContext;
    if (context == null) {
      debugPrint('Error: No hay contexto disponible para navegar a $path');
      return;
    }
    context.go(Uri(path: path, queryParameters: queryParameters).toString());
  }

  static void pop<T extends Object?>([T? result]) {
    final context = rootNavKey.currentContext;
    if (context == null) {
      debugPrint('Error: No hay contexto disponible para hacer pop');
      return;
    }
    context.pop(result);
  }

  static void push(String path, {Map<String, String> pathParameters = const {}}) {
    final context = rootNavKey.currentContext;
    if (context == null) {
      debugPrint('Error: No hay contexto disponible para navegar a $path');
      return;
    }

    String finalPath = path;
    pathParameters.forEach((key, value) {
      finalPath = finalPath.replaceAll(':$key', value);
    });

    context.push(finalPath);
  }

  static void pushReplacement(String path, {Map<String, String> pathParameters = const {}}) {
    final context = rootNavKey.currentContext;
    if (context == null) {
      debugPrint('Error: No hay contexto disponible para navegar a $path');
      return;
    }
    String finalPath = path;
    pathParameters.forEach((key, value) {
      finalPath = finalPath.replaceAll(':$key', value);
    });

    context.pushReplacement(finalPath);
  }

  static String getFullPath() {
    final context = rootNavKey.currentContext;
    return GoRouter.of(context!).routerDelegate.currentConfiguration.fullPath;
  }
}