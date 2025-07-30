

import 'package:todo_app/shared/infrastructure/inputs/inputs.dart';

class LoginFormState {
  final Username username;
  final Password password;
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;

  LoginFormState({
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false
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