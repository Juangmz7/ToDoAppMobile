import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:todo_app/auth/presentation/presentation.dart';
import 'package:todo_app/auth/state/forms/forms.dart';
import 'package:todo_app/shared/infrastructure/infrastructure.dart';

// This provider is used to manage the state of the change password form.
final changePasswordFormProvider = StateNotifierProvider<ChangePasswordFormNotier, ChangePasswordFormState>(
  (ref) => ChangePasswordFormNotier(
    changePasswordCallback: ref.watch(forgotPasswordProvider.notifier).changePassword,
  ),
);


class ChangePasswordFormNotier extends StateNotifier<ChangePasswordFormState> {
    final Function(String) changePasswordCallback;

    ChangePasswordFormNotier({
        required this.changePasswordCallback,
    }): super(ChangePasswordFormState());

    onPasswordChanged(String value) {

        final newPassword = Password.dirty(value);

        state = state.copyWith(
            password: newPassword,
            isValid: Formz.validate( [ newPassword, state.repeteadPassword ] )
        );

    }

    onRepeteatedPasswordChanged() {

        final newRepeteadPassword = Password.dirty(state.repeteadPassword.value);

        state = state.copyWith(
            repeteadPassword: newRepeteadPassword,

            // It is valid if both passwords match and are valid
            isValid: Formz.validate( [ state.password, newRepeteadPassword ] )
                        && state.password.value == newRepeteadPassword.value
        );

    }

    onFormSubmitted() {
        _touchEveryField();

        if (!state.isValid) return;

        state = state.copyWith(isPosting: true);

        changePasswordCallback(state.password.value);

        state = state.copyWith(isPosting: false);
    }

    _touchEveryField() {

        final password = Password.dirty(state.password.value);
        final repeteadPassword = Password.dirty(state.repeteadPassword.value);

        state = state.copyWith(
            password: password,
            repeteadPassword: repeteadPassword,
            isValid: Formz.validate([password, repeteadPassword]),
            isFormPosted: true,
        );

    }

}