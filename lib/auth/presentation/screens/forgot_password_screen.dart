import 'package:flutter/material.dart';
import 'package:todo_app/auth/presentation/widgets/widgets.dart';


class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: const Scaffold(
        resizeToAvoidBottomInset: false,
        body: ForgotPasswordForm(),
      ),
    );
  }
}

