

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/domain/entities/task.dart';
import 'package:todo_app/presentation/providers/task_repository_provider.dart';



//* Provider for managing task navigation and fetching tasks by date
final taskByDateProvider = FutureProvider.family<List<Task>, DateTime>(
    (ref, date) {

      final repository = ref.read(taskRepositoryProvider);
      return repository.getTasksByDate(date);

    }
);

final taskByDateOrderByPriorityAsc = FutureProvider.family<List<Task>, DateTime>(
  (ref, date) {
    
    final repository = ref.read(taskRepositoryProvider);
    return repository.getTasksByDateOrderByPriorityAscending(date);

  },
);

final taskByDateOrderByPriorityDesc = FutureProvider.family<List<Task>, DateTime>(
  (ref, date) {
    
    final repository = ref.read(taskRepositoryProvider);
    return repository.getTasksByDateOrderByPriorityDescending(date);

  },
);


