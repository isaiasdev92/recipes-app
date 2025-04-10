import 'package:flutter/material.dart';
import 'package:recipes_app/main.dart';

void showSnackbar(String message) {
  ScaffoldMessenger.of(rootNavKey.currentContext!).showSnackBar(SnackBar(content: Text(message), action: SnackBarAction(label: 'CERRAR', onPressed: () {})));
}
