

abstract class FormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;

  FormState({

    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false
  });

  @override
  String toString() {
    return '''
  LoginFormState:
    isPosting: $isPosting
    isFormPosted: $isFormPosted
    isValid: $isValid
''';
  }
  
}