import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/auth/presentation/widgets/widgets.dart';



class RegisterSucceddedScreen extends StatefulWidget {
  const RegisterSucceddedScreen({super.key});

  @override
  State<RegisterSucceddedScreen> createState() => _RegisterSucceddedScreenState();
}

class _RegisterSucceddedScreenState extends State<RegisterSucceddedScreen> {
  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      duration: const Duration(milliseconds: 400),
      child: CustomSuccedeedScreen(
        title: 'Se ha registrado correctamente',
        animationPath: 'assets/animations/forgot_password_animation.json',
        redirectPath: '/login',
      )
    );
  }
}