
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:todo_app/auth/presentation/widgets/login_form.dart';
import 'package:todo_app/shared/widgets/geometrical_background.dart';


class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    return FadeIn(
      animate: true,
      duration: Duration(seconds: 1),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: const Scaffold(
          resizeToAvoidBottomInset: false, // To avoid the changes on size because of the keyboard
          body: GeometricalBackground(
            upperColor: Colors.deepPurple,
            downsideColor: Colors.deepPurple,
            child: LoginForm()
          ),
        ),
      ),
    );    
    
  }
}