
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get apiUrl => dotenv.env['API_URL'] ?? 'http://localhost:8081';

  static String get authUrl => '$apiUrl/auth';

  static String get taskUrl => '$apiUrl/api/tasks';
}