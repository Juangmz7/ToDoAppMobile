

import 'package:flutter/material.dart';
import 'package:todo_app/presentation/widgets/change_task_priority_form.dart';

class ChangeTaskPriorityDialog {

  final int taskId;

  ChangeTaskPriorityDialog({
    required this.taskId
  });

  void openDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Dialog(
            backgroundColor: const Color.fromARGB(255, 29, 3, 100),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: ChangeTaskPriorityForm(taskId: taskId)
            )
          ),
        );
      },
    );

  }

}

