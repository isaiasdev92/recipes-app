import 'package:flutter/material.dart';
import 'package:recipes_app/main.dart';

void showSnackbar(String message) {
  final scaffold = ScaffoldMessenger.of(rootNavKey.currentContext!);
  scaffold.clearSnackBars();

  ScaffoldMessenger.of(rootNavKey.currentContext!).showSnackBar(SnackBar(content: Text(message),));
}
