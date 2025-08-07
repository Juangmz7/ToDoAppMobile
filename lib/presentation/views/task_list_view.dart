
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/domain/domain.dart';
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
    final date = ref.watch(activeDateProvider);

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
          
          const SizedBox(height: 20),
          
          //* Task List
          TaskList(tasks: tasks)

        ],
      ),
    );
  }
}