import 'package:flutter/material.dart';



void showSnackbar( BuildContext context, String message, [ Color? color ] ) {

  final textStyle = Theme.of(context).textTheme.titleSmall;
  
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: textStyle),
      duration: const Duration(seconds: 3),
      backgroundColor: color ?? Colors.red,
    )
  );
}