
import 'package:todo_app/shared/infrastructure/infrastructure.dart';

enum ForgotPasswordStatus {
  checking,
  codeValidated,
  codeNotValidated,
  passwordAcceptted,
  passwordNotAcceptted
}

class ForgotPasswordState {

  final ForgotPasswordStatus forgotPasswordStatus;
  final Password password;
  final int token;

  ForgotPasswordState({
    this.forgotPasswordStatus = ForgotPasswordStatus.checking,
    this.password = const Password.pure(),
    this.token = 0
  });

  ForgotPasswordState copyWith({
    ForgotPasswordStatus? forgotPasswordStatus,
    Password? password,
    int? token,
  }) {
    return ForgotPasswordState(
      forgotPasswordStatus: forgotPasswordStatus ?? this.forgotPasswordStatus,
      password: password ?? this.password,
      token: token ?? this.token,
    );
  }
}