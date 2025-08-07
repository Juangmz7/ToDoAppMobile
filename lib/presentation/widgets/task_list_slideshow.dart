import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/presentation/presentation.dart';
import 'package:todo_app/shared/functions/functions.dart';

class TaskListSlideshow extends ConsumerWidget {
  const TaskListSlideshow({super.key});

  final baseIndex = 500;

  // Date = today + ( index - today )
  DateTime getDateFromIndex (int index) {
    final date = DateTime.now().add(Duration( days: index - baseIndex )); 
    return DateTime(date.year, date.month, date.day);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final size = MediaQuery.of(context).size;

    //* Today index is 500, tommorrow 501, yesterday 499
    final itemCount = 1001;

    return SizedBox(
      height: size.height * 0.65,
      width: size.width * 0.85,
      child: Swiper(
        itemCount: itemCount,
        index: baseIndex,
        loop: false,
        onIndexChanged: (index) {
          final newDate = getDateFromIndex(index);
          
          // Change the date state
          ref.read(activeDateProvider.notifier).state = newDate;

        }, 
        itemBuilder: (context, index) { 
          
          final date = getDateFromIndex(index);

          // Loads the page if it is in date state provider
          return _TaskPageLoader(date: date);

        },


      )
    );
  }
}

class _TaskPageLoader extends ConsumerWidget {

  final DateTime date;

  const _TaskPageLoader({
    required this.date
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final activeDate = ref.watch(activeDateProvider);
    final textStyle = Theme.of(context).textTheme;

    if (!date.isAtSameMomentAs(activeDate)) {
      return Center(
        child: CircularProgressIndicator()
      );
    }

    // Returns the instance which provides the tasks for the filter state  
    final tasksAsync = ref.watch(taskProvider);

    // Future Provider
    return tasksAsync.when(
      data: (data) => TaskListView(tasks: data),
      error: (e, _) => Center(
        child: Text(
          'Error: ${formatException(e.toString())}',
          style: textStyle.titleMedium,
        
        ),
      ),
      loading: () => Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}