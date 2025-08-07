
import 'package:todo_app/domain/domain.dart';

class TaskListFormState {
  
  final Task task;

  TaskListFormState({
    required this.task
  });

  TaskListFormState copyWith ({
    Task? task,
  }) => TaskListFormState(
    task: task ?? this.task
  );


}