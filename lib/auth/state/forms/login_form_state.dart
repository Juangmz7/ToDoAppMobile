

import 'package:todo_app/auth/state/state.dart' show FormState;
import 'package:todo_app/shared/infrastructure/inputs/inputs.dart';

class LoginFormState extends FormState {
  final Username username;
  final Password password;


  LoginFormState({
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    super.isFormPosted,
    super.isValid,
    super.isPosting
  });

  LoginFormState copyWith ({
    Username? username,
    Password? password,
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
  }) => LoginFormState(
    username: username ?? this.username,
    password: password ?? this.password,
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid
  );

  @override
  String toString() {
    return '''
  LoginFormState:
    isPosting: $isPosting
    isFormPosted: $isFormPosted
    isValid: $isValid
    username: $username
    password: $password
''';
  }
  
}