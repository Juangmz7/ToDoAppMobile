
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:todo_app/auth/presentation/providers/providers.dart';
import 'package:todo_app/auth/state/state.dart';
import 'package:todo_app/shared/shared.dart';

 // Makes the login request based on the form content
final loginFormProvider = StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormState>(
  (ref) {
  
  final loginUserCallback = ref.watch(loginAuthProvider.notifier).loginUser; 

  return LoginFormNotifier(loginUserCallback);

});


class LoginFormNotifier extends StateNotifier<LoginFormState>{

  final Function(String, String) loginUserCallback;

  LoginFormNotifier(this.loginUserCallback):super(LoginFormState());

  onUsernameChanged(String value) {
    final newUsername = Username.dirty(value);

    state = state.copyWith(
      username: newUsername,
      isValid: Formz.validate([ newUsername, state.password ])
    );

  }

  onPasswordChanged(String value) {
    final newPassword = Password.dirty(value);

    state = state.copyWith(
      password: newPassword,
      isValid: Formz.validate([ newPassword, state.username ])
    );
  }

  onFormSubmitted() async {
    _touchEveryField();

    // Invalid more requests if it is not valid
    if ( !state.isValid ) return;

     state = state.copyWith(
      isPosting: true
    );
    // Login request to server
    await loginUserCallback(state.username.value, state.password.value);

    // Time to wait for get another request
    await Future.delayed(const Duration(milliseconds: 500));

    state = state.copyWith(
      isPosting: false
    );

  }

  // from pure to dirty
  _touchEveryField() {

    final username = Username.dirty(state.username.value);
    final password = Password.dirty(state.password.value);

    state = state.copyWith(
      isFormPosted: true,
      username: username,
      password: password,
      isValid: Formz.validate([ username, password ])
    );

  } 

  resetForm() {
      state = LoginFormState();
    }
}


