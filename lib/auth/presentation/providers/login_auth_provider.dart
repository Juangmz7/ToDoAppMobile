
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:todo_app/auth/domain/domain.dart';
import 'package:todo_app/auth/state/state.dart';
import 'package:todo_app/config/config.dart';
import 'package:todo_app/shared/shared.dart';



final loginAuthProvider = StateNotifierProvider<LoginAuthNotifier, LoginAuthState>((ref) {

  final UserRepository userRepository = UserRepositoryImpl();
  final flutterSecureStorage = const FlutterSecureStorage();

  return LoginAuthNotifier(
    userRepository: userRepository,
    flutterSecureStorage: flutterSecureStorage,
    ref: ref
  );
});



class LoginAuthNotifier extends StateNotifier<LoginAuthState>{

  final UserRepository userRepository;
  final FlutterSecureStorage flutterSecureStorage;
  final Ref ref;

  LoginAuthNotifier({
    required this.userRepository,
    required this.flutterSecureStorage,
    required this.ref
  }):super(LoginAuthState()) {
    // Check if the user is authenticated when the notifier is created
    checkAuthStatus();
  }

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
    
     // Sets the state to authenticated
     await _setLoggedUser(user);

     // Saves user and token into the state
     await _saveUserCredentials(user);

    }
    catch (e) {
      _setUserNotAuthenticated(formatException(e.toString()));    
    }
  }

  // Creates a new authenticated state
  Future<void> _setLoggedUser( User user ) async {
    state = state.copyWith(
      authStatus: AuthStatus.authenticated,
      user: user
    );

    // Updates the router provider state
    ref.read(goRouterNotifierProvider).authStatus = state.authStatus;
  }

  Future<void> _saveUserCredentials( User user ) async {
    // Token storage
    await SecureStorageHandler.saveToken(user.token);

    // User details storage
    await SecureStorageHandler.saveUser(user.username, user.password);
  }

  void _setUserNotAuthenticated( [ String? errorMessage ]) async {

    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      errorMessage: errorMessage
    );

    // Updates the router provider state
    ref.read(goRouterNotifierProvider).authStatus = AuthStatus.notAuthenticated;

    // Remove credentials from local storage
    await SecureStorageHandler.deleteUser();
    
  }

  // checkAuthStatus
  Future<void> logout( [String? errorMessage] ) async {
    
    try {

      // Logout from server
      await userRepository.logout();
      _setUserNotAuthenticated(errorMessage);

    } catch (e) {

      state = state.copyWith(
        errorMessage: e.toString()
      );

    }

  }

  Future<void> checkAuthStatus() async {

    final userMap = await SecureStorageHandler.getUser();

    // If userMap is null, user is not authenticated
    // This can happen if the user has not logged in before or if the user data is corrupted
    // In this case, we set the user as not authenticated
    if ( userMap == null ) {
      _setUserNotAuthenticated();
      return;
    }

    final user = User(
      username: userMap['username']!,
      password: userMap['password']!,
      token: userMap['token']!,
    );

    // Set the user as authenticated
    _setLoggedUser(user);

  }

}