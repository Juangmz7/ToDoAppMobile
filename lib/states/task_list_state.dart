// states/task_list_state.dart

import 'package:todo_app/domain/domain.dart';

class TaskListState {
  
  final List<Task> tasks;
  
  final bool isLoading;

  TaskListState({
    this.tasks = const [],
    this.isLoading = true, 
  });


  TaskListState copyWith({
    List<Task>? tasks,
    bool? isLoading,
  }) => TaskListState(
    tasks: tasks ?? this.tasks,
    isLoading: isLoading ?? this.isLoading,
  );

}