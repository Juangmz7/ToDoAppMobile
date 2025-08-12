
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/config/theme/app_theme.dart';
import 'package:todo_app/presentation/dialogs/dialogs.dart';
import 'package:todo_app/presentation/presentation.dart';


class TaskFilters extends ConsumerWidget {
  
  final TaskFilterDialogCallback taskFilterDialogCallback;

  const TaskFilters({
    super.key,
    required this.taskFilterDialogCallback
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;
    final filter = ref.watch(taskFilterProvider);

    return Container(
      height: size.height * 0.06,
      width: size.width * 0.73,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppTheme.taskBoxColor
      ),
      child: Row(
        children: [

          SizedBox(width: 15),

          Text('Filtrar por: ', style: textStyle.titleSmall),

          const SizedBox(width: 10),

          FilledButton(
            onPressed: () => taskFilterDialogCallback(context),
            style: FilledButton.styleFrom(
              backgroundColor: Colors.lightBlueAccent
            ),
            child: Text(filter.taskFilterSelection.label, style: TextStyle(
              color: Colors.black
            ))
          )

          
        ],
      ),
    );
  }
}