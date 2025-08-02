import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/auth/presentation/presentation.dart';
import 'package:todo_app/auth/state/forgot_password_state.dart';
import 'package:todo_app/shared/functions/show_snackbar.dart';


class EmailCodeVerificationScreen extends ConsumerStatefulWidget {
  const EmailCodeVerificationScreen({super.key});

  @override
  ConsumerState<EmailCodeVerificationScreen> createState() => _EmailCodeVerificationScreenState();
}

class _EmailCodeVerificationScreenState extends ConsumerState<EmailCodeVerificationScreen> {
  @override
  Widget build(BuildContext context) {

    bool isTokenValid = false;

    ref.listen(forgotPasswordProvider, (previous, next) async {

      //* Listener for Token changes
      if ( next.forgotPasswordStatus == ForgotPasswordStatus.tokenNotValidated ) {
        showSnackbar(context, next.errorMessage);
        return;
      }

      if ( next.forgotPasswordStatus == ForgotPasswordStatus.tokenValidated ) {
        isTokenValid = true;
        return;
      }
      
      //* Listener for password send
      if ( next.forgotPasswordStatus == ForgotPasswordStatus.passwordAcceptted ) {
        
        // Navigate to login page after successful password change
        context.push('/auth/login');
        ref.read(changePasswordFormProvider.notifier).resetForm();
        ref.read(forgotPasswordFormProvider.notifier).resetForm();
        return;

      }

      if ( next.forgotPasswordStatus == ForgotPasswordStatus.passwordNotAcceptted ) {
        
        showSnackbar(context, 'Error al cambiar la contraseña: ${next.errorMessage}');
        return;
       
      }

    });


    return FadeInRight(
      duration: const Duration(milliseconds: 400),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: EdgeInsets.symmetric( vertical: 200 ),
            child: Column(
              children: [
      
                // If code is not valid, it shows code form
                // If it is, it shows new password form
      
                isTokenValid ?
                const ChangePasswordForm()
                : const ForgotPasswordTokenVerificationForm()
      
              ],
            ),
          ),
        ),
      ),
    );
    
  }
}

