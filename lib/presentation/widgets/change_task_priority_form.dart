import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/domain/domain.dart';
import 'package:todo_app/presentation/providers/providers.dart';
import 'package:todo_app/presentation/widgets/widgets.dart';

class ChangeTaskPriorityForm extends ConsumerWidget {

  final int taskId;
  
  const ChangeTaskPriorityForm({
    super.key,
    required this.taskId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.width * 0.26,

      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.height * 0.06),
        child: Row(
          children: [
        
            Column(
              children: [
        
                CustomFilledButton(
                  label: TaskPriority.urgent.label,
                  backgroundColor: TaskPriority.urgent.color,
                  onPressed: () {

                    ref.read(tasksListProvider.notifier)
                      .updateTaskPriority(taskId, TaskPriority.urgent);
                    
                    context.pop();
                    
                  },
                ),

                const SizedBox(height: 10),
        
                CustomFilledButton(
                  label: TaskPriority.medium.label,
                  backgroundColor: TaskPriority.medium.color,
                  onPressed: () {

                    ref.read(tasksListProvider.notifier)
                      .updateTaskPriority(taskId, TaskPriority.medium);
                    
                    context.pop();
                    
                  },
                )
              ],
            ),

            const SizedBox(width: 20),
        
            Column(
              children: [
        
                CustomFilledButton(
                  label: TaskPriority.high.label,
                  backgroundColor: TaskPriority.high.color,
                  onPressed: () {

                    ref.read(tasksListProvider.notifier)
                      .updateTaskPriority(taskId, TaskPriority.high);
                    
                    context.pop();
                    
                  },
                ),

                const SizedBox(height: 10),
        
                CustomFilledButton(
                  label: TaskPriority.low.label,
                  backgroundColor: TaskPriority.low.color,
                  onPressed: () {

                    ref.read(tasksListProvider.notifier)
                      .updateTaskPriority(taskId, TaskPriority.low);
                    
                    context.pop();
                    
                  },
                )
        
              ],
            )
        
        
        
          ],
        ),
      ),
    );
  }
}