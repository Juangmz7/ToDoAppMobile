
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/auth/domain/enitites/user.dart';
import 'package:todo_app/auth/domain/infrastructure/repositories/user_repository_impl.dart';
import 'package:todo_app/auth/domain/repositories/user_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';



final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {

  final UserRepository userRepository = UserRepositoryImpl();

  return AuthNotifier(userRepository: userRepository);
});


enum AuthStatus { authenticated, checking, notAuthenticated }

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

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage
  }) => AuthState(
    authStatus: authStatus ?? this.authStatus,
    user: user ?? this.user,
    errorMessage: errorMessage ?? this.errorMessage 
  );
}



class AuthNotifier extends StateNotifier<AuthState>{

  final UserRepository userRepository;

  AuthNotifier({
    required this.userRepository
  }):super(AuthState());

  // User authentication
  Future<void> loginUser( String username, String password ) async {

    await Future.delayed(const Duration(milliseconds: 500));

    try {

      final String token = await userRepository.login(username, password);

      //ToDo: Fetch userRoles
      
      final user = User(
        username: username,
        password: password,
        token: token,
        roles: ['USER']
      );

      _setLoggedUser(user);

      // Token storage
      final tokenStorage = FlutterSecureStorage();
      await tokenStorage.write(key: 'token', value: token);

    }
    catch (e) {
      logout(e.toString());    
    }
  }

  // Creates a new authenticated state
  void _setLoggedUser( User user ) {
    state = state.copyWith(
      authStatus: AuthStatus.authenticated,
      user: user
    );
  }


  // checkAuthStatus
  Future<void> logout( String? errorMessage ) async {
    
    //ToDo: Logout del server
    
    // Token remove
    final tokenStorage = FlutterSecureStorage();
    tokenStorage.delete(key: 'token');

    // Update the state
    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      errorMessage: errorMessage
    );
    
  }

}