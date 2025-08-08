import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/presentation/presentation.dart';

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
    final SwiperController swiperController = SwiperController();

    //* Today index is 500, tommorrow 501, yesterday 499
    final itemCount = 1001;

    return SizedBox(
      height: size.height * 0.65,
      width: size.width * 0.85,
      child: Swiper(
        controller: swiperController,
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
          return _TaskPageLoader(
            swiperController: swiperController,
            date: date
          );

        },


      )
    );
  }
}

class _TaskPageLoader extends ConsumerWidget {

  final DateTime date;
  final SwiperController swiperController;

  const _TaskPageLoader({
    required this.swiperController,
    required this.date
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final activeDate = ref.watch(activeDateProvider);

    if (!date.isAtSameMomentAs(activeDate)) {
      return Center(
        child: CircularProgressIndicator()
      );
    }
  
    // Returns the instance which provides the tasks for the filter state  
    final tasksListState = ref.watch(tasksListProvider(date));
    
    if ( tasksListState.isLoading ) {
      return Center(
        child: CircularProgressIndicator()
      );
    }

    return TaskListView(
      swiperController: swiperController,
      tasks: tasksListState.tasks
    );
    
  }
}