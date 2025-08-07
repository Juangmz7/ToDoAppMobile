
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../states/states.dart';


// Notifier which stores filter changes
final taskFilterProvider = StateNotifierProvider<TaskFilterSelectionNotifier, TaskFilterSelectionState>(
  (ref) => TaskFilterSelectionNotifier()
);

class TaskFilterSelectionNotifier extends StateNotifier<TaskFilterSelectionState> {

  TaskFilterSelectionNotifier()
  :super(TaskFilterSelectionState());

  void onFilterChanged (TaskFilterSelection newSelection) {
    
    if (state.taskFilterSelection == newSelection) return;

    state = state.copyWith(
      taskFilterSelection: newSelection
    );

  }

}