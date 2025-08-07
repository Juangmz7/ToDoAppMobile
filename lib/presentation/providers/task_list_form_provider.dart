
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/domain/domain.dart';
import 'package:todo_app/presentation/providers/task_repository_provider.dart';
import 'package:todo_app/states/task_list_form_state.dart';

// Given a task and calling the notifier method, updates it
final taskListFormProvider = StateNotifierProvider.family<TaskListFormNotifier, TaskListFormState, Task>(
  (ref, task) {
    final updateCallback = ref.watch(taskRepositoryProvider).updateTask;
    return TaskListFormNotifier(task, updateCallback);
  }
);

class TaskListFormNotifier extends StateNotifier<TaskListFormState> {

  // This is the task for this request
  // It is the one which is updating and saving it in the newState
  final Task task;
  final Function(Task) updateTaskCallback;

  TaskListFormNotifier(this.task, this.updateTaskCallback)
  :super(TaskListFormState(task: task));


  void updateBodyTask( String newBody ) async {

    // Changes the body of the task state
    state = state.copyWith(
      task: state.task.copyWith(body: newBody)
    );

    await updateTaskCallback(state.task);

  }


  void updateIscompletedTask() async {

      // Toggles the completed flag
    state = state.copyWith(
      task: state.task.copyWith(isCompleted: !state.task.isCompleted)
    );

    await updateTaskCallback(state.task);

  }
  

  void updateTaskPriority( TaskPriority priority ) async {

    state = state.copyWith(
      task: state.task.copyWith(priority: priority)
    );

    await updateTaskCallback(state.task);

  }


}