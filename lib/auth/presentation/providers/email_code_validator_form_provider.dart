


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/auth/presentation/providers/providers.dart';
import 'package:todo_app/auth/state/state.dart';

final emailCodeValidatorFormProvider = StateNotifierProvider.autoDispose<EmailCodeValidatorFormNotifier, EmailCodeValidatorFormState>(
  (ref) {

    final checkEmailTokenCallback = ref.watch(forgotPasswordProvider.notifier).checkEmailToken;

    return EmailCodeValidatorFormNotifier(checkEmailTokenCallback: checkEmailTokenCallback);

});

class EmailCodeValidatorFormNotifier extends StateNotifier<EmailCodeValidatorFormState> {

  final Function(String) checkEmailTokenCallback;

  EmailCodeValidatorFormNotifier({
    required this.checkEmailTokenCallback
  }):super(EmailCodeValidatorFormState());

   onTokenChanged( String value ) {

    state = state.copyWith(
      token: value,
      isValid: value.isNotEmpty && value.length > 6 
    );

    if ( state.isValid ) return;

    if ( value.isEmpty ) {
      _setErrorMessage('El código no puede estar vacío');
    } else if ( value.length < 6 ) {
      _setErrorMessage('El código debe tener al menos 6 caracteres');
    }

  }

  _setErrorMessage( String message ) {

    state = state.copyWith(
      errorMessage: message
    );
  }

  onFormSubmmit() async {
    
    _touchEveryField(); 

    if ( !state.isValid ) return;

    state = state.copyWith(
      isPosting: true
    );

    await checkEmailTokenCallback(state.token);

    state = state.copyWith(
      isPosting: false
    );
  }

  _touchEveryField() {

    onTokenChanged(state.token);

    state = state.copyWith(
      token: state.token,
      isFormPosted: true
    );
  }

}