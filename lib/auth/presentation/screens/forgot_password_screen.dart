import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/auth/presentation/widgets/widgets.dart';


class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return FadeInRight(
      duration: const Duration(milliseconds: 400),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: const Scaffold(
          resizeToAvoidBottomInset: false,
          body: ForgotPasswordForm(),
        ),
      ),
    );
  }
}

