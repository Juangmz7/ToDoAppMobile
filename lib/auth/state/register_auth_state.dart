

import 'package:todo_app/auth/state/auth_state.dart';

class RegisterAuthState extends AuthState {

  RegisterAuthState ({
    super.authStatus,
    super.errorMessage,
  });

  RegisterAuthState copyWith({
    AuthStatus? authStatus,
    String? errorMessage
  }) => RegisterAuthState(
    authStatus: authStatus ?? this.authStatus,
    errorMessage: errorMessage ?? this.errorMessage 
  );
  
}