
import 'package:todo_app/domain/entities/task.dart';

enum TaskFilterSelection {
  byDate('Por fecha'),  // Default
  greaterPriority('Mayor prioridad'),
  lessPriority('Menor prioridad'),
  urgent('Urgente'),
  high('Alta'),
  medium('Media'),
  low('Baja');

  final String label;
  const TaskFilterSelection(this.label);
}

class TaskFilterSelectionState {

  final TaskFilterSelection taskFilterSelection;
  
  TaskFilterSelectionState({
    this.taskFilterSelection = TaskFilterSelection.byDate,
  });

  TaskFilterSelectionState copyWith ({
    TaskFilterSelection? taskFilterSelection,
    bool? isLoading,
    List<Task>? tasks
  }) => TaskFilterSelectionState(
    taskFilterSelection: taskFilterSelection ?? this.taskFilterSelection,
  );





}