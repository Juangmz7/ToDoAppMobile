import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final textStyle = Theme.of(context).textTheme;

    return Scaffold(
      body: Center(
        child: Text('Home screen', style: textStyle.titleMedium),
      ),
    );
  }
}