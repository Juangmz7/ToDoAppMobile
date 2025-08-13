
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/domain/domain.dart';
import 'package:todo_app/presentation/dialogs/dialogs.dart';
import 'package:todo_app/presentation/presentation.dart';


class TaskListView extends ConsumerWidget {

  final List<Task> tasks;
  final SwiperController swiperController;

  const TaskListView({
    super.key,
    required this.swiperController,
    required this.tasks
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final size = MediaQuery.of(context).size;
    DateTime date = ref.watch(activeDateProvider);

    return SizedBox(
      height: size.height * 0.65,
      width: size.width * 0.85,
      child: Column(
        children: [
    
          //* Date Header
          DateHeader(
            swiperController: swiperController,
            date: date
          ),
    
          IconButton(
            icon: Icon(Icons.calendar_month_rounded, size: size.width * 0.08),
            onPressed: () async {
    
              date = await showDatePickerDialog(
                context: context,
                initialDate: date
              );
    
              // Update the active date in the provider
              ref.read(activeDateProvider.notifier).state = date;
    
              final index = TaskListSlideshow.getIndexFromDate(date);
    
              final offset = index - TaskListSlideshow.baseIndex;
    
              // TODO: Arreglar el problema de que no se mueve al index correcto
              swiperController.move(offset, animation: true);
              
            },
          ),
    
          const SizedBox(height: 10),
          
          //* Task List
          TaskList(tasks: tasks)
    
        ],
      ),
    );
  }
}