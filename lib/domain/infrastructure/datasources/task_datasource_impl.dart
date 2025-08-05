
import 'package:dio/dio.dart';
import 'package:todo_app/config/app_config.dart';
import 'package:todo_app/domain/domain.dart';
import 'package:todo_app/domain/infrastructure/mappers/mappers.dart';
import 'package:todo_app/shared/shared.dart';


class TaskDatasourceImpl extends TaskDatasource{

  // Create a Dio instance with the base URL for tasks
  final Dio _dio = createDio(authRequired: true, url: AppConfig.taskUrl);

  List<Task> _jsonToTask ( List<dynamic> jsonList ) {

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


  @override
  Future<List<Task>> getTaskByPriority(TaskPriority priority) async {

    try {

      final response = await _dio.get('/by-priority',
        queryParameters: {
          'priority': priority.name.toUpperCase()
        }
      );

      // Map the response data to a list of Task objects
      return _jsonToTask(response.data);

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

      return _jsonToTask(response.data);

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

      return _jsonToTask(response.data);

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

      return _jsonToTask(response.data);

   } on DioException catch (e) {

    dioExceptionHandler(e);

   } catch (e) {
      throw Exception(e);
   }

    return [];

  }
}