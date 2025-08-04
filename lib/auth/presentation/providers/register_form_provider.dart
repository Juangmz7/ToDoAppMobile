
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:todo_app/auth/presentation/providers/providers.dart';
import 'package:todo_app/auth/state/state.dart';
import 'package:todo_app/shared/infrastructure/inputs/inputs.dart';


 // Controls the state of the register form

final registerFormProvider = StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>(
    (ref) {

      final registerUserCallback = ref.watch(registerAuthProvider.notifier).registerUser;

      return RegisterFormNotifier(registerUserCallback);
      
    }
);

class RegisterFormNotifier extends StateNotifier<RegisterFormState> {

  final Function(String, String, String) registerUserCallback;

  RegisterFormNotifier(
      this.registerUserCallback
  ):super(RegisterFormState());

  onUsernameChanged( String value ) {
      
    final newUsername = Username.dirty(value);
    
    state = state.copyWith(
        username: newUsername,
        isValid: Formz.validate([ newUsername, state.password, state.email ])
    );

  }

  onPasswordChange( String value ) {
      
    final newPassword = Password.dirty(value);
    
    state = state.copyWith(
        password: newPassword,
        isValid: Formz.validate([ newPassword, state.username, state.email ])
    );

  }

  onEmailChanged( String value ) {
      
    final newEmail = Email.dirty(value);
    
    state = state.copyWith(
        email: newEmail,
        isValid: Formz.validate([ newEmail, state.password, state.username ])
    );

  }


  onFormSubmitted() async {

    _touchEveryField();

    if ( !state.isValid ) return;

    state = state.copyWith(
      isPosting: true
    );
    
    // Send the data to server
    await registerUserCallback(
        state.username.value,
        state.password.value,
        state.email.value,
    );
    
    state = state.copyWith(
      isPosting: false
    );

  }

  _touchEveryField() {

    final username = Username.dirty(state.username.value);
    final password = Password.dirty(state.password.value);
    final email = Email.dirty(state.email.value);

    // Toggle the form state to posted
    state = state.copyWith(
        email: email,
        isFormPosted: true,
        username: username,
        password: password,
        isValid: Formz.validate([ username, password, email ])
    );
      
  }

  
}


