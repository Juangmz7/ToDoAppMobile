
import 'package:todo_app/domain/domain.dart';

abstract class TaskRepository {
  
  Future<List<Task>> getTasksByDate(DateTime date);

  Future<List<Task>> getTasksByDateOrderByPriorityAscending(DateTime date);

  Future<List<Task>> getTasksByDateOrderByPriorityDescending(DateTime date);
  
  Future<List<Task>> getTaskByPriority(TaskPriority priority);
  
}