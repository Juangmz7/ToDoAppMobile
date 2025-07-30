
import 'package:todo_app/auth/domain/domain.dart';

abstract class UserRepository {
  
  Future<String> login( String username, String password );

  Future<User> register( String username, String password, String email );
  
  Future<void> logout();

  Future<void> forgotPassword( String email );


}