
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:todo_app/auth/presentation/providers/providers.dart';
import 'package:todo_app/shared/shared.dart';

 // Makes the login request based on the form content
final loginFormProvider = StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormState>((ref) {
  
  final loginUserCallback = ref.watch(authProvider.notifier).loginUser; 

  return LoginFormNotifier(loginUserCallback);

});


class LoginFormNotifier extends StateNotifier<LoginFormState>{

  final Function(String, String) loginUserCallback;

  LoginFormNotifier(this.loginUserCallback):super(LoginFormState());

  onUsernameChanged(String value) {
    final newUsername = Username.dirty(value);

    // New State
    state = state.copyWith(
      username: newUsername,
      isValid: Formz.validate([ newUsername, state.password ])
    );

  }

  // On password changed
  onPasswordChanged(String value) {
    final newPassword = Password.dirty(value);

    // New state
    state = state.copyWith(
      password: newPassword,
      isValid: Formz.validate([ newPassword, state.username ])
    );
  }

  // On form submitted
  onFormSubmitted() async {
    _touchEveryField();

    // Invalid more requests if it is posting
    if ( !state.isValid ) return;

     state = state.copyWith(
      isPosting: true
    );
    // Login request to server
    await loginUserCallback(state.username.value, state.password.value);

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


}


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