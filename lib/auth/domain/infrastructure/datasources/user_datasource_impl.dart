
import 'package:dio/dio.dart';
import 'package:todo_app/auth/domain/datasource/user_datasoruce.dart';

class UserDatasourceImpl extends UserDatasource{

  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.1.145:8081'
      //baseUrl: Enviroment.apiUrl
    )
  );

  @override
  Future<String> login(String username, String password) async {
    
    try {

      // Login post request
      final response = await dio.post('/auth/login',
        data: {
          'username': username,
          'password': password
        }
      );

      // The data response contains the token
      print('TOKEN: ${response.data}');
      return response.data;

    } on DioException catch (e) {
      
      if( e.response?.statusCode == 400 ) { // Bad request state
        throw Exception('Credenciales incorrectas');
      }

      if( e.type == DioExceptionType.connectionTimeout ) {
        throw Exception('Revisar conexion a internet');
      }
      
      throw Exception();

    } catch (e) {
      throw Exception();
    }

    
  }
  
}