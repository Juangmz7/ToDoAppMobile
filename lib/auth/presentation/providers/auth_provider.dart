
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/auth/domain/enitites/user.dart';
import 'package:todo_app/auth/domain/infrastructure/repositories/user_repository_impl.dart';
import 'package:todo_app/auth/domain/repositories/user_repository.dart';


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
    }
    catch (e) {
      //logout('Error login : $e');
      print('Error login : $e');
    }
  }

  // Creates a new authenticated state
  void _setLoggedUser( User user ) {
    state.copyWith(
      authStatus: AuthStatus.authenticated,
      user: user
    );

    //! Token storage
  }


  // checkAuthStatus
  Future<void> logout( String? errorMessage ) async {}

}