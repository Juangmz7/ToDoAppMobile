

import 'package:todo_app/auth/domain/enitites/user.dart';

enum AuthStatus {
  authenticated,
  checking,
  notAuthenticated,
  registrationSuccess,
  registrationDenied,
}

class AuthState {

  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  // Default values
  AuthState({
    this.authStatus = AuthStatus.checking,
    this.user,
    this.errorMessage = ''
  });

}