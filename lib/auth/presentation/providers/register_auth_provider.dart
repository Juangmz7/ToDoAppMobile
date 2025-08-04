

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:todo_app/auth/domain/domain.dart';
import 'package:todo_app/auth/state/state.dart';

final registerAuthProvider = StateNotifierProvider.autoDispose<RegisterAuthNotifier, RegisterAuthState>((ref) {

  final UserRepository userRepository = UserRepositoryImpl();

  return RegisterAuthNotifier(userRepository: userRepository);
});


class RegisterAuthNotifier extends StateNotifier<RegisterAuthState>{

  final UserRepository userRepository;

  RegisterAuthNotifier({
    required this.userRepository
  }):super(RegisterAuthState());


  void _setRegistrationStateDenied( [ String? errorMessage ] ) {
    
    state = state.copyWith(
      authStatus: AuthStatus.registrationDenied,
      errorMessage: errorMessage
    );

  }

  void _setRegistrationStateAccepted() {
    
    state = state.copyWith(
      authStatus: AuthStatus.registrationSuccess,
    );

  }

  Future<void> registerUser(String username, String password, String email) async {

    // Server registration
    try {

      await userRepository.register(username, password, email);
      
      _setRegistrationStateAccepted();

    } catch (e) {
      _setRegistrationStateDenied(e.toString());
    }

  }

}