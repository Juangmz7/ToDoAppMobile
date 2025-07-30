import 'package:flutter/material.dart';
import 'package:todo_app/auth/presentation/presentation.dart';
import 'package:todo_app/shared/shared.dart';


class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final textStyle = Theme.of(context).textTheme;
    final textButtomColor = Theme.of(context).scaffoldBackgroundColor;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: GeometricalBackground(
          upperColor: Colors.white,
          downsideColor: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                
              Text('Recupera tu contraseña', style: textStyle.titleMedium),
                
              const SizedBox(height: 20),
                
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: CustomTextFormField(
                  labelText: 'Email',
                  hintText: 'Introduce email',
                )
              ),


              const SizedBox(height: 10),

              //* Subbmit button
              FilledButton(
                style: ButtonStyle(
                  foregroundColor: WidgetStatePropertyAll(textButtomColor),
                  backgroundColor: WidgetStatePropertyAll(Colors.white)
                ),
                onPressed: null,
                child: Text('Enviar'),
              )
                
                
              //* Container
            ],
          ),
        ),
      ),
    );
  }
}