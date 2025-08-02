
import 'package:todo_app/auth/domain/datasource/user_datasoruce.dart';
import 'package:todo_app/auth/domain/enitites/user.dart';
import 'package:todo_app/auth/domain/infrastructure/datasources/user_datasource_impl.dart';
import 'package:todo_app/auth/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository{

  final UserDatasource? userDatasource;

  UserRepositoryImpl({
    UserDatasource? userDatasource
  }) : userDatasource = userDatasource ?? UserDatasourceImpl();

  @override
  Future<String> login(String username, String password) {
    return userDatasource!.login(username, password);
  }
  
  @override
  Future<void> logout() async {
    userDatasource!.logout();
  }

  @override
  Future<User> register(String username, String password, String email) {
    return userDatasource!.register(username, password, email);
  }
  
  @override
  Future<void> forgotPassword(String email) async {
    userDatasource!.forgotPassword(email);
  }
  
  @override
  Future<void> checkEmailToken(int token) async {
    userDatasource!.checkEmailToken(token);
  }
  
  @override
  Future<void> changePassword(String password, int token) async {
    userDatasource!.changePassword(password, token);
  }

}