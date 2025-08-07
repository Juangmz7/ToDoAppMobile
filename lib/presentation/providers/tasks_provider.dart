

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:todo_app/domain/entities/task.dart';
import 'package:todo_app/presentation/presentation.dart';
import 'package:todo_app/states/states.dart';



//* Provider for managing task navigation and fetching tasks by date
final taskProvider = FutureProvider<List<Task>>((ref) async {
  final date = ref.watch(activeDateProvider);
  final filter = ref.watch(taskFilterProvider).taskFilterSelection;
  final repository = ref.read(taskRepositoryProvider);

  // Decition for which method to use
  if (filter == TaskFilterSelection.greaterPriority) {
    return repository.getTasksByDateOrderByPriorityAscending(date);
  }
   if (filter == TaskFilterSelection.lessPriority) {
    return repository.getTasksByDateOrderByPriorityDescending(date);
  } 
  
  // If there is no filter, get tasks by default
  return repository.getTasksByDate(date);

  }
); 


