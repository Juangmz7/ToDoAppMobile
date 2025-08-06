
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/domain/infrastructure/repositories/repositories.dart';

final taskRepositoryProvider = Provider((ref) {
  return TaskRepositoryImpl();
});