
import 'package:intl/intl.dart';

enum TaskPriority {
  low,
  medium,
  high,
  urgent
}

class Task {
  final int id;
  final String body;
  final bool isCompleted;
  final TaskPriority priority;
  final DateTime date;

  String get formattedDate => DateFormat('dd/MM/yyyy').format(date);

  Task({
    required this.id,
    required this.body,
    required this.isCompleted,
    required this.priority,
    required this.date
  });

  @override
String toString() {
  return 'Task('
      'id: $id, '
      'body: "$body", '
      'isCompleted: $isCompleted, '
      'priority: ${priority.name}, '
      'date: $formattedDate'
      ')';
}

   
}