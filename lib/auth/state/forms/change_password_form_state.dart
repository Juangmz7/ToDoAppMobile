
import 'package:todo_app/auth/state/forms/form_state.dart';
import 'package:todo_app/shared/infrastructure/inputs/inputs.dart';

class ChangePasswordFormState extends FormState {
  
  final Password password;
  final Password repeteadPassword;
  final String? errorMessage;

  ChangePasswordFormState({
    super.isPosting,
    super.isFormPosted,
    super.isValid,
    this.password = const Password.pure(),
    this.repeteadPassword = const Password.pure(),
    this.errorMessage = '',
  });

  ChangePasswordFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Password? password,
    Password? repeteadPassword,
  }) {
    return ChangePasswordFormState(
      isPosting: isPosting ?? this.isPosting,
      isFormPosted: isFormPosted ?? this.isFormPosted,
      isValid: isValid ?? this.isValid,
      password: password ?? this.password,
      repeteadPassword: repeteadPassword ?? this.repeteadPassword,
    );
  }

}