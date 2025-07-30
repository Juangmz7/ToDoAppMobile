


import 'package:todo_app/shared/infrastructure/inputs/inputs.dart';

class RegisterFormState {

    final Username username;
    final Password password;
    final Email email;
    final bool isPosting;
    final bool isFormPosted;
    final bool isValid;

  RegisterFormState({
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.email = const Email.pure(),
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false
   });

   RegisterFormState copyWith({
        Username? username,
        Password? password,
        Email? email,
        bool? isPosting,
        bool? isFormPosted,
        bool? isValid
   }) => RegisterFormState(
        username: username ?? this.username,
        password: password ?? this.password,
        email: email ?? this.email,
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid
    );
}