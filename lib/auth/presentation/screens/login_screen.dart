
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/auth/presentation/providers/auth_provider.dart';
import 'package:todo_app/auth/presentation/widgets/login_form.dart';


class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
        
    // return GestureDetector(
    //   onTap: FocusManager.instance.primaryFocus?.unfocus,
    //   child: Scaffold(
    //     body: LoginForm(),
    //   ),
    // );

    // final provider = ref.watch(authProvider.notifier).loginUser('admin', '1234');
    final provider = ref.watch(authProvider.notifier);

    return Scaffold(
      body: Center(
        child: FilledButton(
          child: Text('Login'),
          onPressed: () => provider.loginUser('admin', 'adminpass'),
        ),
      ),
    );
    
  }
}