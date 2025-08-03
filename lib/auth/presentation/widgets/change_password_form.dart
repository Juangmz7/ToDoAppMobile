
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/auth/presentation/presentation.dart';

class ChangePasswordForm extends ConsumerWidget {
  const ChangePasswordForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final textStyle = Theme.of(context).textTheme;
    final changePasswordForm = ref.watch(changePasswordFormProvider);

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
            onChanged: ref.read(changePasswordFormProvider.notifier).onPasswordChanged,
            errorMessage: changePasswordForm.password.errorMessage,
          ),

          const SizedBox(height: 20),

          CustomTextFormField(
            labelText: 'Repetir contraseña',
            hintText: 'Repita la contraseña',
            obscureText: true,
            onChanged: ref.read(changePasswordFormProvider.notifier).onRepeteatedPasswordChanged,

            // Show error message if passwords do not match
            errorMessage: changePasswordForm.isFormPosted ?
                            ref.read(changePasswordFormProvider.notifier).passwordsMatch() ? 
                              changePasswordForm.repeteadPassword.errorMessage : 
                             'Las contraseñas no coinciden'
                            : null,
                            
          ),

          const SizedBox(height: 20),
          
          FilledButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Theme.of(context).primaryColor),
            ),
            onPressed: changePasswordForm.isPosting ? null : () {
              
              // Dismiss the keyboard when the button is pressed
              FocusManager.instance.primaryFocus?.unfocus();
              
              ref.read(changePasswordFormProvider.notifier).onFormSubmitted();

            },
            child: Text('Enviar', style: textStyle.titleSmall,)
          ),
        ],
      ),
    );
  }
}