
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/auth/presentation/widgets/login_form.dart';
import 'package:todo_app/shared/widgets/geometrical_background.dart';


class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false, // To avoid the changes on size because of the keyboard
        body: GeometricalBackground(
          upperColor: Colors.deepPurple,
          downsideColor: Colors.deepPurple,
          child: LoginForm()
        ),
      ),
    );    
    
  }
}