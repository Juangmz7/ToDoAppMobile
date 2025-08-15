
import 'dart:io';

import 'package:todo_app/domain/domain.dart';

abstract class TaskRepository {
  
  Future<List<Task>> getTasksByDate(DateTime date);

  Future<List<Task>> getTasksByDateOrderByPriorityAscending(DateTime date);

  Future<List<Task>> getTasksByDateOrderByPriorityDescending(DateTime date);
  
  Future<List<Task>> getTaskByPriority(TaskPriority priority);

  Future<void> updateTask(Task task);

  Future<Task> audioTaskSender(File file);

  Future<Task> createTask(TaskRequest taskRequest);

  Future<List<Task>> searchTasks(String query);
  
}