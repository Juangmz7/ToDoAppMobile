

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:todo_app/auth/presentation/presentation.dart';
import 'package:todo_app/auth/state/forms/forgot_password_form_state.dart';
import 'package:todo_app/shared/shared.dart';

final forgotPasswordFormProvider = StateNotifierProvider.autoDispose<ForgotPasswordFormNotifier, ForgotPasswordFormState>(
  (ref) {

    // Forgot password server communication
    final forgotPasswordCallBack = ref.watch(forgotPasswordProvider.notifier).forgotPassword;

    return ForgotPasswordFormNotifier(forgotPasswordCallBack);

  });


class ForgotPasswordFormNotifier extends StateNotifier<ForgotPasswordFormState> {

  final Function(String) forgotPasswordCallBack;

  ForgotPasswordFormNotifier(this.forgotPasswordCallBack)
    :super(ForgotPasswordFormState());

  onEmailChanged( String value ) {
    
    final newEmail = Email.dirty(value);

    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate( [ newEmail ] )
    );

  }

  onFormSubmitted() async {
    _touchEveryField();

    if( !state.isValid ) return;

    state = state.copyWith(
      isPosting: true,
      isFormSended: true
    );

    await forgotPasswordCallBack(state.email.value);

    state = state.copyWith(isPosting: false);
  }

  _touchEveryField() {
    
    final email = Email.dirty(state.email.value);

    state = state.copyWith(
      email: email,
      isFormPosted: true
    );
  }

}