
import 'package:todo_app/shared/infrastructure/inputs/email.dart';

class ForgotPasswordFormState {
  
  final Email email;
  final String errorMessage;
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final bool isFormSended;

  ForgotPasswordFormState({
    this.email = const Email.pure(),
    this.errorMessage = '',
    this.isFormPosted = false,
    this.isPosting = false,
    this.isValid = false,
    this.isFormSended = false
  });

  ForgotPasswordFormState copyWith({
    Email? email,
    String? errorMessage,
    bool? isFormPosted,
    bool? isPosting,
    bool? isValid,
    bool? isFormSended
  }) {
    return ForgotPasswordFormState(
      email: email ?? this.email,
      errorMessage: errorMessage ?? this.errorMessage,
      isFormPosted: isFormPosted ?? this.isFormPosted,
      isPosting: isPosting ?? this.isPosting,
      isValid: isValid ?? this.isValid,
      isFormSended: isFormSended ?? this.isFormSended
    );
  }


}