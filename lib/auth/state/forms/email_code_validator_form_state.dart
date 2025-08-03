

import 'package:todo_app/auth/state/state.dart';

class EmailCodeValidatorFormState extends FormState {

  final String token;
  final String errorMessage;

  EmailCodeValidatorFormState({
    this.token = '',
    this.errorMessage = '',
    super.isFormPosted,
    super.isPosting,
    super.isValid
  });

  EmailCodeValidatorFormState copyWith({
    String? token,
    String? errorMessage,
    bool? isFormPosted,
    bool? isPosting,
    bool? isValid,
  }) {
    return EmailCodeValidatorFormState(
      token: token ?? this.token,
      errorMessage: errorMessage ?? this.errorMessage,
      isFormPosted: isFormPosted ?? this.isFormPosted,
      isPosting: isPosting ?? this.isPosting,
      isValid: isValid ?? this.isValid,
    );
  }
  
}