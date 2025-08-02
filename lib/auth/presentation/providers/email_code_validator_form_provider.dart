


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/auth/presentation/providers/providers.dart';
import 'package:todo_app/auth/state/state.dart';

final emailCodeValidatorFormProvider = StateNotifierProvider<EmailCodeValidatorFormNotifier, EmailCodeValidatorFormState>(
  (ref) {

    final checkEmailTokenCallback = ref.watch(forgotPasswordProvider.notifier).checkEmailToken;

    return EmailCodeValidatorFormNotifier(checkEmailTokenCallback: checkEmailTokenCallback);

});

class EmailCodeValidatorFormNotifier extends StateNotifier<EmailCodeValidatorFormState> {

  final Function(int) checkEmailTokenCallback;

  EmailCodeValidatorFormNotifier({
    required this.checkEmailTokenCallback
  }):super(EmailCodeValidatorFormState());

   onTokenChanged( int value ) {

    state = state.copyWith(
      token: value,
      isValid: !value.isNegative && !value.isNaN 
    );

    if ( !state.isValid ) {
      state = state.copyWith(
        errorMessage: 'Code must be a possitive integer number'
      );
    }

  }

  onFormSubmmit() {
    
    state = state.copyWith(
      isFormPosted: true,
    ); 

    if ( !state.isValid ) return;

    state = state.copyWith(
      isPosting: true
    );

    checkEmailTokenCallback(state.token);

    state = state.copyWith(
      isPosting: false
    );
  }

}