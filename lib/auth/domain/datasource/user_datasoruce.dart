

abstract class UserDatasource {
  
  Future<String> login( String username, String password );

  Future<void> register( String username, String password, String email );

  Future<void> logout();

  Future<void> forgotPassword( String email );

  Future<void> checkEmailToken( String token );

  Future<void> changePassword( String password, String token );
}