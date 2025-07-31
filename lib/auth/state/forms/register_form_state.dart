


import 'package:todo_app/shared/infrastructure/inputs/inputs.dart';

import 'form_state.dart';

class RegisterFormState extends FormState {

    final Username username;
    final Password password;
    final Email email;

  RegisterFormState({
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.email = const Email.pure(),
    super.isFormPosted,
    super.isPosting,
    super.isValid
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