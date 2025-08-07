
import 'package:todo_app/domain/datasources/task_datasource.dart';
import 'package:todo_app/domain/entities/task.dart';
import 'package:todo_app/domain/infrastructure/datasources/datasources.dart';
import 'package:todo_app/domain/repositories/repositories.dart';

class TaskRepositoryImpl extends TaskRepository{

  final TaskDatasource taskDatasource;

  TaskRepositoryImpl({
    TaskDatasource? taskDatasource,
  }): taskDatasource = taskDatasource ?? TaskDatasourceImpl();
  

  @override
  Future<List<Task>> getTaskByPriority(TaskPriority priority) {
    return taskDatasource.getTaskByPriority(priority);
  }

  @override
  Future<List<Task>> getTasksByDate(DateTime date) {
    return taskDatasource.getTasksByDate(date);
  }

  @override
  Future<List<Task>> getTasksByDateOrderByPriorityAscending(DateTime date) {
    return taskDatasource.getTasksByDateOrderByPriorityAscending(date);
  }

  @override
  Future<List<Task>> getTasksByDateOrderByPriorityDescending(DateTime date) {
    return taskDatasource.getTasksByDateOrderByPriorityDescending(date);
  }

  @override
  Future<void> updateTask(Task task) async {
    await taskDatasource.updateTask(task);
  }

}