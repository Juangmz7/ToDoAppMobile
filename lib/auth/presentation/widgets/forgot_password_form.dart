import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/auth/presentation/providers/forgot_password_form_provider.dart';
import 'package:todo_app/auth/presentation/widgets/widgets.dart';
import 'package:todo_app/config/config.dart';
import 'package:todo_app/shared/shared.dart';

class ForgotPasswordForm extends ConsumerStatefulWidget {
  const ForgotPasswordForm({
    super.key,
  });

  @override
  ConsumerState<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends ConsumerState<ForgotPasswordForm> {
  @override
  Widget build(BuildContext context) {

    final textStyle = Theme.of(context).textTheme;
    final textButtomColor = Theme.of(context).scaffoldBackgroundColor;
    final size = MediaQuery.of(context).size;
    final forgotPasswordForm = ref.watch(forgotPasswordFormProvider);

    return GeometricalBackground(
      upperColor: Colors.white,
      downsideColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              
            Text('Recupera tu contraseña', style: textStyle.titleMedium),
              
            const SizedBox(height: 20),
              
            CustomTextFormField(
              labelText: 'Email',
              hintText: 'Introduce email',
              onChanged: ref.read(forgotPasswordFormProvider.notifier).onEmailChanged,
              errorMessage: forgotPasswordForm.isFormPosted
                            ? forgotPasswordForm.email.errorMessage
                            : null,
            ),
            
            
            const SizedBox(height: 10),
            
            //* Subbmit button
            FilledButton(
              style: ButtonStyle(
                foregroundColor: WidgetStatePropertyAll(textButtomColor),
                backgroundColor: WidgetStatePropertyAll(Colors.white)
              ),
              onPressed: forgotPasswordForm.isPosting ? null
               : () {
                
                // Hide the keyboard
                FocusManager.instance.primaryFocus?.unfocus();
                
                // Subbmit
                ref.read(forgotPasswordFormProvider.notifier).onFormSubmitted();
        
              },
              child: Text('Enviar'),
            ),

            const SizedBox(height: 40),
              
              
            //* Container
            forgotPasswordForm.isFormSended ?
        
            FadeIn(
              animate: true,
              duration: Duration(seconds: 1),
              delay: Duration(seconds: 1),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(size.width*0.05),
                      
                    ),
                    child: Text(
                      'Si la dirección de email es correcta, se le enviará un código de confirmación.',
                      style: TextStyle(
                        fontFamily: textStyle.titleSmall?.fontFamily,
                        color: scaffoldBackgroundColor
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextButton(
                    onPressed: () => context.push('/forgot-password/code-verification'),
                    child: Text(
                      'Verificar código',
                      style: TextStyle(
                        fontFamily: textStyle.titleSmall?.fontFamily,
                        color: const Color.fromARGB(255, 30, 171, 247)
                      )
                    )
                  )
                ],
              ),
            )
        
            : SizedBox(),
            
          ],
        ),
      ),
    );
  }
}