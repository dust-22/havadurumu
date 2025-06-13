import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String message, {Color? color}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: color ?? Theme.of(context).colorScheme.primary,
      duration: const Duration(seconds: 2),
    ),
  );
}