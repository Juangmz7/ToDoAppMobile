
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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

        final tokenStorage = FlutterSecureStorage();

        // Verify the token exipration
        final tokenExpiration = await tokenStorage.read(key: 'token_expiration');

        if ( tokenExpiration != null ) {

          final expirationDate = DateTime.parse(tokenExpiration);
          
          // If the token has expired, it refresh it
          if ( expirationDate.isBefore(DateTime.now()) ) {
            SecureStorageHandler.refreshToken();
          }
        }
        
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