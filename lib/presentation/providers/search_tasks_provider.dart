


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/domain/domain.dart';
import 'package:todo_app/presentation/presentation.dart';


final searchQueryProvider = StateProvider<String>((ref) => '');

final searchTasksProvider = StateNotifierProvider<SearchTasksNotifier, List<Task>>(
  (ref) {
    
    final taskRepository = ref.read( taskRepositoryProvider );

    return SearchTasksNotifier(
      searchTasks: taskRepository.searchTasks,
      ref: ref
    );

});

typedef SearchedTasksCallback = Future<List<Task>> Function(String query);

class SearchTasksNotifier extends StateNotifier<List<Task>> {

  final SearchedTasksCallback searchTasks;
  final Ref ref;
  
  SearchTasksNotifier({
    required this.searchTasks,
    required this.ref
  })
  :super([]);

  Future<List<Task>> searchTaskByQuery (String query) async {

    final tasks = await searchTasks(query);
    ref.read(searchQueryProvider.notifier).update((state) => query);

    state = tasks;

    return tasks;
  }

}