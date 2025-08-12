
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum TaskPriority {
  low('Baja', Colors.green),
  medium('Media', Color.fromARGB(255, 187, 176, 16)),
  high('Alta', Colors.orange),
  urgent('Urgente', Colors.red);

  final String label;
  final Color color;
  const TaskPriority(this.label, this.color);
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

  Task copyWith({
  int? id,
  String? body,
  bool? isCompleted,
  TaskPriority? priority,
  DateTime? date,
}) {
  return Task(
    id: id ?? this.id,
    body: body ?? this.body,
    isCompleted: isCompleted ?? this.isCompleted,
    priority: priority ?? this.priority,
    date: date ?? this.date,
  );
}

@override
String toString() {
  return 'Task('
      'id: $id, '
      'body: $body, '
      'isCompleted: $isCompleted, '
      'priority: $priority, '
      'date: $formattedDate'
      ')';
}





   
}