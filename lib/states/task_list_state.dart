// states/task_list_state.dart

import 'package:todo_app/domain/domain.dart';

class TaskListState {
  
  final List<Task> tasks;
  final String? errorMessage;
  final bool isLoading;

  TaskListState({
    this.tasks = const [],
    this.errorMessage = '',
    this.isLoading = true, 
  });


  TaskListState copyWith({
    List<Task>? tasks,
    String? errorMessage,
    bool? isLoading,
  }) => TaskListState(
    tasks: tasks ?? this.tasks,
    isLoading: isLoading ?? this.isLoading,
    errorMessage: errorMessage ?? this.errorMessage,
  );

}