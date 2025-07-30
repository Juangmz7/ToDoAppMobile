import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/auth/presentation/widgets/widgets.dart';
import 'package:todo_app/shared/widgets/widgets.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      animate: true,
      duration: Duration(seconds: 1),
      //curve: Curves.bounceIn,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false, // To avoid the changes on size because of the keyboard
          body: GeometricalBackground(
            upperColor: const Color.fromARGB(255, 47, 173, 223),
            downsideColor: const Color.fromARGB(255, 36, 175, 199),
            child: RegisterForm()
          ),
        ),
      ),
    );
  }
}