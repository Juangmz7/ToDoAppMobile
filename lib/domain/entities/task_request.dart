

import 'package:intl/intl.dart';
import 'package:todo_app/domain/entities/task.dart';

class TaskRequest {
  final String body;
  final bool isCompleted;
  final TaskPriority priority;
  final DateTime date;

  String get formattedDate => DateFormat('dd/MM/yyyy').format(date);

  TaskRequest({
    required this.body,
    required this.isCompleted,
    required this.priority,
    required this.date
  });

  TaskRequest copyWith({
  int? id,
  String? body,
  bool? isCompleted,
  TaskPriority? priority,
  DateTime? date,
}) {
  return TaskRequest(
    body: body ?? this.body,
    isCompleted: isCompleted ?? this.isCompleted,
    priority: priority ?? this.priority,
    date: date ?? this.date,
  );
}

  Map<String, dynamic> toMap() => {
        "body": body,
        "priority": priority.name.toUpperCase(),
        "taskDate": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "completed": isCompleted,
    };
   
}