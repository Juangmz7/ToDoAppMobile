

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/auth/domain/domain.dart';

import 'package:todo_app/shared/functions/format_exception.dart';
import '../../state/forgot_password_state.dart';


final forgotPasswordProvider = StateNotifierProvider.autoDispose<ForgotPasswordNotifier, ForgotPasswordState>(
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

      _setEmailSended();

    } catch (e) {
      _setEmailNotSended(formatException(e.toString()));
    }
    
  }

  Future<void> checkEmailToken( String token ) async {

    try {

      await userRepository.checkEmailToken(token);
      _validateTokenStatus(token);

    } catch (e) {
      _invalidateTokenStatus(formatException(e.toString()));
    }

  }

  Future<void> changePassword( String password ) async {

    try {
      
      // Server call
      await userRepository.changePassword(password, state.token);
      _validPasswordChange();

    } catch (e) {
      _invalidPasswordChange(formatException(e.toString()));
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
      errorMessage: errorMessage,
      token: null
    );

  }

  void _setEmailNotSended( [ String? errorMessage ]) {

    state = state.copyWith(
      forgotPasswordStatus: ForgotPasswordStatus.emailNotSended,
      errorMessage: errorMessage
    );

  }

  void _validateTokenStatus( String token) {

    state = state.copyWith(
      forgotPasswordStatus: ForgotPasswordStatus.tokenValidated,
      token: token
    );
    
  }

  void _setEmailSended() {

    state = state.copyWith(
      forgotPasswordStatus: ForgotPasswordStatus.emailSended
    );

  }

}