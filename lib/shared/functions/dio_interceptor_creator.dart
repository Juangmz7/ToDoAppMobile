
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Dio createDio( {required bool authRequired, required String url} ) {
    
  final dio = Dio(
    BaseOptions(
      baseUrl: url, // Ensure the API_URL is set in .env
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