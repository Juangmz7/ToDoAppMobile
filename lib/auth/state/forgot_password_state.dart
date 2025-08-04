
import 'package:todo_app/shared/infrastructure/infrastructure.dart';

enum ForgotPasswordStatus {
  checking,
  emailSended,
  emailNotSended,
  tokenValidated,
  tokenNotValidated,
  passwordAcceptted,
  passwordNotAcceptted
}

class ForgotPasswordState {

  final ForgotPasswordStatus forgotPasswordStatus;
  final Password password;
  final String token;
  final String errorMessage;

  ForgotPasswordState({
    this.forgotPasswordStatus = ForgotPasswordStatus.checking,
    this.password = const Password.pure(),
    this.token = '',
    this.errorMessage = ''
  });

  ForgotPasswordState copyWith({
    ForgotPasswordStatus? forgotPasswordStatus,
    Password? password,
    String? token,
    String? errorMessage
  }) {
    return ForgotPasswordState(
      forgotPasswordStatus: forgotPasswordStatus ?? this.forgotPasswordStatus,
      password: password ?? this.password,
      token: token ?? this.token,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }
}