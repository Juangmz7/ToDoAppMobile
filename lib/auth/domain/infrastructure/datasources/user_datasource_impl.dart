
import 'package:dio/dio.dart';

import 'package:todo_app/auth/domain/datasource/user_datasoruce.dart';
import 'package:todo_app/config/app_config.dart';
import 'package:todo_app/shared/functions/functions.dart';

class UserDatasourceImpl extends UserDatasource{


  @override
  Future<String> login(String username, String password) async {
    
    try {

      // Login post request
      final dio = createDio(authRequired: false, url: AppConfig.authUrl);
      final response = await dio.post('/login',
        data: {
          'username': username,
          'password': password
        }, 
      );

      // The data response contains the token
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
      
      final dio = createDio(authRequired: true, url: AppConfig.authUrl);
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
  Future<void> register(String username, String password, String email) async {
    
    try {

      final dio = createDio(authRequired: false, url: AppConfig.authUrl);

      await dio.post('/register',
        data: {
          'username': username,
          'password': password,
          'email': email
        }
      );

    } on DioException catch (e) {

      dioExceptionHandler(e);
      
    } catch (e) {
      throw Exception(e);
    }
    
  }
  
  @override
  Future<void> forgotPassword(String email) async {
    
    try {

      final dio = createDio(authRequired: false, url: AppConfig.authUrl);

      await dio.post('/forgot-password',
        data: {
          'email': email
        }
      );

    } on DioException catch (e) {
      
      dioExceptionHandler(e);

    } catch (e) {
      throw Exception(e);
    }
  }
  
  @override
  Future<void> checkEmailToken(String token) async {
    
    try {

      final dio = createDio(authRequired: false, url: AppConfig.authUrl);

      await dio.get('/validate-reset-token',
        queryParameters: {
          'token': token
        }
      );

    } on DioException catch (e) {
      
      dioExceptionHandler(e);

    } catch (e) {
      throw Exception(e);
    }
    
  }
  
  @override
  Future<void> changePassword(String password, String token) async {
    
    try {

      final dio = createDio(authRequired: false, url: AppConfig.authUrl);

      await dio.post('/change-password',
        queryParameters: {
          'password': password,
          'token': token
        },
      );

    } on DioException catch (e) {
      
      dioExceptionHandler(e);

    } catch (e) {
      throw Exception(e);
    }
  }
  
}