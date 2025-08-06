

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/domain/domain.dart';
import 'package:todo_app/presentation/providers/providers.dart';


//* Provider for managing task navigation and fetching tasks by date

final taskNavigatorProvider = StateNotifierProvider<TaskNavigatorNotifier, List<Task>>(
  (ref) {
    final taskCallback = ref.watch(taskRepositoryProvider).getTasksByDate;
    return TaskNavigatorNotifier(fetchMoreTasks: taskCallback);
  }
   
  
);

typedef TaskCallback = Future<List<Task>> Function(DateTime);

class TaskNavigatorNotifier extends StateNotifier<List<Task>> {

  final TaskCallback fetchMoreTasks;
  bool isLoading = false;
  final DateTime _currentDate = DateTime.now();

  TaskNavigatorNotifier({
    required this.fetchMoreTasks
  }) : super([]);

  Future<void> _loadTasks(DateTime date) async {
    if (isLoading) return;

    isLoading = true;

    final List<Task> newTasks = await fetchMoreTasks(date);
    state = [...newTasks];
    await Future.delayed(Duration(milliseconds: 300));

    isLoading = false;
  }

  Future<void> nextDay() async {
    final nextDate = _currentDate.add(Duration(days: 1));
    await _loadTasks(nextDate);
  }

  Future<void> previousDay() async {
    final previousDate = _currentDate.subtract(Duration(days: 1));
    await _loadTasks(previousDate);
  }

  Future<void> getTodayTasks() async {
    await _loadTasks(DateTime.now());
  }

  DateTime get currentDateTime => _currentDate;

}