
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:todo_app/auth/domain/domain.dart';
import 'package:todo_app/auth/state/state.dart';
import 'package:todo_app/shared/functions/format_exception.dart';
import 'package:todo_app/shared/shared.dart';



final loginAuthProvider = StateNotifierProvider<LoginAuthNotifier, LoginAuthState>((ref) {

  final UserRepository userRepository = UserRepositoryImpl();

  return LoginAuthNotifier(userRepository: userRepository);
});



class LoginAuthNotifier extends StateNotifier<LoginAuthState>{

  final UserRepository userRepository;

  LoginAuthNotifier({
    required this.userRepository
  }):super(LoginAuthState());

  // User authentication
  Future<void> loginUser( String username, String password ) async {

    await Future.delayed(const Duration(milliseconds: 500));

    try {

      final String token = await userRepository.login(username, password);
      
      final user = User(
        username: username,
        password: password,
        token: token,
        roles: ['USER']
      );

      _setLoggedUser(user);

      // Token storage
      await SecureStorageHandler.saveToken(token);

      // User details storage
      await SecureStorageHandler.saveUser(username, password);

    }
    catch (e) {
      _setUserNotAuthenticated(formatException(e.toString()));    
    }
  }

  // Creates a new authenticated state
  void _setLoggedUser( User user ) {
    state = state.copyWith(
      authStatus: AuthStatus.authenticated,
      user: user
    );
  }

  void _setUserNotAuthenticated( [ String? errorMessage ]) {

    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      errorMessage: errorMessage
    );
    
  }

  // checkAuthStatus
  Future<void> logout( [String? errorMessage] ) async {
    
    try {

      // Logout from server
      await userRepository.logout();
      _setUserNotAuthenticated();

    } catch (e) {

      state = state.copyWith(
        errorMessage: e.toString()
      );

    }


  }

}