
import 'package:todo_app/shared/infrastructure/inputs/email.dart';

class ForgotPasswordState {
  
  final Email email;
  final String errorMessage;
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;

  ForgotPasswordState({
    this.email = const Email.pure(),
    this.errorMessage = '',
    this.isFormPosted = false,
    this.isPosting = false,
    this.isValid = false
  });


}