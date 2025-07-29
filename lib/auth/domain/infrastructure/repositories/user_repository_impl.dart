
import 'package:todo_app/auth/domain/datasource/user_datasoruce.dart';
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

}