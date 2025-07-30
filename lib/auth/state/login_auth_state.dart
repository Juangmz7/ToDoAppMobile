

import 'package:todo_app/auth/domain/enitites/user.dart';
import 'package:todo_app/auth/state/auth_state.dart';

class LoginAuthState extends AuthState {

  LoginAuthState ({
    super.authStatus,
    super.errorMessage,
    super.user,
  });

  LoginAuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage
  }) => LoginAuthState(
    authStatus: authStatus ?? this.authStatus,
    user: user ?? this.user,
    errorMessage: errorMessage ?? this.errorMessage 
  );

}