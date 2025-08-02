

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/auth/domain/domain.dart';

import '../../state/forgot_password_state.dart';


final forgotPasswordProvider = StateNotifierProvider<ForgotPasswordNotifier, ForgotPasswordState>(
  (ref) {

    final userRepository = UserRepositoryImpl();

    return ForgotPasswordNotifier(userRepository: userRepository);

  }
);

class ForgotPasswordNotifier extends StateNotifier<ForgotPasswordState>{

  final UserRepository userRepository;

  ForgotPasswordNotifier({
    required this.userRepository
  }):super(ForgotPasswordState());

// Sends the user email 
  Future<void> forgotPassword( String email ) async {
    
    try {

      await userRepository.forgotPassword(email);

      _validateTokenStatus();

    } catch (e) {
      _setEmailNotSended('Error al enviar email: $e');
    }
    
  }

  Future<void> checkEmailToken( int token ) async {

    try {

      await userRepository.checkEmailToken(token);

      _setEmailSended();

    } catch (e) {
      _invalidateTokenStatus('Error en la validación del token: $e');
    }

  }

  Future<void> changePassword( String password ) async {

    try {
      
      // Server call
      await userRepository.changePassword(password, state.token);

      _validPasswordChange();

    } catch (e) {
      _invalidPasswordChange(e.toString());
    }

  }

  void _invalidPasswordChange( [ String? errorMessage ]) {
    
    state = state.copyWith(
      forgotPasswordStatus: ForgotPasswordStatus.passwordNotAcceptted,
      errorMessage: errorMessage
    );

  }

  void _validPasswordChange() {
    
    state = state.copyWith(
      forgotPasswordStatus: ForgotPasswordStatus.passwordAcceptted,
    );

  }

  void _invalidateTokenStatus( [ String? errorMessage ]) {

    state = state.copyWith(
      forgotPasswordStatus: ForgotPasswordStatus.tokenNotValidated,
      errorMessage: errorMessage
    );

  }

  void _setEmailNotSended( [ String? errorMessage ]) {

    state = state.copyWith(
      forgotPasswordStatus: ForgotPasswordStatus.emailNotSended,
      errorMessage: errorMessage
    );

  }

  void _validateTokenStatus() {

    state = state.copyWith(
      forgotPasswordStatus: ForgotPasswordStatus.tokenValidated
    );
    
  }

  void _setEmailSended() {

    state = state.copyWith(
      forgotPasswordStatus: ForgotPasswordStatus.emailSended
    );

  }

}