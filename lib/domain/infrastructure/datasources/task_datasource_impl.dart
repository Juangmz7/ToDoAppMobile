
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:todo_app/config/app_config.dart';
import 'package:todo_app/domain/domain.dart';
import 'package:todo_app/domain/infrastructure/mappers/mappers.dart';
import 'package:todo_app/shared/shared.dart';


class TaskDatasourceImpl extends TaskDatasource{

  // Create a Dio instance with the base URL for tasks
  final Dio _dio = createDio(authRequired: true, url: AppConfig.taskUrl);

  List<Task> _jsonToTaskList ( List<dynamic> jsonList ) {

    // Map the JSON list to a list of TaskResponse objects
    final tasksResponse = jsonList.map(
      (json) => TaskResponse.fromMap(json) 
    );

    // Convert each TaskResponse object to Task entitie
    return tasksResponse.map(
      (taskResponse) => Task(
        id: taskResponse.id,
        body: taskResponse.body,
        isCompleted: taskResponse.completed,
        priority: taskResponse.priority,
        date: taskResponse.taskDate,
      )
    ).toList();
    
  }

  Task _jsonToEntity ( Map<String, dynamic> json ) {

    // Convert a single JSON object to a TaskResponse object
    final taskResponse = TaskResponse.fromMap(json);

    // Convert the TaskResponse object to a Task entity
    return Task(
      id: taskResponse.id,
      body: taskResponse.body,
      isCompleted: taskResponse.completed,
      priority: taskResponse.priority,
      date: taskResponse.taskDate,
    );
    
  }


  @override
  Future<List<Task>> getTaskByPriority(TaskPriority priority) async {

    try {

      final response = await _dio.get('/by-priority',
        queryParameters: {
          'priority': priority.name.toUpperCase()
        }
      );

      // Map the response data to a list of Task objects
      return _jsonToTaskList(response.data);

    } on DioException catch (e) {

      dioExceptionHandler(e);

    } catch (e) {
      throw Exception(e);
    }

    return [];
    
  }
  

  @override
  Future<List<Task>> getTasksByDate(DateTime date) async {

    try {

      final response = await _dio.get('/by-date',
        queryParameters: {
          'date': TaskResponse.dateTimeToJsonFormat(date)
        }
      );

      return _jsonToTaskList(response.data);

   } on DioException catch (e) {

    dioExceptionHandler(e);

   } catch (e) {
      throw Exception(e);
   }

    return [];

  }

  @override
  Future<List<Task>> getTasksByDateOrderByPriorityAscending(DateTime date) async {

    try {

      final response = await _dio.get('/by-date-order-by-priority-asc',
        queryParameters: {
          'date': TaskResponse.dateTimeToJsonFormat(date) 
        }
      );

      return _jsonToTaskList(response.data);

   } on DioException catch (e) {

    dioExceptionHandler(e);

   } catch (e) {
      throw Exception(e);
   }

    return [];

  }

  @override
  Future<List<Task>> getTasksByDateOrderByPriorityDescending(DateTime date) async {

    try {

      final response = await _dio.get('/by-date-order-by-priority-desc',
        queryParameters: {
          'date': TaskResponse.dateTimeToJsonFormat(date) 
        }
      );

      return _jsonToTaskList(response.data);

   } on DioException catch (e) {

    dioExceptionHandler(e);

   } catch (e) {
      throw Exception(e);
   }

    return [];

  }
  
  @override
  Future<void> updateTask(Task task) async {

    final TaskResponse taskResponse = TaskResponse.entityToTaskResponse(task);

    try {

      await _dio.put('/${task.id}', data: taskResponse.toMap());

    } on DioException catch (e) {
      
      dioExceptionHandler(e);

    } catch (e) {
      throw Exception(e);
    }

  }

  @override
  Future<Task> audioTaskSender(File file) async{
        
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        file.path,
        filename: 'audio_${DateTime.now().millisecondsSinceEpoch}.m4a',
        contentType: DioMediaType('audio', 'm4a') 
      )
    });

    try {
      
      final response = await _dio.post('/audio-gen', data: formData);

      if (response.data == null) {
        throw Exception('No data received from server');
      }

      return _jsonToEntity(response.data);

    } on DioException catch (e) {

      dioExceptionHandler(e);

      throw Exception('Failed to send audio task: ${e.message}');

    } catch (e) {
      throw Exception(e);
    }
    
  }
  
  @override
  Future<Task> createTask(TaskRequest taskRequest) async {
    
    try {

      final response = await _dio.post('', data: taskRequest.toMap());

      if (response.data == null) {
        throw Exception('No data received from server');
      }

      return _jsonToEntity(response.data);

    } on DioException catch (e) {

      dioExceptionHandler(e);
      throw Exception('Failed to send audio task: ${e.message}');

    } catch (e) {
      throw Exception(e);
    }

  }

  

}