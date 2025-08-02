
import 'package:flutter/material.dart';
import 'package:todo_app/auth/presentation/presentation.dart';

class ChangePasswordForm extends StatelessWidget {
  const ChangePasswordForm({super.key});

  @override
  Widget build(BuildContext context) {

    final textStyle = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          Text('Nueva contraseña', style: textStyle.titleMedium),

          const SizedBox(height: 20),

          CustomTextFormField(
            labelText: 'Contraseña',
            hintText: 'Introduzca contraseña',
            obscureText: true,
            onChanged: null,
            errorMessage: null,
          ),

          const SizedBox(height: 20),

          CustomTextFormField(
            labelText: 'Repetir contraseña',
            hintText: 'Repita la contraseña',
            obscureText: true,
            onChanged: null,
            errorMessage: null,
          ),

          const SizedBox(height: 20),
          
          FilledButton(
            onPressed: null,
            child: Text('Enviar', style: textStyle.titleSmall,)
          ),

        ],
      ),
    );
  }
}