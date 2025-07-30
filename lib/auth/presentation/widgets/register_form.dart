import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/auth/presentation/providers/providers.dart';
import 'package:todo_app/auth/presentation/widgets/widgets.dart';
import 'package:todo_app/auth/state/state.dart';
import 'package:todo_app/shared/functions/functions.dart';

class RegisterForm extends ConsumerWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final size = MediaQuery.of(context).size;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final textStyle = Theme.of(context).textTheme;
    final formProvider = ref.watch(registerFormProvider);

    // Shows an error message if not registrated properly
    // If it is, goes to register-succedeed
    ref.listen(registerAuthProvider, (previous, next) {
      
      if ( next.authStatus == AuthStatus.registrationSuccess ) {
        context.push('/register-succedeed');
      }

      if( next.errorMessage.isEmpty ||
          next.authStatus == AuthStatus.registrationSuccess ) {
        return;
      }

      showSnackbar( context, next.errorMessage );

    });

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: keyboardHeight + 10
      ),
      physics: const ClampingScrollPhysics(),
      child: Container(
        width: size.width*0.75,
        padding: EdgeInsets.only(top: 50),
        alignment: Alignment.center,
        child: Column(
          children: [
        
            Text('Register', style: textStyle.titleLarge),

            const SizedBox(height: 20),

            //* Username
            CustomTextFormField(
              labelText: 'Usuario',
              hintText: 'Introduce usuario',
              onChanged: ref.read(registerFormProvider.notifier).onUsernameChanged,
              errorMessage: formProvider.isFormPosted
                            ? formProvider.username.errorMessage
                            : null,
            ),

            const SizedBox(height: 20),

            //* Password
            CustomTextFormField(
              labelText: 'Contraseña',
              hintText: 'Introduzca contraseña',
              obscureText: true,
              onChanged: ref.read(registerFormProvider.notifier).onPasswordChange,
              errorMessage: formProvider.isFormPosted
                            ? formProvider.password.errorMessage
                            : null,
              
            ),

            const SizedBox(height: 20),

            //* Email
            CustomTextFormField(
              labelText: 'Email',
              hintText: 'Introduce email',
              onChanged: ref.read(registerFormProvider.notifier).onEmailChanged, 
              errorMessage: formProvider.isFormPosted
                            ? formProvider.email.errorMessage
                            : null,
            ),

            const SizedBox(height: 20),

            //* Submit button
            FilledButton(
              onPressed: formProvider.isPosting ? null
               : () {

                ref.read(registerFormProvider.notifier).onFormSubmitted();

                // The keyboard goes down to show the snackbar
                FocusManager.instance.primaryFocus?.unfocus();

              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(const Color.fromARGB(255, 47, 173, 223)), 
                foregroundColor: WidgetStatePropertyAll(Colors.white)
              ),
              child: const Text('Crear cuenta'),
            ),
          ],
        ),
      ),
    );
  }
}