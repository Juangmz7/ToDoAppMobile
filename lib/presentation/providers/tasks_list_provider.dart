// provider/task/tasks_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/domain/domain.dart';
import 'package:todo_app/presentation/providers/providers.dart';
import 'package:todo_app/states/states.dart';

//TODO: Resolver problema autodispose con el provider
final tasksListProvider = StateNotifierProvider<TasksNotifier, TaskListState>((ref) {
  
  final repository = ref.read(taskRepositoryProvider);
  final taskFilter = ref.watch(taskFilterProvider);
  final date = ref.watch(activeDateProvider);

  final getTaskByFilterCallback = taskFilter.taskFilterSelection == TaskFilterSelection.greaterPriority
                                    ? () => repository.getTasksByDateOrderByPriorityAscending(date) :
                                  taskFilter.taskFilterSelection == TaskFilterSelection.lessPriority
                                    ? () => repository.getTasksByDateOrderByPriorityDescending(date) :
                                    () => repository.getTasksByDate(date);
                                  

  return TasksNotifier(
    taskRepository: repository,
    getTaskByFilterCallback: getTaskByFilterCallback,
  );
});



typedef GetTaskByFilterCallback = Future<List<Task>>Function();

class TasksNotifier extends StateNotifier<TaskListState> {

  final TaskRepository taskRepository;
  final GetTaskByFilterCallback getTaskByFilterCallback;

  TasksNotifier({
    required this.getTaskByFilterCallback,
    required this.taskRepository,
  }) : super(TaskListState()) {
    loadTasks();
  }

  // Tasks initiallization for each new state
  Future<void> loadTasks() async {
    state = state.copyWith(isLoading: true);

    try {

      final tasks = await getTaskByFilterCallback();

      state = state.copyWith(
        tasks: tasks,
        isLoading: false
      );

    } catch (e) {

      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString()
      );

    }

    state = state.copyWith(isLoading: false);

  }


  Future<void> toggleTaskCompletion(int taskId) async {
    // It saves the original state to rollback if error
    final originalState = state;

    final updatedTasks = state.tasks.map((task) {
      if (task.id == taskId) {
        return task.copyWith(isCompleted: !task.isCompleted);
      }
      return task;
    }).toList();

    state = state.copyWith(tasks: updatedTasks);

    try {
      final taskToUpdate = updatedTasks.firstWhere((t) => t.id == taskId);
      await taskRepository.updateTask(taskToUpdate);
    } catch (e) {
      state = originalState; // Revertir en caso de error
    }
  }

  Future<void> updateTaskBody(int taskId, String newBody) async {
    final originalState = state;
    
    final updatedTasks = state.tasks.map((task) {
      
      // If the task id matches, update the body
      if (task.id == taskId) {
        return task.copyWith(body: newBody);
      }

      return task;

    }).toList();

    state = state.copyWith(tasks: updatedTasks);

    try {
      final taskToUpdate = updatedTasks.firstWhere((t) => t.id == taskId);
      await taskRepository.updateTask(taskToUpdate);
    } catch (e) {
      state = originalState; // Revertir en caso de error
    }
  }

  Future<void> updateTaskPriority(int taskId, TaskPriority newPriority) async {
    final originalState = state;

    final updatedTasks = state.tasks.map((task) {
      if (task.id == taskId) {
        return task.copyWith(priority: newPriority);
      }
      return task;
    }).toList();

    state = state.copyWith(tasks: updatedTasks);

    try {
      final taskToUpdate = updatedTasks.firstWhere((t) => t.id == taskId);
      await taskRepository.updateTask(taskToUpdate);
    } catch (e) {
      state = originalState;
    }
  }

  void refreshTaskList(Task task) {
    // Add the new task to the current state
    state = state.copyWith(
      tasks: [...state.tasks, task],
    );
  }

  void createTask({
    required String body,
    required DateTime taskDate,
    required TaskPriority priority

  }) async {

    state = state.copyWith(isLoading: true);

    final taskRequest = TaskRequest(
      body: body,
      isCompleted: false,
      priority: priority,
      date: taskDate
    );

    try {

      final tasks = await taskRepository.createTask(taskRequest);

      state = state.copyWith(
        tasks: [...state.tasks, tasks],
        isLoading: false,
      );

    } catch (e) {

      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );

    }

  }         

}