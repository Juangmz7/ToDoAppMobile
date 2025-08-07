// To parse this JSON data, do
//
//     final taskResponse = taskResponseFromMap(jsonString);

import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:todo_app/domain/entities/task.dart';

TaskResponse taskResponseFromMap(String str) => TaskResponse.fromMap(json.decode(str));

String taskResponseToMap(TaskResponse data) => json.encode(data.toMap());

class TaskResponse {
    int id;
    String body;
    TaskPriority priority;
    DateTime taskDate;
    bool completed;

    TaskResponse({
        required this.id,
        required this.body,
        required this.priority,
        required this.taskDate,
        required this.completed,
    });

    factory TaskResponse.fromMap(Map<String, dynamic> json) => TaskResponse(
        id: json["id"],
        body: json["body"],
        // Convert the string priority to TaskPriority enum
        priority: TaskPriority.values.firstWhere(
          (e) => e.name.toUpperCase() == json["priority"].toUpperCase(),
        ),
        taskDate: DateTime.parse(json["taskDate"]),
        completed: json["completed"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "body": body,
        "priority": priority.name.toUpperCase(),
        "taskDate": "${taskDate.year.toString().padLeft(4, '0')}-${taskDate.month.toString().padLeft(2, '0')}-${taskDate.day.toString().padLeft(2, '0')}",
        "completed": completed,
    };

    // Convert DateTime to JSON format 'yyyy-MM-dd'
    static String dateTimeToJsonFormat(DateTime date) => DateFormat('yyyy-MM-dd').format(date);
    static String dateTimeToNormalFormat(DateTime date) => DateFormat('dd/MM/yyyy').format(date);

    static TaskResponse entityToTaskResponse(Task task) => TaskResponse(
      id: task.id,
      body: task.body,
      priority: task.priority,
      taskDate: task.date,
      completed: task.isCompleted
    );
    
}
