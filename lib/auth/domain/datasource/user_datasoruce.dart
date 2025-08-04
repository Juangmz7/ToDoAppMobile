
import 'package:todo_app/auth/domain/domain.dart';

abstract class UserDatasource {
  
  Future<String> login( String username, String password );

  Future<User> register( String username, String password, String email );

  Future<void> logout();

  Future<void> forgotPassword( String email );

  Future<void> checkEmailToken( String token );

  Future<void> changePassword( String password, String token );
}