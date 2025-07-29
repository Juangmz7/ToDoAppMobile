
abstract class UserDatasource {
  
  Future<String> login( String username, String password );

  Future<void> logout();

}