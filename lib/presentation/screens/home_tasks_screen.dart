import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/auth/presentation/providers/providers.dart';

class HomeTasksScreen extends ConsumerWidget {
  const HomeTasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final textStyle = Theme.of(context).textTheme;


    return Scaffold(
      body: Center(
        child: FilledButton(
          onPressed: () => ref.read(loginAuthProvider.notifier).logout(),
          child: Text('Task screen', style: textStyle.titleMedium)
        ),
      ),
    );
  }
}