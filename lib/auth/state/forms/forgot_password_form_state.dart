
import 'package:todo_app/shared/infrastructure/inputs/email.dart';

class ForgotPasswordState {
  
  final Email email;
  final String errorMessage;
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final bool isFormSended;

  ForgotPasswordState({
    this.email = const Email.pure(),
    this.errorMessage = '',
    this.isFormPosted = false,
    this.isPosting = false,
    this.isValid = false,
    this.isFormSended = false
  });

  ForgotPasswordState copyWith({
    Email? email,
    String? errorMessage,
    bool? isFormPosted,
    bool? isPosting,
    bool? isValid,
    bool? isFormSended
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      errorMessage: errorMessage ?? this.errorMessage,
      isFormPosted: isFormPosted ?? this.isFormPosted,
      isPosting: isPosting ?? this.isPosting,
      isValid: isValid ?? this.isValid,
      isFormSended: isFormSended ?? this.isFormSended
    );
  }


}