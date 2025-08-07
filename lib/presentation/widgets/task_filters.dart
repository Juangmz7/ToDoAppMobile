
import 'package:flutter/material.dart';
import 'package:todo_app/config/theme/app_theme.dart';
import 'package:todo_app/presentation/presentation.dart';


class TaskFilters extends StatelessWidget {
  
  final TaskFilterDialogCallback taskFilterDialogCallback;

  const TaskFilters({
    super.key,
    required this.taskFilterDialogCallback
  });

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;

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
            child: Text('Mayor prioridad', style: TextStyle(
              color: Colors.black
            ))
          )

          
        ],
      ),
    );
  }
}