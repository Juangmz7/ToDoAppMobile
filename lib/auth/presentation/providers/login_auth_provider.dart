
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/auth/domain/enitites/user.dart';
import 'package:todo_app/auth/domain/infrastructure/repositories/user_repository_impl.dart';
import 'package:todo_app/auth/domain/repositories/user_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:todo_app/auth/state/state.dart';



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

      //TODO: Fetch userRoles
      
      final user = User(
        username: username,
        password: password,
        token: token,
        roles: ['USER']
      );

      _setLoggedUser(user);

      // Token storage
      final tokenStorage = FlutterSecureStorage();
      
      // Also removes if there is an old token
      await tokenStorage.write(key: 'token', value: token);

    }
    catch (e) {
      _setUserNotAuthenticated(e.toString());    
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

    } catch (e) {
      throw Exception('Server logout failed: $e');
    }

    _setUserNotAuthenticated();

  }

  // Sends the user email 
  Future<void> forgotPassword( String email ) async {
    
    try {

      await userRepository.forgotPassword(email);

    } catch (e) {
      throw Exception('Error al enviar email: $e');
    }
    
  }

}