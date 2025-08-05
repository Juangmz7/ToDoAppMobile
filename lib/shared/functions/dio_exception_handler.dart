
import 'package:dio/dio.dart';

void dioExceptionHandler(DioException e) {

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

}