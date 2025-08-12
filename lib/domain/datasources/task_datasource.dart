
import 'dart:io';

import 'package:todo_app/domain/domain.dart';

abstract class TaskDatasource {

  Future<List<Task>> getTasksByDate(DateTime date);

  Future<List<Task>> getTasksByDateOrderByPriorityAscending(DateTime date);

  Future<List<Task>> getTasksByDateOrderByPriorityDescending(DateTime date);
  
  Future<List<Task>> getTaskByPriority(TaskPriority priority);

  Future<void> updateTask(Task task);

  Future<Task> audioTaskSender(File file);

}