
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/auth/presentation/presentation.dart';


import 'package:todo_app/auth/state/state.dart';
import 'package:todo_app/presentation/widgets/custom_circular_progress_indicator.dart';
import 'package:todo_app/shared/shared.dart';

class LoginForm extends ConsumerWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final formProvider = ref.watch(loginFormProvider);

    // Shows an error message if not authenticated properly
    ref.listen(loginAuthProvider, (previous, next) {
      
      if ( next.authStatus == AuthStatus.authenticated ) {
        context.push('/home-tasks');
        return;
      }
      
      if( next.errorMessage.isEmpty ||
          next.authStatus == AuthStatus.authenticated ) {
        return;
      }

      showSnackbar( context, next.errorMessage );

    });

    return SingleChildScrollView(
      padding: EdgeInsets.only(    // To scroll up the form
        top: 0,
        bottom: keyboardHeight + 10
      ),
      physics: const ClampingScrollPhysics(),
      child: Container(
        margin: EdgeInsets.only(top: 50),
        width: size.width*0.75,
        alignment: Alignment.center,
        child: Column(
          children: [

            Text('Login', style: textStyle.titleLarge),

            const SizedBox(height: 20,),

            //* Username form
            CustomTextFormField(
              hintText: 'Introduce usuario',
              onChanged: ref.read(loginFormProvider.notifier).onUsernameChanged,
              labelText: 'Usuario',
              errorMessage: formProvider.isFormPosted
                            ? formProvider.username.errorMessage
                            : null,
            ),
      
            const SizedBox(height: 20),

            //* Password form
            CustomTextFormField(
              hintText: 'Introduce contraseña',
              onChanged: ref.read(loginFormProvider.notifier).onPasswordChanged,
              obscureText: true,
              labelText: 'Contraseña',
              errorMessage: formProvider.isFormPosted
                            ? formProvider.password.errorMessage
                            : null,
            ),

            const SizedBox(height: 10),

            FilledButton(
              onPressed: formProvider.isPosting ? null : () {
                
                ref.read(loginFormProvider.notifier).onFormSubmitted();

                // The keyboard goes down to show the snackbar
                FocusManager.instance.primaryFocus?.unfocus(); 

              },
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.deepPurple), 
                foregroundColor: WidgetStatePropertyAll(Colors.white)
              ),
              child: formProvider.isPosting ?
                      const CustomCircularProgressIndicator()
                    : const Text('Ingresar')
            ),


            //* Redirection to forgot_password screen
            TextButton(
              onPressed: () => context.push('/forgot-password'), 
              child: Text('¿Olvidaste tu contraseña?', style: textStyle.titleSmall)
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                
                Text('¿Aún no tienes cuenta?', style: textStyle.titleSmall),

                //* Redirection to register_screen
                TextButton(
                  onPressed: () => context.push('/register'), 
                  child: Text('Regístrate aquí!', style: TextStyle(color: Colors.blue))
                )

              ],
            )
          ],
        ),
      ),
    );
  }
}