
import 'package:dio/dio.dart';
import 'package:todo_app/shared/functions/secure_storage_handler.dart';

Dio createDio( {required bool authRequired, required String url} ) {
    
  final dio = Dio(
    BaseOptions(
      baseUrl: url, 
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 10),
    )
  );

  // Adds the bearer token to each request
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        
        if ( !authRequired ) return handler.next(options);

        if ( await SecureStorageHandler.hasTokenExpired() ) {
          // If the token has expired, it will refresh it
          await SecureStorageHandler.refreshToken();   
        }
        
        final token = await SecureStorageHandler.getToken();

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