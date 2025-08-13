import 'package:flutter/material.dart';
import 'package:todo_app/presentation/dialogs/create_task_dialog.dart';


class AddTaskButton extends StatelessWidget {

  final double? size;

  const AddTaskButton({
    super.key,
    this.size
  });

  @override
  Widget build(BuildContext context) {

    return FloatingActionButton(
      heroTag: 'add_task_button',
      onPressed: () {
        // Open dialog
        CreateTaskDialog.openDialog(context);
      },
      backgroundColor: const Color.fromARGB(255, 173, 63, 193),
      splashColor: Colors.purple,
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(size ?? 30),
      ),
      child: Icon(
        Icons.add_rounded,
        size: size ?? 30,
        color: Colors.white,
      ),
    );
  }
}