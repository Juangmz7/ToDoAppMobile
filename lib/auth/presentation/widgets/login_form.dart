
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/auth/presentation/providers/providers.dart';
import 'package:todo_app/auth/presentation/widgets/custom_text_form_field.dart';

class LoginForm extends ConsumerWidget {
  const LoginForm({super.key});

    void showSnackbar( BuildContext context, String message ) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message))
      );
    }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    final formProvider = ref.watch(loginFormProvider);

    // Shows an error message if not authenticated properly
    ref.listen(authProvider, (previous, next) {
      // Navegation to home screen
      if ( next.authStatus == AuthStatus.authenticated ) {
        context.go('/tasks');
      }

      if ( next.errorMessage.isEmpty ) return;
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

            Text('Login', style: textStyle.titleMedium),

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
                backgroundColor: WidgetStateProperty.all(Colors.deepPurple), 
                foregroundColor: WidgetStatePropertyAll(Colors.white)
              ),
              child: const Text('Ingresar'),
            ),


            //* Redirection to forgot_password screen
            TextButton(
              onPressed: () {}, //ToDo
              child: Text('¿Olvidaste tu contraseña?', style: textStyle.titleSmall)
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                
                Text('¿Aún no tienes cuenta?', style: textStyle.titleSmall),

                //* Redirection to register_screen
                TextButton(
                  onPressed: () {}, //ToDo
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