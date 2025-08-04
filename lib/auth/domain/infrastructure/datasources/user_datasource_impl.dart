
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:todo_app/auth/domain/datasource/user_datasoruce.dart';
import 'package:todo_app/auth/domain/enitites/user.dart';
import 'package:todo_app/config/app_config.dart';

class UserDatasourceImpl extends UserDatasource{

  Dio _createDio( {required bool authRequired} ) {
    
    final dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.authUrl, // Ensure the API_URL is set in .env
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      )
    );

    // Adds the bearer token to each request
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          
          if ( !authRequired ) return handler.next(options);

          final tokenStorage = FlutterSecureStorage();
          
          final token = await tokenStorage.read(key: 'token');

          if(token != null) {
            // Add the token to the header
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        }, 
      )
    );

    return dio;
  }

  @override
  Future<String> login(String username, String password) async {
    
    try {

      // Login post request
      final dio = _createDio(authRequired: false);
      final response = await dio.post('/login',
        data: {
          'username': username,
          'password': password
        }, 
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
      
      throw Exception(e);

    } catch (e) {
      throw Exception(e);
    }

  }
  
  @override
  Future<void> logout() async {
    
    try {
      
      final dio = _createDio(authRequired: true);
      await dio.post('/logout');

    } on DioException catch (e) {

      if( e.type == DioExceptionType.connectionTimeout ) {
        throw Exception('Revisar conexion a internet');
      }

      if( e.type == DioExceptionType.badResponse ) {
        throw Exception('Error de logout');
      }

    } catch (e) {
      throw Exception(e);
    }
    
  }

  @override
  Future<User> register(String username, String password, String email) async {
    
    try {

      final dio = _createDio(authRequired: false);

      final response = await dio.post('/register',
        data: {
          'username': username,
          'password': password,
          'email': email
        }
      );

      // TODO: Mapper
      //return response.data;
      return User(username: username, password: password, token: 'token', roles: ['roles']);

    } on DioException catch (e) {

      if( e.type == DioExceptionType.badResponse ) {

        if ( e.response != null) {
          final errorMessage = e.response?.data['message'];
          throw Exception(errorMessage); 
        }

      }
      
      if( e.type == DioExceptionType.connectionTimeout ) {
        throw Exception('Revisar conexion a internet');
      }

      throw Exception(e);
      
    } catch (e) {
      throw Exception(e);
    }
    
  }
  
  @override
  Future<void> forgotPassword(String email) async {
    
    try {

      final dio = _createDio(authRequired: false);

      await dio.post('/forgot-password',
        data: {
          'email': email
        }
      );

    } on DioException catch (e) {
      
      // Send the status error
      if( e.type == DioExceptionType.badResponse ) {

        if ( e.response != null) {
          final errorMessage = e.response?.data['message'];
          throw Exception(errorMessage); 
        }

      }      

      if( e.type == DioExceptionType.connectionTimeout ) {
        throw Exception('Revisar conexion a internet');
      }

      throw Exception(e);

    } catch (e) {
      throw Exception(e);
    }
  }
  
  @override
  Future<void> checkEmailToken(String token) async {
    
    try {

      final dio = _createDio(authRequired: false);

      await dio.get('/validate-reset-token',
        queryParameters: {
          'token': token
        }
      );

    } on DioException catch (e) {
      
      // Send the status error
      if( e.type == DioExceptionType.badResponse ) {

        if ( e.response != null) {
          final errorMessage = e.response?.data['message'];
          throw Exception(errorMessage); 
        }

      }      

      if( e.type == DioExceptionType.connectionTimeout ) {
        throw Exception('Revisar conexion a internet');
      }

      throw Exception(e);

    } catch (e) {
      throw Exception(e);
    }
    
  }
  
  @override
  Future<void> changePassword(String password, String token) async {
    
    try {

      final dio = _createDio(authRequired: false);

      await dio.post('/change-password',
        queryParameters: {
          'password': password,
          'token': token
        },
      );

    } on DioException catch (e) {
      
      // Send the status error
      if( e.type == DioExceptionType.badResponse ) {

        if ( e.response != null) {
          final errorMessage = e.response?.data['message'];
          throw Exception(errorMessage); 
        }

      }      

      if( e.type == DioExceptionType.connectionTimeout ) {
        throw Exception('Revisar conexion a internet');
      }

      throw Exception(e);

    } catch (e) {
      throw Exception(e);
    }
  }
  
}