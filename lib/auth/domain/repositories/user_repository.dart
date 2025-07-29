
abstract class UserRepository {
  
  Future<String> login( String username, String password );
  
  Future<void> logout();

}