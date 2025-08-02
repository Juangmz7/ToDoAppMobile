import 'package:formz/formz.dart';

// Define input validation errors
enum UsernameError { empty, tooShort }

// Extend FormzInput and provide the input type and error type.
class Username extends FormzInput<String, UsernameError> {

  // Call super.pure to represent an unmodified form input.
  const Username.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Username.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == UsernameError.empty) return 'El nombre de usuario es requerido';
    if (displayError == UsernameError.tooShort) return 'Debe tener al menos 4 caracteres';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  UsernameError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return UsernameError.empty;
    if (value.trim().length < 4) return UsernameError.tooShort;

    return null;
  }
}
