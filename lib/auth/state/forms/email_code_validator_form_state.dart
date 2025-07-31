

import 'package:todo_app/auth/state/state.dart';

class EmailCodeValidatorFormState extends FormState {

  final double token;

  EmailCodeValidatorFormState({
    required this.token,
    super.isFormPosted,
    super.isPosting,
    super.isValid
  });

  EmailCodeValidatorFormState copyWith({
    double? token,
    bool? isFormPosted,
    bool? isPosting,
    bool? isValid,
  }) {
    return EmailCodeValidatorFormState(
      token: token ?? this.token,
      isFormPosted: isFormPosted ?? this.isFormPosted,
      isPosting: isPosting ?? this.isPosting,
      isValid: isValid ?? this.isValid,
    );
  }
  
}